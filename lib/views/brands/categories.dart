// ignore_for_file: file_names, avoid_print, deprecated_member_use, unnecessary_brace_in_string_interps, use_build_context_synchronously

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
import 'package:hemantenterprisesstaff/models/categoryList.dart';
import 'package:hemantenterprisesstaff/providers/brandlistprovider.dart';
import 'package:hemantenterprisesstaff/providers/categorylistprovider.dart';
import 'package:hemantenterprisesstaff/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // String? brandid;
  // String? brandImg;
  // String? brandName;
  // String? brandDescription;

  List<Allcategories> categories = [];
  CategoriesModel? categoryModel;

  @override
  void initState() {
    super.initState();
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    Provider.of<BrandsProvider>(context, listen: false);

    // setState(() {
    //   brandid = Provider.of<BrandsProvider>(context, listen: false).brandId;
    //   brandImg = Provider.of<BrandsProvider>(context, listen: false).brandImg;
    //   brandName = Provider.of<BrandsProvider>(context, listen: false).brandName;
    //   brandDescription = Provider.of<BrandsProvider>(context, listen: false).brandDescription;

    // });
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

        categoryModel = CategoriesModel.fromJson(responseData);

        setState(() {
          categories = categoryModel?.allcategories ?? [];
          print('Categories List: $categories');
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

  // final String catImgUrl = ApiConstants.catImgBaseUrl;

  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandsProvider>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
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
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  hintText: "Search",
                  onSearchTap: () {},
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        if (brandProvider.brandImg != null)
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
                            child: Image.network(
                              '${ApiConstants.brandImgBaseUrl}${brandProvider.brandImg}',
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        const SizedBox(width: 10),
                        Text(
                          brandProvider.brandName ?? "Brand",
                          style: GoogleFonts.instrumentSans(
                            fontSize: 14.sp,
                            color: Colorconstants.darkBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Back',
                            style: GoogleFonts.nunitoSans(
                              color: Colorconstants.primaryColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Text(
                          brandProvider.brandDescription ?? 'Brand Description',
                          style: GoogleFonts.instrumentSans(
                              color: Colorconstants.darkBlack, fontSize: 12.sp))
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: categories.isEmpty
                      ? Center(child: Text("No categories found."))
                      : GridView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: categories.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Allcategories allcategories = categories[index];
                            return GestureDetector(
                              onTap: () {
                                final categoriesProvider =
                                    Provider.of<Categoriesprovider>(context,
                                        listen: false);
                                categoriesProvider.setCatDetails(
                                  allcategories.id.toString(),
                                  '${ApiConstants.brandImgBaseUrl}${brandProvider.brandImg}', 
                                  allcategories.catName ?? "", 
                                );

                                Get.toNamed(AppRoutes.subCategory);
                                print('Brand tapped: ${allcategories.catName}');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${ApiConstants.catImgBaseUrl}${allcategories.catImage}',
                                      fit: BoxFit.contain,
                                      height: 80,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    allcategories.catName ?? "",
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
