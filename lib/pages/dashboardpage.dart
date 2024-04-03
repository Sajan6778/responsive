import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:responsive/pages/Aboutus.dart';
import 'package:responsive/pages/Login.dart';
import 'package:responsive/pages/faqpage.dart';
import 'package:responsive/pages/pdf%20file.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/productlistpage.dart';
import 'package:responsive/pages/referpage.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:responsive/pages/wishlist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Cartpage.dart';
import 'constants.dart';
import 'dialogbox.dart';
import 'dropdown_model.dart';
import 'imagecarosal.dart';
import 'newCarousal.dart';
import 'newproductlist.dart';
import 'order_orderhistory.dart';


class DashboardPage extends StatelessWidget {
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


  List<Map<String, dynamic>> wishlistItems = [];

  late String FishImage = "";
  late String FishDataImages = "";
  late String FishDes = "";
  late int dashboardId;
  late int imageId;

  late String catName = "";
  late int catId;
  late List<dynamic> productDatas = [];
  List<dynamic> productDetails = [];
  List<dynamic> productDetails1 = [];


  late List<dynamic> responseFishData = [];
  late List<dynamic> responseProductData = [];

  late List<dynamic> FishDataImage = [];


  String baseUrl = "http://192.168.29.43:8081";
  String baseUrl1 = "http://192.168.29.43:8081/";

  // String dropdownValue = list.first;
  String dropdownValues = '';
  bool isChecked = false;
  int hoveredIndex = -1;
  int hoveredIndexrecom = -3;
  int hoveredIndexmeat = -2;

  String productName = '';
  double gstTaxAmount = 0.0;

  List<String> categoryNames = [];
  List<String> urls = [];
  List<int> catid = [];
  late List<dynamic> FishData = [];
  List<String> productcategoryNames = [];

  List<int> carosalcatid = [];
  List<int> carosalcatid1 = [];
  List<int> carosalcatid2 = [];
  List<int> carosalcatid3 = [];

  late List<dynamic> responseData = [];
  late List<dynamic> responseData1 = [];
  late int productListId;
  List<int> detailListId = [];
  List<int> detailListId1 = [];
  List<int> detailListId2 = [];

  List<Map<String, dynamic>> mobileFullDetails = [];
  List<Map<String, dynamic>> mobileFullDetails1 = [];

  List<Map<String, dynamic>> fishFullDetails1 = [];
  List<Map<String, dynamic>> fishFullDetails2 = [];

  bool colorvalue = false;
  bool colorvalue1 = false;
  late List<bool> isFavoriteList=[];
  late List<bool> isFavoriteList1;
  late List<bool>
  isFavoriteList2;
  int? loginuserId;


  late dynamic varientImagesIdValue;
  late dynamic varientImagesIdValue1;

