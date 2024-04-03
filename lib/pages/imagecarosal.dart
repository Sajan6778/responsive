import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/productlistpage.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'newproductlist.dart';


class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  final String id = 'categoryid';
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String baseUrl = "http://192.168.29.43:8081";
  String baseUrl1 = "http://192.168.29.43:8081/";

  List<String> myProductImageURLs = [
    'images/Group 98.png',
    'images/carosalimg.png',
    // Add more image URLs as needed
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();

    getDataCarosal1();

  }


  List<String> carosalNames = [];
  List<String> carosalurls = [];
  List<String> carosaldes = [];
  List<String> carosalcatname = [];
  List<int> carosalcatid = [];

  List<int> carosaldashid = [];
  late String Name="";
  late String categoryimage="";
  late String description="";
  late String categoryName="";
  late int categoryid;
  late int dashboard3Id;

  void getDataCarosal1() async {
    final Uri url = Uri.parse(
        Constants.ipBaseUrl+'carousel/view?carousel=carouselDetails'); // Replace with your endpoint

    // Define your key-value pairs
    Map<String, dynamic> queryParams = {
      'carousel': 'carouselDetails'
      // Add more key-value pairs as needed
    };

    // Add query parameters to the URL
    Uri uri = url.replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Handle successful response
        print('Carosal Data received: ${response.body}');

        // Parse the response body
        List<dynamic> responseData = jsonDecode(response.body);
        List<dynamic> fishData ;

        if (responseData.isNotEmpty) {
          // Extract category names
          List<String> Names = [];
          List<String> images = [];
          List<String> des = [];
          List<int> dashboard3Ids = [];
          List<int> categoryIds = [];
          List<String> categoryNames = [];
          for (var categoryData in responseData) {
             Name = categoryData['title'];
             categoryimage = categoryData['url'];
             description = categoryData['description'];
             categoryid = categoryData['categoryId'];
             categoryName = categoryData['categoryName'];
             dashboard3Id = categoryData['dashboard3Id'];
            Names.add(Name);
            images.add(categoryimage);
            des.add(description);
            categoryIds.add(categoryid);
            categoryNames.add(categoryName);
            dashboard3Ids.add(dashboard3Id);
          }
          setState(() {
            carosalNames = Names;
            carosalurls = images;
            carosaldes = des;
            carosalcatname = categoryNames;
            carosalcatid = categoryIds;
            carosaldashid = dashboard3Ids;
          });
          // Use categoryNames as needed
          print('carosalNames: $carosalNames');
          print('carosalurls: $carosalurls');
          print('carosaldes: $carosaldes');
          print('carosalcatname: $carosalcatname');
          print('carosalcatid: $carosalcatid');
          print('carosaldashid: $carosaldashid');
        }
      } else {
        // Handle other status codes
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(


              child: Center(
                child: Expanded(
                  // Adjust height as needed

                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 514,
                        child: PageView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: carosalurls.length,
                          controller: _pageController,
                          onPageChanged: (int index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return
                              Stack(
                                children: [
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(31),
                            color: Color(0x26000000)),
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child:

                            carosalurls[index].isNotEmpty &&
                            carosalurls[index] != null &&
                            carosalurls[index].isNotEmpty
                            ? Center(
                              child: Image.network(
                                Constants.ipBaseUrl+carosalurls[index]!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 514,
                              // Add other image properties or widgets as needed
                              ),
                            )
                                : Text(
                            'No image available'),

                            // Image.asset(
                            //   carosalurls[index],
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            //   height: 514,
                            // ),
                            ),
                            ),
                            ),
                                  Positioned(
                                    left: 1200.0,
                                    top: 420.0,
                                    child: _buildPageIndicator(),
                                  ),
                                  Positioned(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 50.0, ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(31),
                                            color: Color(0x26000000)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30.0),
                                          child: Image.asset(
                                            "images/Rectangle 224.png",
                                            fit: BoxFit.contain,
                                            width: double.infinity,
                                            height: 514,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 70,
                                    top: 250,
                                    child: GestureDetector(
                                      onTap: () {
                                        _pageController.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 1350,
                                    top: 250,
                                    child: GestureDetector(
                                      onTap: () {
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 900,
                                    top: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 156,
                                            height: 30.981307983398438,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.490655899047852),
                                                color: Colors.white),
                                            child: Center(
                                              child: Text(
                                                  carosalNames[index],
                                                  // Name,
                                                  // "iphone 13 pro",
                                                  style: TextStyle(fontSize: 19.864015579223633)),
                                            )),
                                        SizedBox(height: 25.0),
                                        // Text("Savings end on 14 Nov",
                                        //     style: TextStyle(
                                        //         fontSize: 41.70984649658203, color: Colors.white)),
                                        // SizedBox(height: 25.0),
                                        Container(
                                          width: 443.0,
                                          height: 90,
                                          child: Text(
                                              carosaldes[index],
                                              // description,
                                              // "Last chance to save up to ₹10000 instantly on eligible "
                                              //     "products with HDFC Bank Credit Cards",
                                              style: TextStyle(fontSize: 22.0, color: Colors.white)),
                                        ),
                                        SizedBox(height: 30.0),
                                        Container(
                                          width: 288,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(31),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 20.0),
                                              Text("View details",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  )),
                                              SizedBox(width: 20.0),
                                              InkWell(
                                                onTap: () {
                                                  if (carosalcatid != null && carosalcatid.isNotEmpty) {
                                                    print("carosalcatid=$carosalcatid");
                                                    int selectedId = carosalcatid[index];
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => NewProductListPage(carosalcatid: [selectedId]),
                                                      ),
                                                    );
                                                  } else {
                                                    print('carosalcatid is empty or null');
                                                    // Handle the scenario where carosalcatid is empty or null
                                                    // You can show a snackbar, dialog, or perform any desired action
                                                  }
                                                },
                                                child: Container(
                                                    width: 136,
                                                    height: 46,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(31),
                                                        color: Color(0xffef8f21)),
                                                    child: Center(
                                                      child: Text("Shop now",
                                                          style: TextStyle(
                                                              fontSize: 18, color: Colors.white)),
                                                    )),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );

                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),

        );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        carosalurls.length,
            (index) => _buildIndicator(index),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        height: 8.0,
        width: (_currentPage == index) ? 24.0 : 8.0,
        decoration: BoxDecoration(
          color:
          (_currentPage == index) ? Color(0xffEF8F21) : Color(0xffEF8F21),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
