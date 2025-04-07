// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprisesstaff/constants/apiconstants.dart';
import 'package:hemantenterprisesstaff/constants/colorconstants.dart';
import 'package:hemantenterprisesstaff/constants/imageconstants.dart';
import 'package:hemantenterprisesstaff/constants/searchfield.dart';
import 'package:hemantenterprisesstaff/models/subcategoryList.dart';
import 'package:hemantenterprisesstaff/providers/brandlistprovider.dart';
import 'package:hemantenterprisesstaff/providers/categorylistprovider.dart';
import 'package:hemantenterprisesstaff/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  String? catId;
  String? brandImg;
  String? catName;

  List<SubCat> subCategories = [];
  SubCategoryModel? subCategoryModel;

  @override
  void initState() {
    super.initState();
    fetchSubCategoryData();
  }

  Future<void> fetchSubCategoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    setState(() {
      catId = Provider.of<Categoriesprovider>(context, listen: false).catId;
      brandImg =
          Provider.of<Categoriesprovider>(context, listen: false).brandImg;
      catName = Provider.of<Categoriesprovider>(context, listen: false).catName;
    });
    const String apiUrl = '${ApiConstants.baseUrl}${ApiConstants.catListUrl}';

    print('Fetching categories from: $apiUrl');
    print('Access Token: $token');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        subCategoryModel = SubCategoryModel.fromJson(responseData);

        setState(() {
          subCategories = subCategoryModel?.subCat ?? [];
          print('SubCategories List: $subCategories');
        });
      } else {
        Fluttertoast.showToast(msg: "Data not found");
        print('Error: Data not found. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      print('Exception caught: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandsProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Imageconstants.background),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  hintText: "Search",
                  onSearchTap: () {
                    // Define action for search
                  },
                ),
                SizedBox(height: 2.h),
                // Page title with brand logo and product name
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (brandProvider.brandImg!= null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colorconstants.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colorconstants.brandLogoCircle,
                                width: 1.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                             '${ApiConstants.brandImgBaseUrl}${brandProvider.brandImg}',
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          catName ??
                              "CategoryName", 
                          style: GoogleFonts.instrumentSans(
                            fontSize: 14,
                            color: Colorconstants.darkBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.back(); // Navigate back to Brand Details Screen
                          },
                          child: Text(
                            'Back',
                            style: GoogleFonts.nunitoSans(
                              color: Colorconstants.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Categories grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: subCategories.isEmpty
                      ? Center(
                          child: Text("No SubCategories found"),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: subCategories.length,
                          shrinkWrap:
                              true, // GridView will take only as much space as needed
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevent inner scrolling
                          itemBuilder: (context, index) {
                            SubCat subCat = subCategories[index];

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.productDetail,
                                  // arguments: {
                                  //   'brandImage': brandImagePath,
                                  //   'product': productName,
                                  //   'category':categoryName,
                                  // },
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "${ApiConstants.subCatImgBaseUrl}${subCat.catImage}",
                                        fit: BoxFit.contain,
                                        height: 80,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.error),
                                      )),
                                  const SizedBox(height: 8),
                                  Text(
                                    subCat.catName ?? "",
                                    style: GoogleFonts.instrumentSans(
                                      fontSize: 12,
                                      color: Colorconstants.darkBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
