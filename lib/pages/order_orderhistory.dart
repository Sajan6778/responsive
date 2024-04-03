import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive/pages/pdf%20file.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/refunddialong.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:responsive/pages/wishlist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Aboutus.dart';
import 'Cartpage.dart';
import 'Login.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'dialogbox.dart';
import 'dropdown_model.dart';
import 'faqpage.dart';
import 'newproductlist.dart';
import 'orderreturn.dart';
import 'ordertracking.dart';
import 'orderview.dart';
import 'package:http/http.dart' as http;

List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];
List<String> list3 = <String>['Filter', 'One', 'Two', 'Three', 'Four'];
List<String> list2 = <String>[
  'Mobile',
  'Fish',
  'Meat',
  'Vegetables',
  'Groceries',
  'Cosmetics',
  'Footwear',
  'Apparels',
  'Artificial Jewelry',
];

List<String> brand = <String>[
  'Chanel',
  'Christian Dior',
  'louis vuitton',
  'Calvin Klein',
];

var product_list = [
  {
    "image": "images/fish.png",
    "name": "Fish",
    "price": "₹ 1452",
    "mrp": "₹ 1568",
    "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
  },
  {
    "image": "images/mobile.png",
    "name": "Mobile",
    "price": "₹ 1452",
    "mrp": "₹ 2000",
    "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
  },
  {
    "image": "images/jewells.png",
    "name": "Jewells",
    "price": "₹ 1800",
    "mrp": "₹ 2000",
    "des":
        "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
  },
  {
    "image": "images/meat.png",
    "name": "Meat",
    "price": "₹ 500",
    "mrp": "₹ 1000",
    "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
  },
  // {
  //   "image": "images/jewells.png",
  //   "name": "Jewells",
  //   "price": "₹ 1800",
  //   "mrp": "₹ 2000",
  //   "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
  // },
  // {
  //   "image": "images/meat.png",
  //   "name": "Meat",
  //   "price": "₹ 500",
  //   "mrp": "₹ 765",
  //   "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
  // },
  // {
  //   "image": "images/fish.png",
  //   "name": "Fish",
  //   "price": "₹ 1452",
  //   "mrp": "₹ 1568",
  //   "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
  // },
  // {
  //   "image": "images/mobile.png",
  //   "name": "Mobile",
  //   "price": "₹ 1452",
  //   "mrp": "₹ 2000",
  //   "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
  // },
  // {
  //   "image": "images/jewells.png",
  //   "name": "Jewells",
  //   "price": "₹ 1800",
  //   "mrp": "₹ 2000",
  //   "des":
  //       "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
  // },
  // {
  //   "image": "images/meat.png",
  //   "name": "Meat",
  //   "price": "₹ 500",
  //   "mrp": "₹ 1000",
  //   "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
  // },
  // {
  //   "image": "images/jewells.png",
  //   "name": "Jewells",
  //   "price": "₹ 1800",
  //   "mrp": "₹ 2000",
  //   "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
  // },
  // {
  //   "image": "images/meat.png",
  //   "name": "Meat",
  //   "price": "₹ 500",
  //   "mrp": "₹ 765",
  //   "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
  // },
  // {
  //   "image": "images/fish.png",
  //   "name": "Fish",
  //   "price": "₹ 1452",
  //   "mrp": "₹ 2000",
  //   "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
  // },
  // {
  //   "image": "images/mobile.png",
  //   "name": "Mobile",
  //   "price": "₹ 1452",
  //   "mrp": "₹ 2000",
  //   "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
  // },
];

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  String dropdownValue = list.first;
  String dropdownValue1 = list3.first;
  String dropdownValues = list1.first;
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  List<bool> checkedList = List.generate(list2.length, (index) => false);
  List<bool> checkedList1 = List.generate(brand.length, (index) => false);

  int hoveredIndex = -1;
  int hoveredIndexrecom = -3;

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  int currentQuantityIndex = 0;
  late List<int> cardRatings;


  @override
  void initState () {
    super.initState();
   getOrderHistoryData();
    _initializeState();
  }

  final AuthService authService = AuthService();

  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }

  PageController _pageControllerfish = PageController();
  int currentPagefish = 0;
  int itemsPerPagefish = 6;


  List<String>  OrderDate = [];
  List<String> cardImage = [];
  List<String> ProductNames = [];
  List<String> Description = [];
  List<String> statusValue = [];
  List<dynamic> mrpValues = [];
  List<dynamic> quantityValues = [];
  List<dynamic> priceValues = [];
  List<dynamic> orderItemListIdDatas = [];

  late dynamic selectedOrderItemListId;
  late dynamic selectedProductListId;
  late dynamic reviewId;
  late dynamic starRate;

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

  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String search;

  Future<List<DropdownModel>> getPost() async {
    try {
      final categoryResponse = await http.get(
        Uri.parse(
            Constants.ipBaseUrl + 'category?CategoryImage=CategoryDetail'),
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
  String date = '';
  String ImageUrl = '';
  dynamic mrp;
  dynamic quantity;
  dynamic price;
  String des = '';
  String status = '';
  String proName = '';
  dynamic orderItemListId;

  List<dynamic> responseData = [];

  Future<void> getOrderHistoryData() async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl + 'order/detail';

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

          print('Data for ID $userId: $responseData');
          print("responseData:${responseData.length}");


          if (responseData.isNotEmpty) {
            List<String> Date = [];
            List<String> ImageUrls = [];
            List<String> proNames = [];
            List<String> descrip = [];
            List<String> orderStatus = [];
            List<dynamic> mrpValue = [];
            List<dynamic> quantityValue = [];
            List<dynamic> priceValue = [];
            List<dynamic> orderItemListIdValue = [];

            for (var productData in responseData) {
              date = productData['date'] ?? "";
              print("date:$date");

              ImageUrl = productData['productVarientImageUrl'] ?? "";
              mrp = productData['totalAmount'];
              quantity = productData['quantity'];
              price = productData['totalPrice'];
              des = productData['description'] ?? "";
              status = productData['orderStatus'] ?? "";
              proName = productData['productName'] ?? "";
              orderItemListId = productData['orderItemListId'];

              Date.add(date);
              proNames.add(proName);
              descrip.add(des);
              orderStatus.add(status);
              mrpValue.add(mrp);
              quantityValue.add(quantity);
              priceValue.add(price);
              ImageUrls.add(ImageUrl);
              orderItemListIdValue.add(orderItemListId);
            }

            setState(() {
              OrderDate = Date;
              ProductNames = proNames;
              Description = descrip;
              statusValue = orderStatus;
              mrpValues = mrpValue;
              quantityValues = quantityValue;
              priceValues = priceValue;
              cardImage = ImageUrls;
              orderItemListIdDatas = orderItemListIdValue;

            });
            cardRatings = List.generate(responseData.length, (index) => 0);
            print("ProductNames:$ProductNames");
          }
        }
        else {
          print('Failed to fetch data for ID $userId. Status code: ${response
              .statusCode}');
        }
      } catch (error) {
        print('Error fetching data for ID $userId: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  String Message = '';

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

  TextEditingController ratingController = TextEditingController();
  late int rating = 0;

  late ValueChanged<int> onRatingChanged;
  late String review = "";

  // Future<void> postReviewData(int index) async {
  //   int? userId = await getUserId();
  //   print("userid:$userId");
  //   print("selectedProductListId:$selectedProductListId");
  //   print("ratingCount:${cardRatings[index]}");
  //   final url = Uri.parse(Constants.ipBaseUrl + 'review/save');
  //
  //   final Map<String, dynamic> data = {
  //     'starRate': [cardRatings[index]],
  //     'userId': userId,
  //     'productListId': selectedProductListId,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: jsonEncode(data),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //
  //     final responseData = jsonDecode(response.body);
  //     print('Output for review: $responseData');
  //
  //     if (response.statusCode == 200) {
  //       final responseDatasss = json.decode(response.body);
  //       Message = responseDatasss[
  //       'message'];
  //
  //       showToast();
  //     }
  //
  //     else {
  //       print('Failed to post data. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  int? sendrate;
  Future<void> postReviewData() async {
    int? userId = await getUserId();
    print("userid:$userId");
    print("selectedProductListId:$selectedProductListId");
    print("ratingCount:$sendrate");
    print("reviewId:$reviewId");
    final url = Uri.parse(Constants.ipBaseUrl + 'review/save');

    final Map<String, dynamic> data = {
      'starRate': sendrate, // Use square brackets for the list
      'userId': userId,
      'productListId': selectedProductListId,
      'reviewId': reviewId,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'charset=UTF-8' is not necessary for Content-Type
        },
      );

      final responseData = jsonDecode(response.body);
      print('Output for review: $responseData');

      if (response.statusCode == 200) {
        final responseDatasss = json.decode(response.body);
        Message = responseDatasss['message'];
        getOrderHistoryData();
        showToast();
      } else if(response.statusCode == 401){
        final responseData = jsonDecode(response.body);
        Message = responseData['Message'];
        print("error:$Message");
        showToast();
      }
      else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  TextEditingController reviewController = TextEditingController();

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
    int totalItemsrecom = product_list.length;
    var screenSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        backgroundColor: Colors.white,
        // appBar:  PreferredSize(
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                DashboardPage()),
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
                                    search = searchController.text.trim();
                                    print("search:$search");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          SearchDetailsPage(
                                              searchText: search)),
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
                                      builder: (context) =>
                                          OrderHistoryPage()));
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
                      FutureBuilder<List<DropdownModel>>(
                        future: getPost(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Text('No data available');
                          } else {
                            return GestureDetector(
                              onTap: () {

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      dropdownColor: Color(0xffef8f21),
                                      value: selectedValue,
                                      icon: Container(
                                          margin: EdgeInsets.only(left: 30.0),
                                          child: Icon(Icons.menu, size: 25.0,
                                              color: Colors.white)),
                                      hint: Text(
                                        "All Categories", style: TextStyle(
                                          color: Colors.white, fontSize: 22),),
                                      items: snapshot.data!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.categoryName.toString(),
                                          child: Text(e.categoryName ?? '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22),),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });

                                        DropdownModel selectedCategory = snapshot
                                            .data!.firstWhere(
                                              (element) =>
                                          element.categoryName == selectedValue,
                                        );
                                        print(
                                            "Selected categoryId: ${selectedCategory
                                                .categoryId}");

                                        // Navigate to the NextPage with the selected categoryId
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewProductListPage(
                                                    carosalcatid: [
                                                      selectedCategory
                                                          .categoryId ?? 0
                                                    ]),
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
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    children: [
                      Text("Home",
                          style: TextStyle(fontSize: 24, color: Colors.black)),
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
                      Text("my order",
                          style: TextStyle(fontSize: 24, color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("All orders",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("from anytime",
                              style: TextStyle(
                                fontSize: 20,
                              ))
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 182,
                      //       height: 51,
                      //       decoration: BoxDecoration(
                      //         color: Color(0x0c9c271b),
                      //         shape: BoxShape.rectangle,
                      //         border: Border.all(color: Color(0xffD2D2D2)),
                      //         borderRadius: BorderRadius.horizontal(
                      //           left: Radius.circular(50.0),
                      //         ),
                      //       ),
                      //       child: Center(
                      //           child: DropdownButton<String>(
                      //         value: dropdownValue1,
                      //         underline:
                      //             Container(), // This removes the underline
                      //         onChanged: (String? value) {
                      //           setState(() {
                      //             dropdownValue1 = value!;
                      //           });
                      //         },
                      //         items: list3.map((String value) {
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
                      //     ),
                      //     Container(
                      //         width: 170,
                      //         height: 51,
                      //         decoration: BoxDecoration(
                      //           border: Border.all(color: Color(0xffD2D2D2)),
                      //           color: Colors.white,
                      //           shape: BoxShape.rectangle,
                      //         ),
                      //         child: TextField(
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             contentPadding: EdgeInsets.all(20),
                      //           ),
                      //         )),
                      //     Stack(
                      //       children: [
                      //         Container(
                      //           width: 52,
                      //           height: 51,
                      //           decoration: BoxDecoration(
                      //             color: Color(0xffef8f21),
                      //             shape: BoxShape.rectangle,
                      //             border: Border.all(color: Color(0xffD2D2D2)),
                      //             borderRadius: BorderRadius.horizontal(
                      //               right: Radius.circular(50.0),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           top: 5.0,
                      //           left: 3.0,
                      //           child: IconButton(
                      //             onPressed: () {},
                      //             icon: const Icon(
                      //               Icons.search,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Container(
                      width: screenSize.width,
                      height: 1106,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color.fromRGBO(239, 143, 33, 0.79)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: responseData.length ,
                           // itemCount:5,
                          itemBuilder: (BuildContext context, int index) {
                            selectedOrderItemListId =
                            responseData[index]['orderItemListId'];
                            print(
                                'i am selected orderItemListId: $selectedOrderItemListId');

                            selectedProductListId =
                            responseData[index]['productListId'];
                            print(
                                'i am selected ProductListId: $selectedProductListId');

                            reviewId=
                            responseData[index]['reviewId'];
                            print(
                                'i am selected reviewId: $reviewId');

                            starRate=
                            responseData[index]['starRate']??0;
                            print(
                                'i am selected reviewId: $reviewId');

                            if (responseData != null &&
                                index < responseData.length) {
                              return Container(
                                  width: 1301,
                                  height: 600,
                                  // padding: EdgeInsets.only(left: 50),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(3.925373077392578),
                                      color: Color.fromRGBO(
                                          255, 255, 255, 0.79)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 39.0,
                                              height: 39.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                  child: Image.asset(
                                                      "images/Box.png")),
                                            ),
                                            SizedBox(width: 10.0),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 40.0),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Visibility(
                                                        visible: true,
                                                        child: Text(
                                                            "Your Order Date is",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            )),
                                                      ),
                                                      Visibility(
                                                        visible: false,
                                                        child: Text(
                                                            "On Shipping",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            )),
                                                      ),
                                                      Visibility(
                                                        visible: false,
                                                        child: Text("Delivered",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(OrderDate[index],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 25.0),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderViewPage(
                                                                selectedOrderItemListId: responseData[index]['orderItemListId'])));
                                              },
                                              child: Container(
                                                width: 1330,
                                                height: 235,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        2.071641683578491),
                                                    color: Color(0xc9ffffff)),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: 222,
                                                        height: 198,
                                                        child: Card(
                                                          elevation: 20.0,
                                                          child: Center(
                                                            child: Image
                                                                .network(
                                                                Constants
                                                                    .ipBaseUrl +
                                                                    cardImage[index]!,
                                                                width: 114,
                                                                height:
                                                                138.40805053710938),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20.0),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                              height: 20.0),
                                                          Visibility(
                                                              visible: false,
                                                              child: SizedBox(
                                                                  height: 20.0)),
                                                          Container(
                                                            width: 98,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    12),
                                                                color: Color(
                                                                    0x91ef8f21)),
                                                            child: Center(
                                                              child: Text(
                                                                  ProductNames[index],
                                                                  style: TextStyle(
                                                                      fontSize: 15,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Text(
                                                              Description[index],
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              )),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Text(
                                                              "₹${mrpValues[index]}",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color(
                                                                      0xff717171))),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "₹${priceValues[index]}",
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                  )),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              Text(
                                                                  "Quantity: (${quantityValues[index]})",
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      color: Color(
                                                                          0xff717171))),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Stack(
                                                            children: [
                                                              Visibility(
                                                                visible: false,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    showOrderTrackingDialog(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      width: 223,
                                                                      height: 42,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              2.071641683578491),
                                                                          color: Color(
                                                                              0xffef8f21)),
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Row(
                                                                            children: [
                                                                              Center(
                                                                                  child: Image
                                                                                      .asset(
                                                                                      "images/Track.png")),
                                                                              SizedBox(
                                                                                  width: 10.0),
                                                                              Text(
                                                                                  "Track your oder",
                                                                                  style: TextStyle(
                                                                                      fontSize: 22,
                                                                                      color: Colors
                                                                                          .white))
                                                                            ]),
                                                                      )),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: false,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    showOrderReturnDialog(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                    width: 223,
                                                                    height: 42,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            2.071641683578491),
                                                                        color: Color(
                                                                            0xffef8f21)),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          Center(
                                                                              child:
                                                                              Image
                                                                                  .asset(
                                                                                  "images/Cash on delivery.png")),
                                                                          SizedBox(
                                                                              width:
                                                                              10.0),
                                                                          Text(
                                                                              "Return",
                                                                              style: TextStyle(
                                                                                  fontSize: 22,
                                                                                  color: Colors
                                                                                      .white))
                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: false,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    showOrderRefundDialog(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                    width: 223,
                                                                    height: 42,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            2.071641683578491),
                                                                        color: Color(
                                                                            0xffef8f21)),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          Visibility(
                                                                            visible:
                                                                            false,
                                                                            child: Center(
                                                                                child:
                                                                                Image
                                                                                    .asset(
                                                                                    "images/Cash on delivery.png")),
                                                                          ),
                                                                          SizedBox(
                                                                              width:
                                                                              10.0),
                                                                          Text(
                                                                              "Refund",
                                                                              style: TextStyle(
                                                                                  fontSize: 22,
                                                                                  color: Colors
                                                                                      .white))
                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Visibility(
                                                            visible: true,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 6.0,
                                                                  height: 6.0,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xff0A9A21),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 10.0),
                                                                Stack(
                                                                  children: [
                                                                    Visibility(
                                                                      visible:
                                                                      false,
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                              "Return available till",
                                                                              style:
                                                                              TextStyle(
                                                                                fontSize:
                                                                                16,
                                                                              )),
                                                                          Text(
                                                                              " 11 Nov",
                                                                              style:
                                                                              TextStyle(
                                                                                fontSize:
                                                                                16,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                      false,
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                              "Return available till",
                                                                              style:
                                                                              TextStyle(
                                                                                fontSize:
                                                                                16,
                                                                              )),
                                                                          Text(
                                                                              " 11 Nov",
                                                                              style:
                                                                              TextStyle(
                                                                                fontSize:
                                                                                16,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                      true,
                                                                      child: Text(
                                                                          "Your Order ${statusValue[index]}",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Color(
                                                                                0xffef8f21),
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                            16,
                                                                          )),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                      false,
                                                                      child: Text(
                                                                          "Your Return Request accepted",
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            16,
                                                                          )),
                                                                    ),
                                                                    Visibility(
                                                                      visible: false,
                                                                      child: Text(
                                                                          "Your refund payment is onprocess",
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            16,
                                                                          )),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                      false,
                                                                      child: Text(
                                                                          "Your payment refund completed",
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            16,
                                                                          )),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 460.0),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 100.0),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        OrderViewPage(
                                                                            selectedOrderItemListId: responseData[index]['orderItemListId'])));
                                                          },
                                                          icon: Icon(Icons
                                                              .arrow_forward_ios)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            buildRatingCard(),



                                            // SizedBox(height: 20.0),
                                            // Center(
                                            //   child: Container(
                                            //     width: 215,
                                            //     height: 50,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius:
                                            //       BorderRadius.circular(10),
                                            //     ),
                                            //     child: ElevatedButton(
                                            //       style: ElevatedButton
                                            //           .styleFrom(
                                            //         primary: Color(
                                            //             0xffEF8F21), // Background color
                                            //       ),
                                            //       onPressed: () {
                                            //          {
                                            //           postReviewData();
                                            //         }
                                            //       },
                                            //       child: Text(
                                            //           "Save Your Ratings",
                                            //           style: TextStyle(
                                            //               fontSize: 18,
                                            //               color: Colors.white)),
                                            //     ),
                                            //   ),
                                            // ),
                                            // SizedBox(height: 2.0),

                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            } else {
                              return Container();
                            }
                          }
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
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
        ));
  }

  // Widget hideButton1() {
  //   return Container(
  //     width: 36,
  //     height: 15,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30), color: Color(0xfffab442)),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               setState(() {
  //                 if (counters[currentQuantityIndex] != 1) {
  //                   counters[currentQuantityIndex]--;
  //                 } else {
  //                   isPressedList[currentQuantityIndex] = false;
  //                 }
  //               });
  //             },
  //             child: Image.asset(
  //               "images/minus.png",
  //               color: Colors.white,
  //               width: 7.0,
  //               height: 7.0,
  //             ),
  //           ), // <-- Text
  //
  //           Center(
  //             child: Text(
  //               "${counters[currentQuantityIndex]}",
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 11,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //
  //           InkWell(
  //             onTap: () {
  //               setState(() {
  //                 if (counters[currentQuantityIndex] <= 4) {
  //                   counters[currentQuantityIndex]++;
  //                 }
  //               });
  //             },
  //             child: Image.asset(
  //               "images/plus.png",
  //               color: Colors.white,
  //               width: 7.0,
  //               height: 7.0,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Widget buildRatingCard() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 20),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Ratings: $starRate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: List.generate(
                5,
                    (starIndex) =>
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          starRate = starIndex + 1;
                        });
                      },
                      child: Icon(
                        starIndex < starRate
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                    ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Show dialog to input new rating
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Edit Rating"),
                      content: TextField(
                        controller: ratingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Give ratings upto 5"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Update the rating
                            setState(() {
                              sendrate = int.parse(ratingController.text);
                            });
                            // Send the updated rating to backend
                            postReviewData();
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text("Save"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Edit Rating'),
            ),
          ],
        ),
      ),
    );
  }





