import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive/pages/pdf%20file.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:responsive/pages/star.dart';
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
import 'order_orderhistory.dart';
import 'ordercanceldialog.dart';
import 'orderreturn.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

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

class OrderViewPage extends StatefulWidget {
 final dynamic selectedOrderItemListId;

  const OrderViewPage({super.key,required this.selectedOrderItemListId});

  @override
  State<OrderViewPage> createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  String dropdownValue = list.first;
  String dropdownValue1 = list3.first;
  String dropdownValues = list1.first;
  bool isChecked = false;
  bool isCancel = false;

  int hoveredIndex = -1;
  int hoveredIndexrecom = -3;

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
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

  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String search;

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

  String Message="";
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


  late String pdfUrl="";
  void _downloadPdf() {
    // final String pdfUrl = "http://192.168.29.44:8081/pdf/255329/2.pdf";
    final anchor = html.AnchorElement(href: pdfUrl)
      ..target = 'blank'
      ..download = 'downloaded_file.pdf'
      ..click();
  }

  var selectedValue;



  String date='';
  String ImageUrl='';
  double mrp=0.0;
  double price=0.0;
  double singlePrice=0.0;
  double quantity=0.0;
  String des='';
  String status='';
  String proName='';
  String userName='';
  int mobileNumber=0;
  String stateAddress='';
  String city='';
  String state='';
  String country='';

  dynamic orderItemListId;
  dynamic orderItemId;


  List<dynamic> responseData = [];
  List<dynamic> responseDatas = [];


  @override
  void initState() {
    super.initState();


    getOrderDetail(widget.selectedOrderItemListId);
    print("${widget.selectedOrderItemListId}");
    _initializeState();
  }