  @override
  void initState() {
    super.initState();

    _checkLoginStatus();
    getData();
    getDataMobile();
    getDataFish();
    getDataProducts();
    _initializeState();
    WidgetsBinding.instance!.addObserver(this);
  }


  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // This is called when the app comes into the foreground
      refreshPage();
    }
  }

  Future<void> refreshPage() async {
    // Implement your refresh logic here
    await Future.delayed(Duration(seconds: 2)); // Simulating a refresh delay

    setState(() {
      getUserProfileDetails();
      _checkLoginStatus();
      getData();
      getDataMobile();
      getDataFish();
      getDataProducts();

    });
  }


  void initializeIsFavoriteList() {
    if (FishData.isNotEmpty) {
      isFavoriteList = List.generate(FishData.length, (item) => false);
    }
  }

  void initializeIsFavoriteList1() {
    if (FishData.isNotEmpty) {
      isFavoriteList1 = List.generate(FishData.length, (i) => false);
    }
  }

  void initializeIsFavoriteList2() {
    if (datas.isNotEmpty) {
      isFavoriteList2  = List.generate(datas.length, (index) => false);
    }
  }

 // late bool isFavoriteList2=false;


  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  PageController _pageController = PageController();
  int currentPage = 0;
  int itemsPerPage = 5;

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  PageController _pageControllermob = PageController();
  int currentPagemob = 0;
  int itemsPerPagemob = 2;

  // @override
  // void disposemob() {
  //   _pageControllermob.dispose();
  //   super.dispose();
  // }

  void onPageChangedmob(int page1) {
    setState(() {
      currentPagemob = page1;
    });
  }

  PageController _pageControllerfish = PageController();
  int currentPagefish = 0;
  int itemsPerPagefish = 6;

  @override
  void disposefish() {
    _pageControllerfish.dispose();
    super.dispose();
  }

  void onPageChangedfish(int page2) {
    setState(() {
      currentPagefish = page2;
    });
  }

  PageController _pageControllermeat = PageController();
  int currentPagemeat = 0;
  int itemsPerPagemeat = 4;

  @override
  void disposemeat() {
    _pageControllermeat.dispose();
    super.dispose();
  }

  void onPageChangedmeat(int page3) {
    setState(() {
      currentPagemeat = page3;
    });
  }

  PageController _pageControllerrec = PageController();
  int currentPagerecom = 0;
  int itemsPerPagerecom = 3;

  @override
  void disposerecom() {
    _pageControllerrec.dispose();
    super.dispose();
  }

  void onPageChangedrecom(int page4) {
    setState(() {
      currentPagerecom = page4;
    });
  }

  late int categoryid;

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

  void getData() async {
    final Uri url = Uri.parse(
        Constants.ipBaseUrl+ 'category?CategoryImage=CategoryDetail'); // Replace with your endpoint

    // Define your key-value pairs
    Map<String, dynamic> queryParams = {
      'CategoryImage': 'CategoryDetail'
      // Add more key-value pairs as needed
    };

    // Add query parameters to the URL
    Uri uri = url.replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Handle successful response
        print('Category Data received: ${response.body}');

        // Parse the response body
       responseData = jsonDecode(response.body);


        if (responseData.isNotEmpty) {
          // Extract category names
          List<String> Names = [];
          List<String> images = [];
          List<int> categoryIds = [];
          for (var categoryData in responseData) {
            String categoryName = categoryData['categoryName'];
            String categoryimage = categoryData['url'];
            categoryid = categoryData['categoryId'];
            Names.add(categoryName);
            images.add(categoryimage);
            categoryIds.add(categoryid);
          }
          setState(() {
            categoryNames = Names;
            urls = images;
            carosalcatid3 = categoryIds;
          });
          // Use categoryNames as needed
          print('Category Names: $categoryNames');
          print('Category Images: $urls');
          print('carosalcatid3: $carosalcatid3');
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

  final AuthService authService = AuthService();
   void getDataCarosal2() async {
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
           List<int> idvalues = [];
           for (var categoryData in responseData) {
             String categoryName = categoryData['categoryName'];
             String categoryimage = categoryData['url'];
             int categoryid = categoryData['categoryId'];
             Names.add(categoryName);
             images.add(categoryimage);
             idvalues.add(categoryid);
           }
           setState(() {
             categoryNames = Names;
             urls = images;
             catid = idvalues;
           });
           // Use categoryNames as needed
           print('Category Names: $categoryNames');
           print('Category Images: $urls');
           print('Category Idvalues: $catid');
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

  void getDataMobile() async {
    final Uri url = Uri.parse(
        Constants.ipBaseUrl+'dashboard1/view?dashboard=dashboardActiveDetails'); // Replace with your endpoint

    // Define your key-value pairs
    Map<String, dynamic> queryParamsMobile = {
      'dashboard': 'dashboardActiveDetails'
      // Add more key-value pairs as needed
    };

    // Add query parameters to the URL
    Uri uri = url.replace(queryParameters: queryParamsMobile);

    try {
      final responseMobile = await http.get(uri);

      if (responseMobile.statusCode == 200) {
        // Handle successful response
        print('Mobile Data received: ${responseMobile.body}');

        // Parse the response body
         responseData1 = jsonDecode(responseMobile.body);

        if (responseData1.isNotEmpty) {
          List<int> categoryIds = [];
          for (var categoryData in responseData1) {
            String mobileName = categoryData['productName'];
            print('product_name: $mobileName');
            String mobileImage = categoryData['url'];
            String mobileDes = categoryData['description'];
            categoryid = categoryData['category_id'];
            categoryIds.add(categoryid);
            Map<String, dynamic> detailsMap = {
              'name': mobileName,
              'url': mobileImage,
              'des': mobileDes,
              // Optionally include categoryId
            };

            mobileFullDetails.add(detailsMap);

          }
          setState(() {
            carosalcatid1 = categoryIds;
            mobileFullDetails1 = mobileFullDetails;
          });
          print('category id mobile: $carosalcatid1');
          print('MobileFullDetails: $mobileFullDetails');
        }
      } else {
        // Handle other status codes
        print('Request failed with status: ${responseMobile.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }
bool wishListStatus=false;
  bool itemWishlistStatus = false;

   void getDataFish() async {
     final Uri url = Uri.parse(Constants.ipBaseUrl+'dashboard2/view?dashboard=dashboardDetails');

     Map<String, dynamic> queryParamsMobile = {
       'dashboard': 'dashboardDetails',
     };

     Uri uri = url.replace(queryParameters: queryParamsMobile);

     try {
       final responseFish = await http.get(uri);

       if (responseFish.statusCode == 200) {
         print('Fish Data received: ${responseFish.body}');
         responseFishData = jsonDecode(responseFish.body);

         if (responseFishData.isNotEmpty) {
           // Assuming you're handling the first item only; modify as needed for multiple items
           List<int> categoryIds = [];

           for (var categoryData in responseFishData) {


             setState(() {
               FishImage = categoryData['dashboardImageUrl'];
               FishDes = categoryData['description'];
               categoryid = categoryData['categoryId'];
               dashboardId =
                   int.tryParse(categoryData['dashboard2id'] ?? '') ?? 0;
               print("dashboardId: $dashboardId");
               categoryIds.add(categoryid);
               FishData = categoryData["productDetails"];


               // for (var fishDataImage in FishData) {
               //   setState(() {
               //     FishDataImage = fishDataImage['varientImagesList'];
               //     print("FishData: $FishDataImage");
               //     FishDataImages=FishDataImage[0]["productVarientImageUrl"];
               //     // imageId=FishDataImage[0]["productVarientImagesId"];
               //     imageId= int.tryParse(FishDataImage[0]["productVarientImagesId"]?? '') ?? 0;
               //     print("imageId: $imageId");
               //     print("FishDataImages: $FishDataImage");
               //   });
               // }
               print("FishData: $FishData");
               initializeIsFavoriteList();
               initializeIsFavoriteList1();


               for (var product in FishData) {
                bool  wishListStatus1 = product['wishListStatus'] ?? false;
                 print('WishListStatus1: $wishListStatus1');
               }

             });
           }

           setState(() {
             carosalcatid2 = categoryIds;
           });

           cardRatings = List.generate(FishData.length, (index) => 0);
           print('category id Fish: $carosalcatid2');

         }
       } else {
         print('Request failed with status: ${responseFish.statusCode}');
       }
     } catch (error) {
       print('Error: $error');
     }
   }



   int totalItemsmeat = 0;
   List<dynamic>  datas=[];

   void getDataProducts() async {
     final Uri url = Uri.parse(Constants.ipBaseUrl+'product/category/view?category=categoryDetails');

     Map<String, dynamic> queryParamsMobile = {
       'category': 'categoryDetails',
     };

     Uri uri = url.replace(queryParameters: queryParamsMobile);

     try {
       final responseProduct = await http.get(uri);

       if (responseProduct.statusCode == 200) {
         print('Product Data received: ${responseProduct.body}');
         responseProductData = jsonDecode(responseProduct.body);


         if (responseProductData.isNotEmpty) {

           // Extract category names
           List<String> catNames = [];
           List<int> catidvalues = [];
           List<dynamic> datas1 = [];
           for (var productData in responseProductData) {
             String categoryName = productData['categoryName'];
             print('productcategoryNames: $categoryName');
             int categoryid = productData['categoryId'];
             datas = productData['productDetails'];

             catNames.add(categoryName);
             catidvalues.add(categoryid);
             datas1.add(datas);


           }

           setState(() {
             initializeIsFavoriteList2();
             productcategoryNames = catNames;
             carosalcatid = catidvalues;
             productDatas = datas1;

           });


           for (var productData in productDatas) {
             // Assuming 'productDetails' is the key containing product details for each category
             List<dynamic> productDetails = productData['productDetails'];

             String categoryName = productData['categoryName'];

               totalItemsmeat = productDetails.length;

           }
           // Use categoryNames as needed
           print('productcatid: $carosalcatid');
           print('productfilterDatas: $productDatas');
         }
       } else {
         print('Request failed with status: ${responseProduct.statusCode}');
       }
     } catch (error) {
       print('Error: $error');
     }
   }

  late int productListIdValue;
  late int productListIdValue1;
  String Message='';
  String errorMessage='';

  void postWishlist() async {
    int? userId = await getUserId();
    print(" post productVarientImagesId':$varientImagesIdValue");

    if (userId != null) {
      final Uri url = Uri.parse(Constants.ipBaseUrl+'wishList/save');

      // Replace 'userIdValue' with the actual ID value
      Map<String, dynamic> queryParamsMobile = {
        'userId': userId.toString(),
        'productListId': productListIdValue.toString(),
        'productVarientImagesId':varientImagesIdValue.toString()
      // Convert to String
      };

      Uri uri = url.replace(queryParameters: queryParamsMobile);

      try {
        final responseWishlist = await http.post(uri);

        if (responseWishlist.statusCode == 200) {
          print('response Wishlist: ${responseWishlist.body}');
          final responseData = json.decode(responseWishlist.body);
          Message = responseData['Message'];
          getDataFish();
          // getDataProducts();
          showToast();

        }else {
          print('Request failed with status: ${responseWishlist.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('User ID not available');
    }
  }

  void postWishlist1() async {
    int? userId = await getUserId();
    print(" post productVarientImagesId1':$varientImagesIdValue1");

    if (userId != null) {
      final Uri url = Uri.parse(Constants.ipBaseUrl+'wishList/save');

      // Replace 'userIdValue' with the actual ID value
      Map<String, dynamic> queryParamsMobile = {
        'userId': userId.toString(),
        'productListId': productListIdValue1.toString(),
        'productVarientImagesId':varientImagesIdValue1.toString()
        // Convert to String
      };

      Uri uri = url.replace(queryParameters: queryParamsMobile);

      try {
        final responseWishlist = await http.post(uri);

        if (responseWishlist.statusCode == 200) {
          print('response Wishlist: ${responseWishlist.body}');
          final responseData = json.decode(responseWishlist.body);
          Message = responseData['Message'];

           getDataProducts();
          showToast();

        }else {
          print('Request failed with status: ${responseWishlist.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('User ID not available');
    }
  }
  var selectedValue;
  late String search;
  TextEditingController searchController = TextEditingController();

  bool isUserLoggedIn = false;


  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLogin') ?? false;

    setState(() {
      isUserLoggedIn = loggedIn;
    });
  }




  Map<String, bool> isFavoriteMap = {};

  late List<int> cardRatings;



  late List<dynamic> responseProfile=[];

  String userImageUrl='';
  bool isApiValue=false;



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

  Future<void> _toggleWishlist(int item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    setState(() {
      isFavoriteList[item] = !isFavoriteList[item];
    });

    // Save the clicked state for the specific index
    await prefs.setBool('wishlistClicked_$item', isFavoriteList[item]);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // int totalItems = product_list.length;

    int totalItems = categoryNames.length;
    int totalItemsmob = mobileFullDetails.length;
    int totalItemsfish = FishData.length;
    int totalItemsmeat = datas.length;
    int totalItemsrecom = product_list.length;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          onTap: () async {
                            bool isAuthenticated = await authService.isAuthenticated();
                            if (isAuthenticated) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPage()));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            }
                          },
                          child: Image.asset(
                            "images/package.png",
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () async {
                            bool isAuthenticated = await authService.isAuthenticated();
                            if (isAuthenticated) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistPage()));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            }
                          },
                          child: Image.asset(
                            "images/Heart.png",
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () async {
                            bool isAuthenticated = await authService.isAuthenticated();
                            if (isAuthenticated) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            }
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
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xffEF8F21)),
                    );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    ImageCarousel(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Categories",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'RedRose',
                                    fontWeight: FontWeight.bold)),
                            _buildDotsIndicator(),
                          ],
                        )),
                    Container(
                      height: 320,
                      child: Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: onPageChanged,
                          itemCount: (responseData.length / itemsPerPage).ceil(),
                          itemBuilder: (BuildContext context, int index) {
                            int startIndex = index * itemsPerPage;
                            int endIndex = startIndex + itemsPerPage;
                            endIndex =
                            endIndex < responseData.length ? endIndex : responseData.length;

                            List<Widget> pageItems = [];
                            for (int i = startIndex; i < endIndex; i++) {
                              responseData.isEmpty
                                  ? Center(child:   CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffEF8F21)),
                              ),)
                                  : pageItems.add(
                                InkWell(
                                  onTap: () {
                                    if (carosalcatid3 != null && carosalcatid3.isNotEmpty) {
                                      print("carosalcatid=$carosalcatid3");
                                      int selectedId = carosalcatid3[i];
                                      print("sending=$selectedId");
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 30.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (carosalcatid3 != null && carosalcatid3.isNotEmpty) {
                                              print("carosalcatid=$carosalcatid3");
                                              int selectedId = carosalcatid3[i];
                                              print("sending=$selectedId");
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
                                            width: 208,
                                            height: 208,
                                            child: CircleAvatar(
                                              backgroundColor:
                                              Color(0xffFAB442),
                                              radius: 16.0,
                                              child:
                                                  urls[i] != null &&
                                                  urls[i].isNotEmpty
                                                  ? Image.network(
                                                    Constants.ipBaseUrl+ urls[i],
                                                width: 106,
                                                height:
                                                128.0501251220703,
                                              )
                                                  : Text(
                                                  'No image available'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(categoryNames[i],
                                            // product_list[i]["name"]!,
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: pageItems),
                            );
                          },
                        ),
                      ),
                    )
                  ]),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mobile",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'RedRose',
                              fontWeight: FontWeight.bold)),
                      _buildDotsIndicatormob(),
                    ],
                  )),
              Container(
                height: 420,
                child: Expanded(
                  child: PageView.builder(
                    controller: _pageControllermob,
                    onPageChanged: onPageChanged,
                    itemCount: (totalItemsmob / itemsPerPagemob).ceil(),
                    itemBuilder: (BuildContext context, int index1) {
                      int startIndex = index1 * itemsPerPagemob;
                      int endIndex = startIndex + itemsPerPagemob;
                      endIndex =
                      endIndex < totalItemsmob ? endIndex : totalItemsmob;

                      List<Widget> pageItems = [];
                      for (int i = startIndex; i < endIndex; i++) {

                        responseData.isEmpty
                        ? Center(child:   CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffEF8F21)),
                        ),):
                        pageItems.add(
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 30.0),
                            child: InkWell(
                              onTap: () {
                                if (carosalcatid1 != null && carosalcatid1.isNotEmpty) {
                                  print("mobilecatid=$carosalcatid1");
                                  int selectedId = carosalcatid1[i];
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
                                width: 620,
                                height: 352,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Color(0xffB6B6B6)),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: Card(
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(60.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(mobileFullDetails[i]["name"],
                                                // "BY I KALL",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'RedRose',
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            SizedBox(height: 10.0),
                                            Container(
                                              width: 295.0,
                                              height: 80.0,
                                              child: Text(
                                                  mobileFullDetails[i]["des"],
                                                  // "I KALL Z6 Pro 4GB/64GB Dark Blue 4G Smartphone",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            // Center(
                                            // child: Obx(
                                            //       () => apiController.isLoading.value
                                            //       ? CircularProgressIndicator()
                                            //       :
                                            SizedBox(height: 20.0),
                                            Container(
                                              width: 196,
                                              height: 49,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15.399360656738281),
                                                  color: Color(0xffef8f21)),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                      0xffEF8F21), // Background color
                                                ),
                                                onPressed: () {
                                                  if (carosalcatid1 != null && carosalcatid1.isNotEmpty) {
                                                    print("mobilecatid=$carosalcatid1");
                                                    int selectedId = carosalcatid1[i];
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
                                                  };
                                                  // final postData = {
                                                  //   'name': nameController.text.toString(),
                                                  //   'email':
                                                  //   emailController.text.toString(),
                                                  //   'mobile_number':
                                                  //   numberController.text.toString(),
                                                  //   'password': _pass.text.toString()
                                                  // };
                                                  // apiController.postDataToApi(
                                                  //     postData, context);
                                                },
                                                child: Text("Shop Now",
                                                    style: TextStyle(
                                                      fontSize:
                                                      19.46938705444336,
                                                    )),
                                              ),
                                            ),
                                            // ),
                                            // )
                                          ],
                                        ),
                                        SizedBox(width: 10.0),
                                        mobileFullDetails[i]["url"]
                                            .isNotEmpty &&
                                            mobileFullDetails[i]["url"] !=
                                                null &&
                                            mobileFullDetails[i]["url"]
                                                .isNotEmpty
                                            ?
                                        Image.network(
                                          Constants.ipBaseUrl +
                                              mobileFullDetails[i]["url"],
                                          width: 183.87966918945312,
                                          height: 223.24937438964844,
                                        )
                                            : Text('No image available'),
                                        // Image.asset(
                                        //   mob_list[i]["image"]!,
                                        //   // imageList[index],
                                        //   width: 183.87966918945312,
                                        //   height: 223.24937438964844,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: pageItems),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fish",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'RedRose',
                              fontWeight: FontWeight.bold)),
                      _buildDotsIndicatorfish(),
                    ],
                  )),

        Container(
          width: screenSize.width,
          height: 720,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
            child: Row(
              children: [

                SizedBox(
                    width: 550,
                    height: 650,
                  child:  Stack(
                      children: [
                        FishImage.isNotEmpty &&
                            FishImage != null &&
                            FishImage.isNotEmpty
                            ? Center(
                              child: Image.network(
                                Constants.ipBaseUrl+FishImage!,
                                fit: BoxFit.cover,
                                width: 550,
                                height: 650,
                                                        // Add other image properties or widgets as needed
                                                      ),
                            )
                            : Text(
                            'No image available'),
                        Positioned(
                          top: 30.0,
                          left: 370.0,
                          child: InkWell(
                            onTap: () {
                              for (int index = 0; index <
                                  carosalcatid2.length; index++) {
                                if (carosalcatid2 != null &&
                                    carosalcatid2.isNotEmpty) {
                                  print("carosalcatid=$carosalcatid2");
                                  int selectedId = carosalcatid2[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NewProductListPage(
                                              carosalcatid: [selectedId]),
                                    ),
                                  );
                                } else {
                                  print('carosalcatid is empty or null');
                                  // Handle the scenario where carosalcatid is empty or null
                                  // You can show a snackbar, dialog, or perform any desired action
                                }
                              }
                            },
                            child: Container(
                                width: 132,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Color(0xf2ffffff)),
                                child: Center(
                                  child: Text("Shop Now",
                                      style: TextStyle(

                                          fontSize: 20,
                                          color: Colors.black
                                      )),
                                )),
                          ),
                        ),
                        Positioned(
                          top: 532.0,
                          child: Container(
                              width: 553,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0x89000000)),
                              child: Container(
                                width: 420.0,
                                height: 52.0,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(
                                        FishDes!,
                                        // "Kolkata/Bengali Hilsa Fish - Cleaned & Whole, 500 g",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21.161245346069336,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              )),
                        )
                      ]

                  ),/* Your fixed content here */
                ),
                SizedBox(width: 20),// Spacer if needed
                Expanded(
                  child: Container(
                    height: 670,
                    child:FishData.isEmpty ?
                     Center(child: Text('No data available')):
                    PageView.builder(
                      controller: _pageControllerfish,
                      onPageChanged: onPageChangedfish,
                      itemCount: (totalItemsfish / itemsPerPagefish).ceil(),
                      itemBuilder: (BuildContext context, int index) {
                        int startIndex = index * itemsPerPagefish;
                        int endIndex = (index + 1) * itemsPerPagefish;
                        endIndex = endIndex < FishData.length ? endIndex : FishData.length;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: (endIndex - startIndex),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing:20,
                            mainAxisSpacing: 30,
                            mainAxisExtent: 315,
                          ),
                          itemBuilder: (context, itemIndex) {
                            int item = startIndex + itemIndex;
                            if (FishData.isNotEmpty && item < FishData.length) {
                              final product = FishData[item];
                              final productDes = product['listDescription'] ?? '';
                              wishListStatus = product['wishListStatus']??false ;
                              final productImage = product['productVarientImageUrl'] ?? '';
                              final productPrice = (product['totalAmount'] ?? 0).toString();
                              final productMrp = (product['mrp'] ?? 0).toString();


                              int myproductId = product['productId'];
                              print(" fish productId send : $myproductId");

                              int productListIdfish = product['productListId'] ?? 0;



                              int selectedId = productListIdfish;
                              print('i am selected: $selectedId');


                              dynamic productVarientImagesIdFish = product['productVarientImagesId'] ;
                              print("productVarientImagesIdFish:$productVarientImagesIdFish");

                              final productDisPerc = (product['discountPercentage'] ?? 0).toString();
                              final averageStarRate = (product['averageStarRate']?? 0);
                              return GestureDetector(
                                onTap: () {

                                  if (selectedId != null) {
                                    print("i am send : $myproductId");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetail1(detailListId: selectedId,sendingProductId:myproductId),
                                      ),
                                    );
                                  } else {
                                    print('Product List Id is null');
                                  }
                                },
                                child: Stack(
                                  children: [

                                    // onEnter: (_) {
                                    //   setState(() {
                                    //     hoveredIndex =
                                    //         item; // Set the hovered index
                                    //   });
                                    // },
                                    // onExit: (_) {
                                    //   setState(() {
                                    //     hoveredIndex =
                                    //     -1; // Reset when mouse exits
                                    //   });
                                    // },
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            9.91282844543457),
                                        color: Color(0xffF6F5F5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: <Widget>[


                                          // FishData[i]["productVarientImageUrl"]

                                              productImage!=
                                                  null &&
                                              productImage
                                                  .isNotEmpty
                                              ?
                                          Center(
                                            child: Image
                                                .network(
                                              Constants.ipBaseUrl+
                                                  productImage,
                                              width: 205,
                                              height: 195,
                                            ),
                                          )
                                              : Text(
                                              'No image available'),
                                          // Center(
                                          //   child: Image.network(
                                          //     baseUrl1+fishFullDetails1[i]
                                          //     ["fishImage"]!,
                                          //     width: 205,
                                          //     height: 205,
                                          //   ),
                                          // ),
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal:
                                                15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                buildRatingCard1(item,averageStarRate),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                                Container(
                                                  width: 197.0,
                                                  height: 39.0,
                                                  child: Text(
                                                    // FishData[i]['listDescription']!,
                                                    productDes,
                                                    // fish_list[
                                                    // item]
                                                    // ["des"]!,
                                                    style:
                                                    TextStyle(
                                                      fontSize:
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "MRP:",
                                                      style:
                                                      TextStyle(
                                                        color: Color(
                                                            0xff717171),
                                                        decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                        fontSize:
                                                        9,
                                                      ),
                                                    ),
                                                    Text(
                                                      // FishData[i]['mrp']!
                                                      //     .toString(),
                                                      productMrp,
                                                      style:
                                                      TextStyle(
                                                        color: Color(
                                                            0xff717171),
                                                        decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                        fontSize:
                                                        9,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Price:",
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        12,
                                                      ),
                                                    ),
                                                    Text(
                                                      // FishData[i]['sellRate']!
                                                      //     .toString(),
                                                      productPrice,
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        12,
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   "( ${fishFullDetails2[i]["sellRate"]}/ g)",
                                                    //   style:
                                                    //   TextStyle(
                                                    //     fontSize:
                                                    //     12,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "(inclusive of all taxes)",
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        11,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      "You Save:",
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        8,
                                                        color: Color(
                                                            0xff00B312),
                                                      ),
                                                    ),
                                                    Text(
                                                      // FishData[i]["discountPercentage"]!
                                                      //     .toString(),
                                                      productDisPerc,
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        8,
                                                        color: Color(
                                                            0xff00B312),
                                                      ),
                                                    ),
                                                    Text(
                                                      "%OFF",
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        8,
                                                        color: Color(
                                                            0xff00B312),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 40.0,
                                      right: 30.0,
                                      child: Container(
                                        width: 25.0,
                                        height: 25.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: InkWell(

                                          onTap: () async {
                                            bool isAuthenticated = await authService.isAuthenticated();
                                            if (isAuthenticated) {
                                              setState(() {
                                                 isFavoriteList[item] = !isFavoriteList[item];
                                                print("isFavoriteList: $isFavoriteList");

                                                productListIdValue=selectedId;
                                                varientImagesIdValue=productVarientImagesIdFish;
                                                print("varientImagesIdValue fish:$varientImagesIdValue");
                                                postWishlist();


                                              });

                                            } else {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                            }
                                          },


                                          // onTap: () {
                                          //   setState(() {
                                          //     isFavoriteList[item] = !isFavoriteList[item];
                                          //     print("isFavoriteList: $isFavoriteList");
                                          //     productListIdValue=selectedId;
                                          //     postWishlist();
                                          //   });
                                          // },


                                          child: Icon(
                                            wishListStatus==true ? Icons.favorite : Icons.favorite_border,
                                            color:wishListStatus==true ?  Colors.red : null,
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // if (hoveredIndex == item)
                                    //
                                  ],
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ProductListPage()));
              //   },
              //   child: Stack(
              //     children: [
              //       Container(
              //         width: screenSize.width,
              //         height: 400.7391357421875,
              //         child: Image.asset(
              //           fit: BoxFit.contain,
              //           "images/adds.png",
              //         ),
              //       ),
              //       Positioned(
              //         top: 100.0,
              //         left: 50.0,
              //         child: Column(
              //           children: [
              //             Text("LOOKS DESTINATION",
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                 )),
              //             SizedBox(height: 20.0),
              //             Text("OWN THE SPOTLIGHT",
              //                 style: TextStyle(
              //                   fontSize: 42,
              //                   fontWeight: FontWeight.bold,
              //                 )),
              //             SizedBox(height: 20.0),
              //             Text("Click on 800+ lip and eye shades",
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                 )),
              //             SizedBox(height: 20.0),
              //             Container(
              //                 width: 133,
              //                 height: 32,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(7),
              //                   color: Color(0xfffd7279),
              //                 ),
              //                 child: Center(
              //                   child: Text("Shop Now",
              //                       style: TextStyle(
              //                         fontSize: 20,
              //                       )),
              //                 ))
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("Recommended",
              //             style: TextStyle(
              //                 fontSize: 28,
              //                 fontFamily: 'RedRose',
              //                 fontWeight: FontWeight.bold)),
              //         _buildDotsIndicatorrecom(),
              //       ],
              //     )),
              // Container(
              //   width: screenSize.width,
              //   height: 500,
              //   color: Colors.white,
              //   child: Padding(
              //     padding:
              //     EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
              //     child: Row(
              //       children: [
              //         Stack(
              //           children: [
              //             Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: Image.asset(
              //                 fit: BoxFit.cover,
              //                 width: 500.0485229492188,
              //                 height: 375,
              //                 "images/image 19.png",
              //               ),
              //             ),
              //             Positioned(
              //               top: 20.0,
              //               right: 20.0,
              //               child: InkWell(
              //                 onTap: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) =>
              //                               ProductListPage(carosalcatid: [],)));
              //                 },
              //                 child: Container(
              //                     width: 133,
              //                     height: 32,
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(7),
              //                       color: Colors.white,
              //                     ),
              //                     child: Center(
              //                       child: Text("Shop Now",
              //                           style: TextStyle(
              //                             fontSize: 20,
              //                           )),
              //                     )),
              //               ),
              //             ),
              //             Positioned(
              //               top: 270.0,
              //               left: 20.0,
              //               child: Row(
              //                 children: [
              //                   Container(
              //                     width: 61,
              //                     height: 84,
              //                     decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(7),
              //                         color: Colors.white),
              //                     child: Center(
              //                       child: Image.asset(
              //                         width: 37.75221252441406,
              //                         height: 68.80644989013672,
              //                         "images/image 20.png",
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(width: 5.0),
              //                   Container(
              //                     width: 61,
              //                     height: 84,
              //                     decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(7),
              //                         color: Colors.white),
              //                     child: Center(
              //                       child: Image.asset(
              //                         width: 37.75221252441406,
              //                         height: 68.80644989013672,
              //                         "images/image 21.png",
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(width: 5.0),
              //                   Container(
              //                     width: 61,
              //                     height: 84,
              //                     decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(7),
              //                         color: Colors.white),
              //                     child: Center(
              //                       child: Image.asset(
              //                         width: 37.75221252441406,
              //                         height: 68.80644989013672,
              //                         "images/image 22.png",
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             )
              //           ],
              //         ),
              //         SizedBox(width: 50),
              //         Expanded(
              //           child: Container(
              //             height: 500,
              //             child: Expanded(
              //               child: PageView.builder(
              //                 controller: _pageControllerrec,
              //                 onPageChanged: onPageChangedrecom,
              //                 itemCount:
              //                 (totalItemsrecom / itemsPerPagerecom).ceil(),
              //                 itemBuilder: (BuildContext context, int index) {
              //                   int startIndex = index * itemsPerPagerecom;
              //                   int endIndex = startIndex + itemsPerPagerecom;
              //                   endIndex = endIndex < totalItemsrecom
              //                       ? endIndex
              //                       : totalItemsrecom;
              //
              //                   List<Widget> pageItems = [];
              //                   for (int i = startIndex; i < endIndex; i++) {
              //                     pageItems.add(
              //                       InkWell(
              //                         onTap: () {
              //
              //                           Navigator.push(
              //                               context,
              //                               MaterialPageRoute(
              //                                   builder: (context) =>
              //                                       ProductListPage(carosalcatid: [],)));
              //                         },
              //                         child: Container(
              //                           decoration: BoxDecoration(
              //                               borderRadius: BorderRadius.circular(
              //                                   9.91282844543457),
              //                               color: Colors.white),
              //                           child: Column(
              //                             crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                             mainAxisSize: MainAxisSize.min,
              //                             children: <Widget>[
              //                               Padding(
              //                                   padding:
              //                                   const EdgeInsets.symmetric(
              //                                       horizontal: 30.0,
              //                                       vertical: 20.0),
              //                                   child: Stack(
              //                                     children: [
              //                                       MouseRegion(
              //                                         // onEnter: (_) {
              //                                         //   setState(() {
              //                                         //     hoveredIndexrecom =
              //                                         //         i; // Set the hovered index
              //                                         //   });
              //                                         // },
              //                                         // onExit: (_) {
              //                                         //   setState(() {
              //                                         //     hoveredIndexrecom =
              //                                         //     -3; // Reset when mouse exits
              //                                         //   });
              //                                         // },
              //                                         child: Container(
              //                                           width: 200,
              //                                           height: 210,
              //                                           decoration: BoxDecoration(
              //                                               border: Border.all(
              //                                                   color: Color(
              //                                                       0xffB6B6B6)),
              //                                               borderRadius:
              //                                               BorderRadius
              //                                                   .circular(
              //                                                   7),
              //                                               color:
              //                                               Colors.white),
              //                                           child: Center(
              //                                             child: Image.asset(
              //                                               product_list[i]
              //                                               ["image"]!,
              //                                               width:
              //                                               119.87966918945312,
              //                                               height:
              //                                               141.9697723388672,
              //                                             ),
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       Positioned(
              //                                         top: 20.0,
              //                                         right: 10.0,
              //                                         child: Container(
              //                                           width: 25.0,
              //                                           height: 25.0,
              //                                           decoration: BoxDecoration(
              //                                             shape: BoxShape.circle,
              //                                             color: Colors.white,
              //                                           ),
              //                                           child: InkWell(
              //                                             onTap: () {
              //                                               setState(() {
              //                                                 isFavoriteList1[i] = !isFavoriteList1[i];
              //                                               });
              //                                             },
              //                                             child: Icon(
              //                                               isFavoriteList1[i] ? Icons.favorite : Icons.favorite_border,
              //                                               color: isFavoriteList1[i] ? Colors.red : null,
              //                                               size: 18.0,
              //                                             ),
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       // if (hoveredIndexrecom == i)
              //                                       //   Positioned(
              //                                       //     top: 190.0,
              //                                       //     left: 8.0,
              //                                       //     child: Row(
              //                                       //       children: [
              //                                       //         Icon(
              //                                       //           Icons.star,
              //                                       //           size: 10,
              //                                       //           color: Color(
              //                                       //               0xffFFB800),
              //                                       //         ),
              //                                       //         Icon(
              //                                       //           Icons.star,
              //                                       //           size: 10,
              //                                       //           color: Color(
              //                                       //               0xffFFB800),
              //                                       //         ),
              //                                       //         Icon(
              //                                       //           Icons.star,
              //                                       //           size: 10,
              //                                       //           color: Color(
              //                                       //               0xffFFB800),
              //                                       //         ),
              //                                       //         Icon(
              //                                       //           Icons.star,
              //                                       //           size: 10,
              //                                       //           color: Color(
              //                                       //               0xffFFB800),
              //                                       //         ),
              //                                       //         SizedBox(
              //                                       //             width: 5.0),
              //                                       //         Text("4.5",
              //                                       //             style:
              //                                       //             TextStyle(
              //                                       //               fontSize:
              //                                       //               8.27368450164795,
              //                                       //             ))
              //                                       //       ],
              //                                       //     ),
              //                                       //   ),
              //                                       // if (hoveredIndexrecom == i)
              //                                       //   Positioned(
              //                                       //     left: 165.0,
              //                                       //     top: 10.0,
              //                                       //     child: ShaderMask(
              //                                       //       shaderCallback:
              //                                       //           (Rect bounds) {
              //                                       //         return LinearGradient(
              //                                       //           colors: <Color>[
              //                                       //             Color(
              //                                       //                 0xffE3E3E3),
              //                                       //             Colors.white,
              //                                       //           ],
              //                                       //           tileMode: TileMode
              //                                       //               .mirror,
              //                                       //         ).createShader(
              //                                       //             bounds);
              //                                       //       },
              //                                       //       child: Container(
              //                                       //         width: 21,
              //                                       //         height: 60,
              //                                       //         decoration:
              //                                       //         BoxDecoration(
              //                                       //           color:
              //                                       //           Colors.white,
              //                                       //           borderRadius:
              //                                       //           BorderRadius
              //                                       //               .circular(
              //                                       //               10.5),
              //                                       //         ),
              //                                       //         child: Column(
              //                                       //           children: [
              //                                       //             SizedBox(
              //                                       //                 height:
              //                                       //                 8.0),
              //                                       //             Image.asset(
              //                                       //                 "images/Heart (1).png"),
              //                                       //             SizedBox(
              //                                       //                 height:
              //                                       //                 6.0),
              //                                       //             Image.asset(
              //                                       //                 "images/Shopping bag (2).png"),
              //                                       //             SizedBox(
              //                                       //                 height:
              //                                       //                 6.0),
              //                                       //             Image.asset(
              //                                       //                 "images/More three dots button.png")
              //                                       //           ],
              //                                       //         ),
              //                                       //       ),
              //                                       //     ),
              //                                       //   ),
              //                                     ],
              //                                   )),
              //                               MouseRegion(
              //                                 onEnter: (_) {
              //                                   setState(() {
              //                                     hoveredIndexrecom =
              //                                         i; // Set the hovered index
              //                                   });
              //                                 },
              //                                 onExit: (_) {
              //                                   setState(() {
              //                                     hoveredIndexrecom =
              //                                     -3; // Reset when mouse exits
              //                                   });
              //                                 },
              //                                 child: Column(
              //                                   crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                                   children: [
              //                                     Container(
              //                                       width: 200.0,
              //                                       height: 40.0,
              //                                       child: Text(
              //                                           fish_list[index]
              //                                           ["des"]!,
              //                                           style: TextStyle(
              //                                             fontSize: 12,
              //                                           )),
              //                                     ),
              //                                     SizedBox(
              //                                       height: 10.0,
              //                                     ),
              //                                     Text(
              //                                         fish_list[index]["name"]!,
              //                                         style: TextStyle(
              //                                           fontSize:
              //                                           14.578947067260742,
              //                                           fontWeight:
              //                                           FontWeight.bold,
              //                                         )),
              //                                     SizedBox(
              //                                       height: 10.0,
              //                                     ),
              //                                     Row(
              //                                       children: [
              //                                         Text(
              //                                           "MRP:",
              //                                           style: TextStyle(
              //                                             color:
              //                                             Color(0xff717171),
              //                                             decoration:
              //                                             TextDecoration
              //                                                 .lineThrough,
              //                                             fontSize: 12,
              //                                           ),
              //                                         ),
              //                                         Text(
              //                                           fish_list[index]
              //                                           ["mrp"]!,
              //                                           style: TextStyle(
              //                                             color:
              //                                             Color(0xff717171),
              //                                             decoration:
              //                                             TextDecoration
              //                                                 .lineThrough,
              //                                             fontSize: 12,
              //                                           ),
              //                                         ),
              //                                       ],
              //                                     ),
              //                                     SizedBox(
              //                                       height: 10.0,
              //                                     ),
              //                                     Row(
              //                                       children: [
              //                                         Text("Price:",
              //                                             style: TextStyle(
              //                                                 fontSize: 15,
              //                                                 fontWeight:
              //                                                 FontWeight
              //                                                     .bold)),
              //                                         Text(
              //                                             product_list[index]
              //                                             ["price"]!,
              //                                             style: TextStyle(
              //                                                 fontSize: 15,
              //                                                 fontWeight:
              //                                                 FontWeight
              //                                                     .bold)),
              //                                         SizedBox(width: 8.0),
              //                                         Positioned(
              //                                           top: 8.0,
              //                                           child: Text("7.23% off",
              //                                               style: TextStyle(
              //                                                   fontSize:
              //                                                   11.666667938232422,
              //                                                   color: Color(
              //                                                       0xffB30000))),
              //                                         )
              //                                       ],
              //                                     ),
              //                                     SizedBox(
              //                                       height: 10.0,
              //                                     ),
              //                                     Text("(GST inclusive price)",
              //                                         style: TextStyle(
              //                                           fontSize: 10,
              //                                         ))
              //                                   ],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     );
              //                   }
              //
              //                   return SingleChildScrollView(
              //                     scrollDirection: Axis.horizontal,
              //                     child: Row(children: pageItems),
              //                   );
              //                 },
              //               ),
              //             ),
              //           ),
              //           // Adjust the spacing between the two containers
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              NewCarousal(),
              SizedBox(
                height: 40.0,
              ),
              Container (
                height: responseProductData.length * 450.0,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: responseProductData.length,// Your item count,
                    itemBuilder: (BuildContext context, int index)
                    {
                      if(responseProductData != null ){
                        productDetails = responseProductData[index]['productDetails'];
                        print("productDetails:$productDetails");
                        productDetails1 = productDetails[index]['productListDetails'];
                        print("productDetails1:$productDetails1");
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(

                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    productcategoryNames[index],
                                    // "Meat",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'RedRose',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // _buildDotsIndicatormeat(),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),

                             Container(
                                height: 400,


                                                    child:
                                                    Expanded(
                                                      child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                                                      itemCount: productDetails.length ,
                                                      itemBuilder: (BuildContext context, int index1) {
                                                        if (productDetails != null )

                                                         {
                              final productName = productDetails[index1]["productListDetails"][0]['productName'] ?? '';

                              final proImages =
                              productDetails[index1]["productListDetails"][0]["productVarientImagesList"][0]['productVarientImageUrl'];

                              final productPrice = (productDetails[index1]["productListDetails"][0]['totalAmount'] ??
                                  0).toString();

                              final productMrp = (productDetails[index1]["productListDetails"][0]['mrp'] ??
                                  0).toString();
                              final productUnit = (productDetails[index1]["productListDetails"][0]['unit'] ??
                                  0).toString();

                              itemWishlistStatus = productDetails[index1]["productListDetails"][0]['wishListStatus']??false ;
                              print("itemWishlistStatus:$itemWishlistStatus");
                              final averageStarRate=productDetails[index1]["productListDetails"][0]['averageStarRate']??0;

                              List<int> ListIdValues = [];
                              int productListId  = productDetails[index1]["productListDetails"][0]['productListId'] ?? 0;


                              ListIdValues.add(productListId);
                                detailListId =ListIdValues;
                              print('product List Id Values: $detailListId');
                              int selectedId = detailListId[0
                              ];
                              print('selectedId: $selectedId');

                              List<int> ListIdValues1 = [];
                              int productID1 = productDetails[index1]["productListDetails"][0]['productId']??0 ;

                              ListIdValues1.add(productID1);
                              detailListId1 =ListIdValues1;
                              print(' category wise product Id Values: $detailListId1');
                             int myproductId = detailListId1[0];
                              print('myproductId: $myproductId');


                            dynamic  VarientImagesId_AllDatas =
                              productDetails[index1]["productListDetails"][0]["productVarientImagesList"][0]['productVarientImagesId'];
                               print("productVarientImagesId_data:$VarientImagesId_AllDatas");




                              // void initializeIsFavoriteList2() {
                              //   if (productDetails.isNotEmpty) {
                              //     isFavoriteList2 = List.generate(productDetails.length, (index) => false);
                              //   }
                              // }
                              //
                              //
                              //   initializeIsFavoriteList2();

                              // Generate a unique key for each item
                              final key = '$index-$index1';

                              // Initialize the favorite state for each item
                              if (!isFavoriteMap.containsKey(key)) {
                                isFavoriteMap[key] = false;
                              }

                              return
                                GestureDetector(
                                  onTap: () {
                                    if (selectedId != null) {
                                      print("category based product List Id=$selectedId");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetail1(detailListId: selectedId,sendingProductId:myproductId),
                                        ),
                                      );
                                    } else {
                                      print('Product List Id is null');
                                    }
                                  },
                                  child:Stack(
                                    children: [
                                      MouseRegion(
                                        // onEnter: (_) {
                                        //   setState(() {
                                        //     hoveredIndexmeat =
                                        //         index1; // Set the hovered index
                                        //   });
                                        // },
                                        // onExit: (_) {
                                        //   setState(() {
                                        //     hoveredIndexmeat =
                                        //     -2; // Reset when mouse exits
                                        //   });
                                        // },
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .only(left: 30.0,),
                                          child: Container(
                                            width: 315,
                                            height: 450,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15.0),
                                              ),
                                              color: Colors.white,
                                              // elevation: 10,
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(
                                                    bottom: 10.0,top: 20.0),
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      Constants.ipBaseUrl+
                                                          proImages!,
                                                      // meat_list[i]["image"]!,
                                                      width: 315,
                                                      height: 200.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 30.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          buildRatingCard1(index1,averageStarRate),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Text(
                                                              productName ,
                                                              // "Leg Curry Cut (Front / Back Leg)",
                                                              style: TextStyle(
                                                                fontSize:
                                                                13.332329750061035,
                                                              )),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          // Text(
                                                          //     (productDetails[i]["quantity"] ?? 0).toString(),
                                                          //     // "14 - 16 Pieces",
                                                          //     style: TextStyle(
                                                          //       fontSize:
                                                          //       9.523092269897461,
                                                          //     )),
                                                          // SizedBox(
                                                          //   height: 10.0,
                                                          // ),

                                                          Container(
                                                            width: 134,
                                                            height: 25,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    26.042741775512695),
                                                                color: Color(
                                                                    0xff2bef8f21)),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Text(
                                                                      "Weight :",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          9.544021606445312,
                                                                          color: Color(
                                                                              0xffEF8F21))),
                                                                  Text(
                                                                      (productUnit ??
                                                                          0)
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          9.544021606445312,
                                                                          color: Color(
                                                                              0xffEF8F21))),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Price: ",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                    15.236948013305664,
                                                                  )),
                                                              Text(
                                                                  productPrice.toString(),
                                                                  // meat_list[i]
                                                                  // ["price"]!,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                    15.236948013305664,
                                                                  )),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .only(
                                                                    top: 5.0),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                        "MRP:",
                                                                        style: TextStyle(
                                                                            decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                            fontSize:
                                                                            12,
                                                                            color: Color(
                                                                                0xff717171))),
                                                                    Text(
                                                                        (productMrp)
                                                                            .toString(),
                                                                        // meat_list[i]
                                                                        // ["mrp"]!,
                                                                        style: TextStyle(
                                                                            decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                            fontSize:
                                                                            12,
                                                                            color: Color(
                                                                                0xff717171))),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // if (hoveredIndexmeat == index1)
                                      //   Positioned(
                                      //     left: 300.0,
                                      //     top: 10.0,
                                      //     child: Container(
                                      //       width: 21,
                                      //       height: 60,
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius:
                                      //         BorderRadius.circular(
                                      //             10.5),
                                      //       ),
                                      //       child: Column(
                                      //         children: [
                                      //           SizedBox(height: 8.0),
                                      //           Image.asset(
                                      //               "images/Heart (1).png"),
                                      //           SizedBox(height: 6.0),
                                      //           Image.asset(
                                      //               "images/Shopping bag (2).png"),
                                      //           SizedBox(height: 6.0),
                                      //           Image.asset(
                                      //               "images/More three dots button.png")
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   )

                                      Positioned(
                                        top: 20.0,
                                        right: 10.0,
                                        child: Container(
                                          width: 25.0,
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              bool isAuthenticated = await authService.isAuthenticated();
                                              if (isAuthenticated) {
                                                print("Tapped index: $index1");
                                                print("itemWishlistStatus: $itemWishlistStatus");
                                                setState(() {

                                                  isFavoriteMap[key] = !isFavoriteMap[key]!;

                                                  productListIdValue1=selectedId;
                                                  print("productListIdValue1=$productListIdValue1");
                                                  varientImagesIdValue1=VarientImagesId_AllDatas;
                                                  print("data__varientImagesIdValue1:$varientImagesIdValue1");
                                                  postWishlist1();

                                                });

                                              } else {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                              }
                                            },


                                            // onTap: () {
                                            //   print("Tapped index: $index1");
                                            //   setState(() {
                                            //     // isFavoriteList2[index1] = !isFavoriteList2[index1];
                                            //
                                            //     isFavoriteMap[key] = !isFavoriteMap[key]!;
                                            //     print("isFavoriteList2: $isFavoriteList2");
                                            //      productListIdValue=selectedId;
                                            //     print("productListIdValue=$productListIdValue");
                                            //     varientImagesIdValue=VarientImagesId_AllDatas;
                                            //     print("data__varientImagesIdValue:$varientImagesIdValue");
                                            //     postWishlist();
                                            //
                                            //   });
                                            // },
                                            // child: Icon(
                                            //   isFavoriteList2[index1] ? Icons.favorite : Icons.favorite_border,
                                            //   color: isFavoriteList2[index1] ? Colors.red : null,
                                            //   size: 18.0,
                                            // ),
                                         child:   Icon(
                                           itemWishlistStatus == true
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:itemWishlistStatus== true ? Colors.red : null,
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                                      }}),
                                                    ),
                                                    ),

                            SizedBox(height: 80.0),
                          ],
                        );
                      }

                    },
                  ),
                ),
              ),



              SizedBox(height: 50.0),
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
                        style: TextStyle(fontSize: 16, color: Colors.black)),
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

  Widget _buildDotsIndicator() {
    // int totalItems = product_list.length;
    int totalItems = categoryNames.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItems / itemsPerPage).ceil(),
            (index) {
          return InkWell(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index ? Color(0xffEF8F21) : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildDotsIndicatormob() {
    int totalItemsmob = mobileFullDetails.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItemsmob / itemsPerPagemob).ceil(),
            (index1) {
          return InkWell(
            onTap: () {
              _pageControllermob.animateToPage(
                index1,
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
              );
              onPageChangedmob(
                  index1); // Update currentPagemob when dot is tapped
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                currentPagemob == index1 ? Color(0xffEF8F21) : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDotsIndicatorfish() {
    int totalItemsfish = FishData.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItemsfish / itemsPerPagefish).ceil(),
            (index2) {
          return InkWell(
            onTap: () {
              _pageControllerfish.animateToPage(
                index2,
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
              );
              onPageChangedfish(
                  index2); // Update currentPagemob when dot is tapped
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                currentPagefish == index2 ? Color(0xffEF8F21) : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }



  Widget _buildDotsIndicatormeat() {
    // int totalItemsmeat = meat_list.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItemsmeat / itemsPerPagemeat).ceil(),
            (index3) {
          return InkWell(
            onTap: () {
              _pageControllermeat.animateToPage(
                index3,
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
              );
              onPageChangedmeat(
                  index3); // Update currentPagemob when dot is tapped
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                currentPagemeat == index3 ? Color(0xffEF8F21) : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDotsIndicatorrecom() {
    int totalItemsrecom = product_list.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItemsrecom / itemsPerPagerecom).ceil(),
            (index3) {
          return InkWell(
            onTap: () {
              _pageControllerrec.animateToPage(
                index3,
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
              );
              onPageChangedmeat(
                  index3); // Update currentPagemob when dot is tapped
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPagerecom == index3
                    ? Color(0xffEF8F21)
                    : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  customDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new Text("Sorry please try \n again tomorrow",
                                  style: TextStyle(
                                      fontSize: 30.0, color: Colors.white)),
                            ) //
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 5.0,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: Text(
                              "OK",
                              style:
                              TextStyle(color: Colors.blue, fontSize: 25.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: FloatingActionButton(
                      child: Image.asset("assets/red_cross.png"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      backgroundColor: Colors.white,
                      mini: true,
                      elevation: 5.0,
                    ),
                  ),
                ],
              ));
        });
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');

  }

  void showToast() {
    Fluttertoast.showToast(
      msg: Message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      webBgColor: '#FF8911',
      timeInSecForIosWeb: 1,
      // backgroundColor: Color(0x2bef8f21),
      textColor: Colors.white,
      fontSize: 20.0,

    );
  }




  Widget buildRatingCard1(int index, double rating) {
    int filledStars = rating.floor();
    double fractionalStarValue = rating - filledStars;

    return Row(
      children: [
        Row(
          children: List.generate(
            filledStars,
                (starIndex) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 15,
            ),
          ),
        ),
        if (fractionalStarValue > 0)
          FractionalStar(fractionalStarValue),
        SizedBox(width: 10),
        Text(
          '$rating',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }



}
