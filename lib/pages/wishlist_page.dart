import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:http/http.dart' as http;
import 'package:responsive/pages/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Aboutus.dart';
import 'Cartpage.dart';
import 'Login.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'dropdown_model.dart';
import 'faqpage.dart';
import 'newproductlist.dart';
import 'order_orderhistory.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 77.0),
      //   child: AppBar(
      //     automaticallyImplyLeading: false,
      //     backgroundColor: Colors.black,
      //     title: Padding(
      //       padding: const EdgeInsets.only(left: 50.0, top: 20.0),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Text("Order Tracking : ",
      //               style: TextStyle(fontSize: 20.0, color: Colors.white)),
      //           // ShaderMask(
      //           //   shaderCallback: (bounds) =>
      //           //       LinearGradient(colors: [Colors.white, Color(0xffD8D8D8)])
      //           //           .createShader(bounds),
      //           //   child:
      //           Text(
      //               "Take advantage of our time to save event | Satisfaction guaranteed * ",
      //               style: TextStyle(fontSize: 14.0, color: Colors.white)),
      //           // )
      //         ],
      //       ),
      //     ),
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 50.0, top: 20.0),
      //         child: IntrinsicHeight(
      //           child: Row(
      //             children: [
      //               TextButton(
      //                 onPressed: () {},
      //                 child: Text("Language",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 20,
      //                     )),
      //               ),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               Container(
      //                   height: 30,
      //                   color: Colors.white,
      //                   child: VerticalDivider(width: 2, color: Colors.white)),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               IconButton(
      //                   icon: const Icon(
      //                     Icons.location_on_outlined,
      //                     color: Colors.white,
      //                   ),
      //                   // tooltip: 'Show Snackbar',
      //                   onPressed: () {}),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               Container(
      //                   height: 30,
      //                   color: Colors.white,
      //                   child: VerticalDivider(width: 2, color: Colors.white)),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               TextButton(
      //                 onPressed: () {},
      //                 child: Text("Account",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 20,
      //                     )),
      //               ),
      //               IconButton(
      //                   icon: const Icon(
      //                     Icons.person_outline,
      //                     color: Colors.white,
      //                   ),
      //                   // tooltip: 'Show Snackbar',
      //                   onPressed: () {}),
      //               SizedBox(
      //                 width: 50.0,
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: MyScrollableColumn(), // Assuming RegisterPage contains the widget
    );
  }
}

List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];

class MyScrollableColumn extends StatefulWidget {
  @override
  _MyScrollableColumnState createState() => _MyScrollableColumnState();
}

class _MyScrollableColumnState extends State<MyScrollableColumn> with WidgetsBindingObserver{
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  String baseUrl = "http://192.168.29.43:8081";
  String baseUrl1 = "http://192.168.29.43:8081/";

  var product_list = [
    {
      "image": "images/fish.png",
      "name": "Men Hoodie",
      "price": "₹ 1452",
      "mrp": "₹ 1568"
    },
    {
      "image": "images/mobile.png",
      "name": "Women pink top",
      "price": "₹ 1452",
      "mrp": "₹ 1568"
    },
    {
      "image": "images/jewells.png",
      "name": "Men Black Hoodie",
      "price": "₹ 1800",
      "mrp": "₹ 2000"
    },
    {
      "image": "images/meat.png",
      "name": "Men Black jocket",
      "price": "₹ 500",
      "mrp": "₹ 740"
    },
    {
      "image": "images/jewells.png",
      "name": "Men Black jocket",
      "price": "₹ 1800",
      "mrp": "₹ 2000"
    },
    {
      "image": "images/meat.png",
      "name": "Men Black jocket",
      "price": "₹ 500",
      "mrp": "₹ 740"
    },
    {
      "image": "images/fish.png",
      "name": "Men Hoodie",
      "price": "₹ 1452",
      "mrp": "₹ 1568"
    },
    {
      "image": "images/mobile.png",
      "name": "Women pink top",
      "price": "₹ 1452",
      "mrp": "₹ 1568"
    },
  ];