// Container(
//   width: 1340,
//   height: 200,
//   decoration: BoxDecoration(
//       borderRadius:
//       BorderRadius.circular(
//           2.071641683578491),
//       color: Color.fromRGBO(
//           239, 143, 33, 0.32)),
//   child: Padding(
//     padding: const EdgeInsets.only(
//         left: 15.0),
//     child: Column(
//       crossAxisAlignment:
//       CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: Text("Feedback",
//                 style: TextStyle(
//                   fontSize: 18,
//                 )),
//         ),
//
//         Container(
//             width: 1300,
//             height: 52,
//             // decoration: BoxDecoration(
//             //   color: Color.fromRGBO(
//             //       239, 143, 33, 0.32),
//             //   shape: BoxShape.rectangle,
//
//             child: TextFormField(
//             validator: (value) {
//                   if (value == null || value.isEmpty) {
//                        return "Please give your review.";
//                   }
//                  return null;
//                    },
//                controller: reviewController,
//               decoration:
//               InputDecoration(
//                 hintText: 'Type here',
//                 border:
//                 InputBorder.none,
//                 contentPadding:
//                 EdgeInsets.all(10),
//               ),
//             )),
//         SizedBox(height:50.0),
//         Center(
//           child: Container(
//             width: 215,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius:
//               BorderRadius.circular(10),
//             ),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Color(
//                     0xffEF8F21), // Background color
//               ),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   review =
//                       reviewController
//                           .text
//                           .trim();
//                   postReviewData();
//                 }
//               },
//               child: Text("Send Feedback",
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white)),
//             ),
//           ),
//         ),
//         // Text("Type here",
//         //     style: TextStyle(
//         //       fontSize:
//         //           12.16128921508789,
//         //     ))
//       ],
//     ),
//   ),
// )




}