  final AuthService authService = AuthService();

  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }


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


  Future<void> getOrderDetail(selectedOrderItemListId) async {
    print("orderview : selectedOrderItemListId:${widget.selectedOrderItemListId}");
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl + 'orderItemListDetails';

    try {
      final url = Uri.parse('$baseUrl/$userId/${widget.selectedOrderItemListId}');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);

        print('orderDetailData for User ID $userId: $responseData');

        if (responseData.isNotEmpty) {


          for (var productData in responseData) {
            setState(() {
              date = productData['date'] ?? "";
              print("date:$date");
              ImageUrl = productData['productVarientImageUrl'] ?? "";
              mrp = productData['mrp'] ;
              print("mrp:$mrp");
              price = productData['totalPrice'] ;
              singlePrice = productData['totalAmount'] ;
              quantity = productData['quantity'] ;
              des = productData['description'] ?? "";
              status = productData['orderStatus'] ?? "";
              print("status:$status");
              // Fix the condition here
              // if (status == "is pending" || status == "confirmed") {
              //
              // }
              proName = productData['productName'] ?? "";
              orderItemListId = productData['orderItemListId'] ;
              orderItemId = productData['orderItemId'] ;
              saveOrderItemListId(orderItemListId);
              userName = productData['userName'] ;
              stateAddress = productData['stateAddress'] ;
              mobileNumber = productData['mobileNumber'] ;
              print("mobileNumber:$mobileNumber");
              city = productData['city'] ;
              state = productData['state'] ;
              country = productData['country'] ;

            });




            // Add additional checks and prints
            // if (mrp == null) {
            //   print("Warning: mrp is null or not a number");
            // }
            //
            // if (price == null) {
            //   print("Warning: price is null or not a number");
            // }

            // Now you can use date, ImageUrl, mrp, price, des, and proName safely
            print("date: $date");
            print("ImageUrl: $ImageUrl");
            // print("mrp: $mrp");
            // print("price: $price");
            print("des: $des");
            print("proName: $proName");

          }

        }
      }
      else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getInvoice() async {
    print("orderview : selectedOrderItemListId:${widget.selectedOrderItemListId}");
    print("orderview : selectedOrderItemId:$orderItemId");
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl + 'invoicePdfDownload';

    try {
      final url = Uri.parse('$baseUrl/$userId/$orderItemId');
      // final url = Uri.parse('$baseUrl/3/1');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        responseDatas = jsonDecode(response.body);

        print('InvoiceData for User ID $userId: $responseDatas');

        if (responseDatas.isNotEmpty) {


          for (var productData in responseDatas) {
            setState(() {
              pdfUrl=productData["url"]??"";
              print("pdfUrl:$pdfUrl");
              _downloadPdf();
            });


          }

        }
      }
      else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    int totalItemsrecom = product_list.length;
    var screenSize = MediaQuery.of(context).size;

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
                height: 30.0,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                        width: 1172,
                        height: 750,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEF8F21)),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 50.0),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(left: 1000.0),
                                  //   child: Container(
                                  //     width: 115,
                                  //     height: 34.925926208496094,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(
                                  //             21.296295166015625),
                                  //         color: Color(0x2bef8f21)),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       children: [
                                  //         Image.network(
                                  //           "images/Online support.png",
                                  //           color: Colors.black,
                                  //           width: 17.0,
                                  //           height: 17.0,
                                  //         ),
                                  //         SizedBox(width: 10.0),
                                  //         Text("help",
                                  //             style: TextStyle(
                                  //               fontSize: 20,
                                  //             ))
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                      width: 232,
                                      height: 206,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              4.10762357711792),
                                          color: Color(0x2bef8f21)),
                                      child:   Constants.ipBaseUrl+ImageUrl!=null ?
                                      Image.network(
                                        Constants.ipBaseUrl+ImageUrl,
                                        width: 134,
                                        height: 134,
                                      ):Text(("No Image Available"))),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(proName,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                      des,
                                      style: TextStyle(
                                        fontSize: 19,
                                      )),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("₹${singlePrice.toString()}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                      SizedBox(width: 10.0),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child:Text("₹${mrp.toString()}",
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration
                                                    .lineThrough,
                                                fontSize: 18,
                                                color: Color(
                                                    0xff717171))),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
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
                                        ),
                                        SizedBox(
                                            width: 10.0),
                                        Visibility(
                                          visible:
                                          true,
                                          child: Text(
                                              "Your Order ${status}",
                                              style:
                                              TextStyle(
                                                color: Color(0xffef8f21),
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                16,
                                              )),
                                        ),
                                      ],
                                    ),

                                ],
                              ),
                            ),
                            SizedBox(height: 50.0),
                            Container(
                              width: 1172,
                              height: 85,
                              decoration:
                                  BoxDecoration(color: Color(0x2bef8f21)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 29.0,
                                          height: 29.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                              child: Image.asset(
                                            "images/Box.png",
                                            width: 19.0,
                                            height: 19.0,
                                          )),
                                        ),
                                        SizedBox(width: 20.0),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0),
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
                                                    child: Text("On Shipping",
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
                                              Text(date,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                 Stack(
                                   children: [
                                     Visibility(
                                        visible: status == "delivered" ,
                                       child: InkWell(
                                         onTap: () {
                                           showOrderReturnDialog(context);
                                         },
                                         child: Container(
                                           width: 268,
                                           height: 57,
                                           decoration: BoxDecoration(
                                               color: Color(0xffef8f21)),
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.center,
                                             children: [
                                               Image.asset(
                                                   ("images/Cash on delivery.png")),
                                               SizedBox(
                                                 width: 20.0,
                                               ),
                                               Text("Return",
                                                   style: TextStyle(
                                                       fontSize: 24,
                                                       color: Colors.white))
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),

                                     Visibility(
                                       visible: status == "is pending" || status == "confirmed",
                                       child: InkWell(
                                         onTap: () {
                                           _showMyDialog();
                                         },
                                         child: Container(
                                           width: 268,
                                           height: 57,
                                           decoration: BoxDecoration(
                                               color: Color(0xffef8f21)),
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.center,
                                             children: [
                                               Image.asset(
                                                   ("images/cancelicon.png"),color: Colors.white,),
                                               SizedBox(
                                                 width: 20.0,
                                               ),
                                               Text("Cancel",
                                                   style: TextStyle(
                                                       fontSize: 24,
                                                       color: Colors.white))
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                     Visibility(
                                       visible: status == "return request accepted" ,
                                       child: InkWell(
                                         onTap: () {

                                         },
                                         child: Container(
                                           width: 268,
                                           height: 57,
                                           decoration: BoxDecoration(
                                               color: Color(0xffef8f21)),
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.center,
                                             children: [
                                               Image.asset(
                                                 ("images/Cash on delivery.png"),color: Colors.white,),
                                               SizedBox(
                                                 width: 20.0,
                                               ),
                                               Text("Refund",
                                                   style: TextStyle(
                                                       fontSize: 24,
                                                       color: Colors.white))
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 22.0),
                            Container(
                                width: 1172,
                                height: 97,
                                decoration:
                                    BoxDecoration(color: Color(0x2bef8f21)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      // Container(
                                      //   width: 74.0,
                                      //   height: 74.0,
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: Colors.white,
                                      //   ),
                                      //   child: Center(
                                      //       child: Image.asset(
                                      //     "images/image 23.png",
                                      //     width: 35.0,
                                      //     height: 40.0,
                                      //   )),
                                      // ),
                                      // SizedBox(width: 12.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Product Ratings",
                                              style: TextStyle(
                                                fontSize: 20,
                                              )),
                                          SizedBox(height: 10.0),
                                          buildRatingCard1(3.5),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(height: 40.0),
                    IntrinsicHeight(
                      child: Container(
                        width: 1172,
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEF8F21)),
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x02ffffff)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Delivery Address",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Text(userName,
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  SizedBox(width: 10.0),
                                  Container(
                                      height: 30,
                                      color: Colors.white,
                                      child: VerticalDivider(
                                          width: 6, color: Colors.black)),
                                  SizedBox(width: 10.0),
                                  Text(mobileNumber.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ))
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  stateAddress,
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              SizedBox(height: 10.0),
                              Text(
                                  city,
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              SizedBox(height: 10.0),
                              Text(
                                  state,
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              SizedBox(height: 10.0),
                              Text(
                                  country,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      width: 1172,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffEF8F21)),
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0x02ffffff)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Total Order Price",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        )),

                                    // SizedBox(height: 10.0),
                                    // Row(
                                    //   children: [
                                    //     Text("You saved",
                                    //         style: TextStyle(
                                    //           fontSize: 20,
                                    //         )),
                                    //     Text("₹ 1150.00",
                                    //         style: TextStyle(
                                    //           fontSize: 20,
                                    //         )),
                                    //     Text("on this order",
                                    //         style: TextStyle(
                                    //           fontSize: 20,
                                    //         ))
                                    //   ],
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Quantity: (${quantity.toString()})",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(
                                            0xff717171))),
                                SizedBox(width: 600.0),
                                Text("₹${price.toString()}",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                          // SizedBox(height: 20.0),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 20.0),
                          //   child: Container(
                          //     width: 1172,
                          //     height: 64,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Color(0xffEF8F21),
                          //         ),
                          //         borderRadius: BorderRadius.circular(4),
                          //         color: Color(0x2bef8f21)),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         SizedBox(width: 20.0),
                          //         Image.asset(
                          //           "images/Cash on delivery.png",
                          //           color: Colors.black,
                          //         ),
                          //         SizedBox(width: 20.0),
                          //         Text("Pay on delivery",
                          //             style: TextStyle(
                          //               fontSize: 20,
                          //             ))
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: (){
                              getInvoice();
                              // _downloadPdf();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                width: 1172,
                                height: 64,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffEF8F21),
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white),
                                child: Center(
                                  child: Text("Get invoice",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffEF8F21))),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    // Container(
                    //   width: 1172,
                    //   height: 129,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Color(0xffEF8F21)),
                    //       borderRadius: BorderRadius.circular(4),
                    //       color: Color(0x02ffffff)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text("Updates sent to",
                    //             style: TextStyle(
                    //               fontSize: 28,
                    //               fontWeight: FontWeight.bold,
                    //             )),
                    //         SizedBox(height: 20.0),
                    //         Row(
                    //           children: [
                    //             Image.asset("images/Viber.png"),
                    //             SizedBox(width: 20.0),
                    //             Text("6349803472",
                    //                 style: TextStyle(
                    //                   fontSize: 20,
                    //                 ))
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 40.0),
                    Container(
                      width: 1172,
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffEF8F21)),
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0x02ffffff)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text("Order ID : ",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text(orderItemId.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
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
        ));
  }
  Widget buildRatingCard1( double rating) {
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
              size: 20,
            ),
          ),
        ),
        if (fractionalStarValue > 0)
          FractionalStar1(fractionalStarValue),
        SizedBox(width: 10),
        Text(
          '$rating',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('OrderCancel'),
          content: Text('Are you sure you want to cancel your order'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async{
                 Navigator.of(context).pop();
                showOrderCancelDialog(context);
                // sendCancel();

              },
            ),
          ],
        );
      },
    );
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> saveOrderItemListId(int orderitemlistid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('orderitemlistid', orderitemlistid);
    print('saved orderitemlistid: $orderitemlistid');

  }
}