  late List<dynamic> responseData=[];

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  String productName="";
  String productImage="";
  List<String> productNames = [];
  List<String> productImages = [];
  List<double> totalPrice = [];
  List<double> totalMrp = [];
  List<dynamic>  productVarientImagesIdValues = [];
  double priceValue = 0.0;
  double mrpValue = 0.0;
  dynamic productVarientImagesIdValue ;
  late int productListIdValue;
  late dynamic varientImagesIdValue;

  Future<void> getWishlistData() async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl+'wishListProductDetailsByUser';

    try {
      final url = Uri.parse('$baseUrl/$userId');

      try {
        final response = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
           responseData = jsonDecode(response.body);

          print('Data for User ID $userId: $responseData');


           List<String> Names = [];
           List<String> images = [];
           List<double> price = [];
           List<double> mrp = [];
           List<dynamic>  productVarientImagesId = [];

           for (var categoryData in responseData) {
              productName = categoryData['productName'];
             print("productName: $productName");
             productImage = categoryData['productVarientImageUrl'];
              priceValue = categoryData['totalAmount'];
              mrpValue = categoryData['mrp'];
              productVarientImagesIdValue = categoryData['productVarientImagesId'];
             Names.add(productName);
             images.add(productImage);
              price.add(priceValue);
              mrp.add(mrpValue);
              productVarientImagesId.add( productVarientImagesIdValue);
           }
           setState(() {
             productNames = Names;
             productImages = images;
             totalPrice = price;
             totalMrp = mrp;
             productVarientImagesIdValues = productVarientImagesId;
           });

           print('Product Names: $productNames');
           print('Total Price: $totalPrice');
           print('Total Mrp: $totalMrp');


        } else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  late List<dynamic> responseProductDatas=[];

  Future<void> onRefresh() async {
    await getWishlistData();
  }


  void postWishlist() async {
    int? userId = await getUserId();
    print("userId: $userId");
    print("productListId: $productListIdValue");

    if (userId != null) {
      final Uri url = Uri.parse(Constants.ipBaseUrl + 'wishList/save');

      // Replace 'userIdValue' with the actual ID value
      Map<String, dynamic> queryParamsMobile = {
        'userId': userId.toString(),
        'productListId': productListIdValue.toString(),
        'productVarientImagesId': varientImagesIdValue.toString(),
        // Convert to String
      };

      Uri uri = url.replace(queryParameters: queryParamsMobile);

      try {
        final responseWishlist = await http.post(uri);

        if (responseWishlist.statusCode == 200) {
          print('response Wishlist: ${responseWishlist.body}');
          final responseData = json.decode(responseWishlist.body);

          if (responseData is Map<String, dynamic> &&
              responseData.containsKey('Message')) {
            Message = responseData['Message'];
            showToast();
          } else {
            print('Invalid response format: $responseData');
          }
        } else {
          print('Request failed with status: ${responseWishlist.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('User ID not available');
      // Handle the case where userId is not available
    }
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: Message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      webBgColor: '#FF8911',
      timeInSecForIosWeb: 3,
      // backgroundColor: Color(0x2bef8f21),
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }


  @override
  void initState() {
    super.initState();
    getWishlistData();
    WidgetsBinding.instance?.addObserver(this);
    _initializeState();
  }

  final AuthService authService = AuthService();

  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshPage();
    }
  }


  Future<void> refreshPage() async {
    // Implement your refresh logic here
    await Future.delayed(Duration(seconds: 2)); // Simulating a refresh delay

    setState(() {
      getWishlistData();
    });
  }


  String Message="";

  late List<dynamic> responseProductData = [];
  // void postCart() async {
  //   print("productListId:$productListIdValue");
  //   print("productVarientImagesId:$varientImagesIdValue");
  //   int? userId = await getUserId();
  //
  //   if (userId != null) {
  //     final Uri url = Uri.parse(Constants.ipBaseUrl+'cartDetails/save');
  //
  //
  //     Map<String, dynamic> queryParamsMobile = {
  //       'userId': userId.toString(),
  //       'productListId': productListIdValue.toString(),
  //       'productVarientImagesId': varientImagesIdValue.toString(),
  //
  //     };
  //
  //     Uri uri = url.replace(queryParameters: queryParamsMobile);
  //
  //     try {
  //       final responseAddCart = await http.post(uri);
  //
  //       if (responseAddCart.statusCode == 200) {
  //         print('response AddToCart: ${responseAddCart.body}');
  //         responseProductData = jsonDecode(responseAddCart.body);
  //         final responseData = json.decode(responseAddCart.body);
  //         // Message = responseData['message'];
  //         // showToast();
  //
  //       } else {
  //         print('Request failed with status: ${responseAddCart.statusCode}');
  //       }
  //     } catch (error) {
  //       print('Error: $error');
  //     }
  //   } else {
  //     print('User ID not available');
  //   }
  // }


  void postCart() async {
    print("productListId: $productListIdValue");
    print("productVarientImagesId: $varientImagesIdValue");
    int? userId = await getUserId();

    if (userId != null) {
      final Uri url = Uri.parse(Constants.ipBaseUrl + 'cartDetails/save');

      Map<String, dynamic> queryParamsMobile = {
        'userId': userId.toString(),
        'productListId': productListIdValue.toString(),
        'productVarientImagesId': varientImagesIdValue.toString(),
      };

      Uri uri = url.replace(queryParameters: queryParamsMobile);

      try {
        final responseAddCart = await http.post(uri);

        if (responseAddCart.statusCode == 200) {
          print('response AddToCart: ${responseAddCart.body}');
          final responseData = json.decode(responseAddCart.body);

          if (responseData is Map<String, dynamic> &&
              responseData.containsKey('message')) {
            Message = responseData['message'];
            showToast();
          } else {
            print('Invalid response format: $responseData');
          }
        } else {
          print('Request failed with status: ${responseAddCart.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('User ID not available');
    }
  }


  Future<List<DropdownModel>> getPost() async {
    try {
      final categoryResponse = await http.get(
        Uri.parse(Constants.ipBaseUrl + 'category?CategoryImage=CategoryDetail'),
      );

      if (categoryResponse.statusCode == 200) {
        final List<dynamic> body = json.decode(categoryResponse.body);

        if (body is List) {
          final List<DropdownModel> dropdownModels = body.map((e) {
            final map = e as Map<String, dynamic>;
            return DropdownModel(
              categoryId: map['categoryId'],
              categoryName: map['categoryName'],
              categoryImage: map['categoryImage'],
              url: map['url'],
            );
          }).toList();

          return dropdownModels;
        } else {
          // Return an empty list if the response body is not a List
          return [];
        }
      }
    } catch (error) {
      // Handle exceptions
      print("Error fetching data: $error");
      throw Exception("Error fetching data");
    }

    // Return an empty list if an error occurs
    return [];
  }
  var selectedValue;
  late String search;
  TextEditingController searchController = TextEditingController();

  late List<dynamic> responseProfile=[];
  String userImageUrl='';

  Future<void> getUserProfileDetails() async {
    int? userId = await getUserId();
    print("this my user Id:$userId");
    final String baseUrl = Constants.ipBaseUrl + 'userProfileDetails';

    try {
      final url = Uri.parse('$baseUrl/$userId');

      try {
        final response = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          responseProfile = jsonDecode(response.body);
          print('ProfileData for User ID $userId: $responseProfile');

          for (var userData in responseProfile) {
            setState(() {
              userImageUrl = userData['userProfileImageUrl'] ?? ''; // Use '' if 'userName' is null
              print("userImageUrl: $userImageUrl");


            });
          }
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => onRefresh(),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Other widgets in the Column
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardPage()),
                          );
                        },
                        child: Image.asset(
                          "images/image 46.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Row(
                        children: [
                          // Container(
                          //   width: 182,
                          //   height: 51,
                          //   decoration: BoxDecoration(
                          //     color: Color(0x0c9c271b),
                          //     shape: BoxShape.rectangle,
                          //     border: Border.all(color: Color(0xffD2D2D2)),
                          //     borderRadius: BorderRadius.horizontal(
                          //       left: Radius.circular(50.0),
                          //     ),
                          //   ),
                          //   child: Center(
                          //       child: DropdownButton<String>(
                          //         value: dropdownValue,
                          //         underline:
                          //         Container(), // This removes the underline
                          //         onChanged: (String? value) {
                          //           setState(() {
                          //             dropdownValue = value!;
                          //           });
                          //         },
                          //         items: list.map((String value) {
                          //           return DropdownMenuItem<String>(
                          //             value: value,
                          //             child: Text(
                          //               value,
                          //               style: TextStyle(
                          //                 fontSize: 18,
                          //               ),
                          //             ),
                          //           );
                          //         }).toList(),
                          //       )),
                          // ),
                          Container(
                              width: 300,
                              height: 51,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffD2D2D2)),
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(50.0),
                                ),
                              ),
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(20),
                                ),
                              )),
                          Stack(
                            children: [
                              Container(
                                width: 52,
                                height: 51,
                                decoration: BoxDecoration(
                                  color: Color(0xffef8f21),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Color(0xffD2D2D2)),
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(50.0),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5.0,
                                left: 3.0,
                                child: IconButton(
                                  onPressed: () {
                                    search=searchController.text.trim();
                                    print("search:$search");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SearchDetailsPage(searchText: search)),
                                    );
                                    // Reset the search query when navigating back
                                    setState(() {
                                      searchController.text = '';
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              bool isAuthenticated = await authService.isAuthenticated();
                              if (isAuthenticated) {
                                getUserProfileDetails();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                              }
                            },
                            child: CircleAvatar(
                              radius: 30.0,

                              backgroundImage: NetworkImage(Constants.ipBaseUrl + userImageUrl),
                              child: (userImageUrl != null && userImageUrl.isNotEmpty)
                                  ? null // No child if NetworkImage is available
                                  : Image.asset('images/pic.png'),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Image.asset(
                            "images/Notification (2).png",
                            width: 25.0,
                            height: 25.0,
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderHistoryPage()));
                            },
                            child: Image.asset(
                              "images/package.png",
                              width: 25.0,
                              height: 25.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishlistPage()));
                            },
                            child: Image.asset(
                              "images/Heart.png",
                              width: 25.0,
                              height: 25.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage()));
                            },
                            child: Image.asset(
                              "images/Add to basket.png",
                              width: 25.0,
                              height: 25.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  width: screenSize.width,
                  height: 77,
                  child: Row(
                    children: [
                      // Stack(
                      //   children: [
                      //     Container(
                      //       width: 310,
                      //       height: 77,
                      //       decoration: BoxDecoration(
                      //         color: Color(0xffef8f21),
                      //         shape: BoxShape.rectangle,
                      //         border: Border.all(color: Color(0xffD2D2D2)),
                      //       ),
                      //       child: Padding(
                      //         padding:
                      //         const EdgeInsets.symmetric(horizontal: 50.0),
                      //         child: Center(
                      //             // child: DropdownButton<String>(
                      //             //   dropdownColor: Color(0xffef8f21),
                      //             //   value: dropdownValues,
                      //             //   icon: Visibility(
                      //             //       visible: false,
                      //             //       child: Icon(Icons.arrow_downward)),
                      //             //   underline:
                      //             //   Container(), // This removes the underline
                      //             //   onChanged: (String? value) {
                      //             //     setState(() {
                      //             //       dropdownValues = value!;
                      //             //     });
                      //             //   },
                      //             //   items: categoryNames.map((String value) {
                      //             //     return DropdownMenuItem<String>(
                      //             //       value: value,
                      //             //       // Set your desired background color here
                      //             //       child: Padding(
                      //             //         padding: const EdgeInsets.only(left: 45.0),
                      //             //         child: Text(
                      //             //           value,
                      //             //           style: TextStyle(
                      //             //               color: Colors.white, fontSize: 20),
                      //             //         ), // Adjust padding as needed
                      //             //         // child: Text(
                      //             //         //   value,
                      //             //         //   style: TextStyle(
                      //             //         //       color: Colors.white, fontSize: 24),
                      //             //         // ),
                      //             //       ),
                      //             //     );
                      //             //   }).toList(),
                      //             // )),
                      //           child: DropdownButton<String>(
                      //             value: dropdownValues,
                      //             onChanged: (String? value) {
                      //               setState(() {
                      //                 dropdownValues = value!;
                      //               });
                      //             },
                      //             items: categoryNames.isNotEmpty
                      //                 ? categoryNames.map((String value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(value),
                      //               );
                      //             }).toList()
                      //                 : [], // Don't build the dropdown if categoryNames is empty
                      //           ),
                      //       ),
                      //     ),
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.only(top: 26.0, left: 50.0),
                      //       child: Icon(
                      //         Icons.menu,
                      //         color: Colors.white,
                      //         size: 25.0,
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      FutureBuilder<List<DropdownModel>>(
                        future: getPost(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Text('No data available');
                          } else {
                            return GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                width: 320,
                                height: 77,
                                decoration: BoxDecoration(
                                  color: Color(0xffef8f21),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Color(0xffD2D2D2)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      underline:  Container(),
                                      dropdownColor: Color(0xffef8f21),
                                      value: selectedValue,
                                      icon: Container(
                                          margin: EdgeInsets.only(left: 30.0),
                                          child: Icon(Icons.menu, size: 25.0,color: Colors.white)),
                                      hint: Text("All Categories",style: TextStyle(
                                          color: Colors.white, fontSize: 22),),
                                      items: snapshot.data!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.categoryName.toString(),
                                          child: Text(e.categoryName ?? '', style: TextStyle(
                                              color: Colors.white, fontSize: 22),),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });


                                        DropdownModel selectedCategory = snapshot.data!.firstWhere(
                                              (element) => element.categoryName == selectedValue,
                                        );
                                        print("Selected categoryId: ${selectedCategory.categoryId}");

                                        // Navigate to the NextPage with the selected categoryId
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewProductListPage(carosalcatid: [selectedCategory.categoryId ?? 0]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        width: 820,
                        height: 77,
                        decoration: BoxDecoration(
                          color: Color(0x0c9c271b),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(0xffD2D2D2)),
                        ),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(width: 20.0),
                        //     Text("Home",
                        //         style:
                        //         TextStyle(fontSize: 20, color: Colors.black)),
                        //     SizedBox(width: 20.0),
                        //     Text("Mobile",
                        //         style:
                        //         TextStyle(fontSize: 20, color: Colors.black)),
                        //     SizedBox(width: 20.0),
                        //     Text("Meat",
                        //         style:
                        //         TextStyle(fontSize: 20, color: Colors.black)),
                        //     SizedBox(width: 20.0),
                        //     Text("Fish",
                        //         style:
                        //         TextStyle(fontSize: 20, color: Colors.black)),
                        //     SizedBox(width: 20.0),
                        //     Text("Vegetables",
                        //         style:
                        //         TextStyle(fontSize: 20, color: Colors.black)),
                        //     SizedBox(width: 20.0),
                        //   ],
                        // ),
                      ),
                      Container(
                        width: 298,
                        height: 77,
                        decoration: BoxDecoration(
                          color: Color(0xffef8f21),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(0xffD2D2D2)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20.0),
                            Image.asset("images/Online support.png"),
                            SizedBox(width: 20.0),
                            Text("+00 123 456 789",
                                style:
                                TextStyle(fontSize: 20, color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Home",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black)),
                                SizedBox(
                                  width: 10.0,
                                ),
                                IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    // tooltip: 'Show Snackbar',
                                    onPressed: () {}),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Whishlist",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black)),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              children: [
                                Text("My Wishlist",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("${responseData.length}  items",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            SizedBox(height: 50.0),
                            Container(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: responseData.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _crossAxisCount(context),
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                  mainAxisExtent: 500,
                                ),
                                itemBuilder: (context, index) {


                                  int ProductListId = responseData[index]['productListId'];
                                  print('i am selected: $ProductListId');

                                  dynamic productVarientImagesId = responseData[index]['productVarientImagesId'];
                                  print(' selected: $productVarientImagesId');

                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 350,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffC2C2C2)),
                                              color: Color(0x21a02a1e),
                                            ),
                                            child:  Constants.ipBaseUrl+productImages[index] != null ?
                                            Image.network(
                                              fit: BoxFit.contain,
                                                Constants.ipBaseUrl+productImages[index]!,
                                              width: 200.8800048828125,
                                              height: 209.58740234375)
                                                    : Text(
                                                'No image available'),

                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: GestureDetector(
                                                onTap:(){

                                                },
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      top: 1.0,
                                                      left: 1.0,
                                                      child: Image.asset(
                                                          "images/Ellipse 20.png"),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        productListIdValue = ProductListId;
                                                        varientImagesIdValue=productVarientImagesId;
                                                        postWishlist();
                                                        setState(() {
                                                          responseData
                                                              .removeAt(
                                                              index);
                                                        });
                                                      },
                                                      icon: Icon(Icons.close),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffC2C2C2)),
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              productNames[index]!,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Price:",
                                                    style: TextStyle(
                                                        fontSize:
                                                            17.874778747558594,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                    totalPrice[index].toString()!,
                                                    style: TextStyle(
                                                        fontSize:
                                                            17.874778747558594,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 7.0),
                                                    child: Text(
                                                        "MRP: ${totalMrp[index].toString()!}",
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Color(0xff717171),
                                                          fontSize:
                                                              11.15052604675293,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          productListIdValue = ProductListId;
                                          print("productListIdValue:$productListIdValue");
                                          varientImagesIdValue=productVarientImagesId;
                                          // print("productVarientImagesId:$productVarientImagesId");
                                          postCart();
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             CartPage()));
                                        },
                                        child: Container(
                                          width: 326,
                                          height: 102,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffC2C2C2)),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Move to Cart",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                  )),
                                              SizedBox(width: 10.0),
                                              Image.asset("images/Chevron.png"),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: Icon(Icons
                                              //         .arrow_forward_ios_outlined))
                                            ],
                                          ),
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
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: screenSize.width,
                      height: 350,
                      decoration: BoxDecoration(color: Color(0xe5ef8f21)),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("KK BAZAR",
                                    style: TextStyle(
                                        fontSize: 30.61224365234375,
                                        color: Colors.white)),
                                Container(
                                  width: 303.0,
                                  height: 100.0,
                                  child: Text(
                                      "Lorem ipsum dolor sit amet consectetur. Volutpat suspendisse nulla elementum sed. Consectetur phasellus tortor pretium netus",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/Instagram.png",
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Image.asset(
                                      "images/Whatsapp.png",
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Image.asset(
                                      "images/Youtube.png",
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Image.asset(
                                      "images/Twitter.png",
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Information",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    )),
                                SizedBox(
                                  height: 30.0,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                                  },
                                  child: Text("About us",
                                      style:
                                      TextStyle(fontSize: 18, color: Colors.white)),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Delivery Information",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                                SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>privacyPolicyPage()));
                                  },
                                  child: Text("Privacy Policy",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Contact info",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    )),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text("phone: 9876543212",
                                    style:
                                    TextStyle(fontSize: 18, color: Colors.white)),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Email: kkbazar@gmail.com",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("www.kkbazar.com",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Need Help?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    )),
                                SizedBox(
                                  height: 20.0,
                                ),

                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>faqPage()));
                                  },
                                  child: Text("FAQ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Contact Us",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: 200,
                      decoration: BoxDecoration(color: Color(0x21ef8f21)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.0,
                          ),
                          Text(
                              "Our Store | Shippping | Payments | Checkout | Discount | Term & Condition | Policy Shipping",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          SizedBox(
                            height: 30.0,
                          ),
                          Image.asset(
                            "images/image 1.png",
                            width: 144,
                            height: 15.75,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text("© 2022 copyrights reserved",
                              style: TextStyle(fontSize: 20, color: Colors.black))
                        ],
                      ),
                    )
                  ],
                ),

                // Other widgets after the scrollable content
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _crossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 6; // Show 4 items in a row for larger screens
    } else if (screenWidth > 800) {
      return 4; // Show 4 items in a row for larger screens
    } else if (screenWidth > 600) {
      return 3; // Show 4 items in a row for larger screens
    } else {
      return 2; // Show 2 items in a row for smaller screens
    }
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  // void showToast() {
  //   Fluttertoast.showToast(
  //     msg: Message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.TOP,
  //     webBgColor: '#FF8911',
  //     timeInSecForIosWeb: 3,
  //     // backgroundColor: Color(0x2bef8f21),
  //     textColor: Colors.white,
  //     fontSize: 20.0,
  //
  //   );
  // }
}
