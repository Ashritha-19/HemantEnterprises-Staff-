// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprisesstaff/constants/colorconstants.dart';
import 'package:hemantenterprisesstaff/constants/imageconstants.dart';
import 'package:hemantenterprisesstaff/constants/searchfield.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CustomerQuotesScreen extends StatefulWidget {
  const CustomerQuotesScreen({super.key});

  @override
  State<CustomerQuotesScreen> createState() => _CustomerQuotesScreenState();
}

class _CustomerQuotesScreenState extends State<CustomerQuotesScreen> {
  String selectedYear =
      DateTime.now().year.toString(); // Default to current year
  late List<String> years; // Dynamic Year List
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]; // All months

  Map<String, bool> expandedMonths = {}; // Track expanded months

  @override
  void initState() {
    super.initState();

    // Generate years from 1990 to current year dynamically
    years = List.generate(
        DateTime.now().year - 1990 + 1, (index) => (1990 + index).toString());

    // Initialize all months as collapsed
    for (var month in months) {
      expandedMonths[month] = false;
    }
    // expandedMonths["April"] = true; // Default open April
  }

  Future<File?> downloadFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$filename");

      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      print("Error downloading file: $e");
      return null;
    }
  }

  void openPDF() async {
    String pdfUrl =
        "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
    File? file = await downloadFile(pdfUrl, "sample.pdf");

    if (file != null) {
      Get.to(() => Scaffold(
            appBar: AppBar(
                title: Text(
              "Customer Quote",
              style: GoogleFonts.instrumentSans(
                  color: Colorconstants.darkBlack, fontSize: 18),
            )),
            body: PDFView(filePath: file.path),
          ));
    } else {
      print("Failed to load PDF");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
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
          Column(
            children: [
              // Search Bar
              CustomAppBar(
                hintText: "Search",
                onSearchTap: () {
                  // Define action for search
                },
              ),

              SizedBox(
                height: 2.h,
              ),

              // Year Dropdown with Border Radius
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Customer Quotes',
                        style: GoogleFonts.instrumentSans(
                          color: Colorconstants.darkBlack,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colorconstants.primaryColor, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedYear,
                            items: years.map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year,
                                    style: GoogleFonts.instrumentSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedYear = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 2.h,
              ),

              Divider(
                thickness: 1,
                height: 1,
                color: Colorconstants.brandLogoCircle,
              ),

              SizedBox(
                height: 2.h,
              ),
              // Months List
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: months.map((month) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Card(
                          elevation:
                              4, // You can adjust the elevation for card shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Adjust border radius if needed
                          ),
                          child: Column(
                            children: [
                              // Month Title (plain, no divider)
                              ExpansionTile(
                                title: Text(
                                  month,
                                  style: GoogleFonts.instrumentSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                initiallyExpanded: expandedMonths[month]!,
                                onExpansionChanged: (isExpanded) {
                                  setState(() {
                                    expandedMonths[month] = isExpanded;
                                  });
                                },
                              ),
                              // Show Customer Quotes List only when the month is expanded
                              if (expandedMonths[month]!)
                                ..._buildCustomerQuotesList(),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // List of customer quotes under each month
  List<Widget> _buildCustomerQuotesList() {
    return List.generate(5, (index) {
      return ListTile(
        title: Text(
          "Name here",
          style: GoogleFonts.instrumentSans(
              color: Colorconstants.darkBlack, fontSize: 12.sp),
        ),
        trailing: ElevatedButton(
          onPressed: openPDF,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, elevation: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "View",
                style: GoogleFonts.instrumentSans(
                    color: Colors.black,
                    fontSize: 12,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.picture_as_pdf, color: Colors.red),
            ],
          ),
        ),
      );
    });
  }
}
