import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/productlistpage.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'newproductlist.dart';


class NewCarousal extends StatefulWidget {
  const NewCarousal({super.key});

  @override
  State<NewCarousal> createState() => _NewCarousalState();
}

class _NewCarousalState extends State<NewCarousal> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String baseUrl = "http://192.168.29.106:8081";
  String baseUrl1 = "http://192.168.29.106:8081/";

  List<String> myProductImageURLs = [
    'images/carousal.png',
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
  List<String> carosalcatname = [];
  List<int> carosalcatid = [];
  List<int> carosaldashid = [];
  late String Name="";
  late String categoryimage="";
  late String categoryName="";
  late int categoryid;
  late int dashboard3Id;

  void getDataCarosal1() async {
    final Uri url = Uri.parse(
        Constants.ipBaseUrl+'carousel2/view?carousel=carouselDetails'); // Replace with your endpoint

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
          List<int> dashboard3Ids = [];
          List<int> categoryIds = [];
          List<String> categoryNames = [];
          for (var categoryData in responseData) {
            Name = categoryData['title'];
            categoryimage = categoryData['url'];
            categoryid = categoryData['categoryId'];
            categoryName = categoryData['categoryName'];
            dashboard3Id = categoryData['dashboard4Id'];
            Names.add(Name);
            images.add(categoryimage);
            categoryIds.add(categoryid);
            categoryNames.add(categoryName);
            dashboard3Ids.add(dashboard3Id);
          }
          setState(() {
            carosalNames = Names;
            carosalurls = images;
            carosalcatname = categoryNames;
            carosalcatid = categoryIds;
            carosaldashid = dashboard3Ids;
          });
          // Use categoryNames as needed
          print('carosalNames: $carosalNames');
          print('carosalurls: $carosalurls');
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
        child:
        Container(
          height: 295,
          child: Center(
            child: Expanded(
              // Adjust height as needed

              child: Container(
                width: double.infinity,
                height: 291,
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
                    return Stack(children: [
                    Container(
                    child: Image.network(
                      Constants.ipBaseUrl+carosalurls[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 514,
                    ),
                    ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(31),
                              color: Color(0x26000000)),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(30.0),
                            child: Image.asset(
                              "images/Rectangle 224.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 295,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 130,
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
                        right: 10,
                        top: 130,
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
                        top: 40,
                        left: 570,
                        child: Center(
                          child: Column(
                            children: [
                              Text("Your Favourite",
                                  style: TextStyle(fontSize: 36, color: Colors.white)),
                              SizedBox(height: 8.0),
                              Text(carosalNames[index],
                                  // "Fresh Meat Brand",
                                  style: TextStyle(fontSize: 48, color: Colors.white)),
                              SizedBox(height: 8.0),
                              Text("Is Back",
                                  style: TextStyle(fontSize: 36, color: Colors.white)),
                              SizedBox(height: 10.0),
                              InkWell(
                                onTap: () {
                                  if (carosalcatid != null && carosalcatid.isNotEmpty) {
                                    print("2nd carosal catid=$carosalcatid");
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
                                  width: 152,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color(0xf2ffffff)),
                                  child: Center(
                                    child: Text("Shop Now",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],);

                  },
                ),
              ),
            ),
          ),
        ),

    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        myProductImageURLs.length,
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
