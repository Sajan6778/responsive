import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/payment.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:responsive/pages/wishlist_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Aboutus.dart';
import 'Addressmanager.dart';
import 'Cartpage.dart';
import 'Login.dart';
import 'addresstype.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'dropdown_model.dart';
import 'faqpage.dart';
import 'newaddress_dialogbox.dart';
import 'newproductlist.dart';
import 'order_orderhistory.dart';
import 'package:http/http.dart' as http;


class AddressPage extends StatelessWidget {
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

class _MyScrollableColumnState extends State<MyScrollableColumn> {

  final AddressManager addressManager = AddressManager();
  double retrievedTotalAmount = 0.0;

  AddressType? selectedAddress;
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  late String search;
  TextEditingController searchController = TextEditingController();

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



  List<String>? userStAdd = [];
  List<String>? userCity = [];
  List<String>? userState = [];
  List<String>? userCountry = [];
  List<String>? userPostCode = [];
  List<String>? userAddressId = [];


  @override
  void initState() {
    super.initState();
    _initData();
    _getTotalAmount();
    getValue();
    _initializeState();
  }


  final AuthService authService = AuthService();

  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }
  int length=0;

  Future<void> getValue() async {
    length = await getProductsCartLength();
    print('Length of productsCart: $length');
  }

  Future<void> _initData() async {
    await addressManager.updateAddresses();

   retrieveValuesFromSharedPreferences();

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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;



    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AddressManager>(
        builder: (context, addressManager, _){
          String streetAddress = addressManager.userStAdd.isNotEmpty
              ? addressManager.userStAdd[0]
              : "";
          print("dudfd_streetAddress:$streetAddress");
          return     SingleChildScrollView(
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
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                                  Text("Cart",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.black)),
                                ],
                              ),
                              SizedBox(height: 40.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text("Cart",
                                          style: TextStyle(
                                              fontSize: 24, color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Visibility(
                                        visible: false,
                                        child: Image.asset(
                                          "images/Line 19.png",
                                          width: 70.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10.0),
                                  Image.asset(
                                    "images/Line 9.png",
                                    width: 70.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    children: [
                                      Text("Address",
                                          style: TextStyle(
                                              fontSize: 24, color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Image.asset(
                                        "images/Line 19.png",
                                        width: 70.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10.0),
                                  Image.asset(
                                    "images/Line 9.png",
                                    width: 70.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    children: [
                                      Text("Payment",
                                          style: TextStyle(
                                              fontSize: 24, color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Visibility(
                                        visible: false,
                                        child: Image.asset(
                                          "images/Line 19.png",
                                          width: 70.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                  width: screenSize.width,
                                  height: 260,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      color: Color(0xffef8f21)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0, vertical: 10.0),
                                          child: Text("Order Summary",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white)),
                                        ),
                                        SizedBox(height: 8.0),
                                        Container(
                                          width: 1426,
                                          height: 180,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child:  Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text("Total Ammount payable",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.black)),
                                                    Text("₹${retrievedTotalAmount.toStringAsFixed(2)} ",
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.black))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text("Total Items",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.black)),
                                                    Text("$length items",
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.black))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 40.0),
                              // Row(
                              //   children: [
                              //     IconButton(
                              //         onPressed: () {}, icon: Icon(Icons.warning)),
                              //     Text(
                              //         "Select your address and delivery slot to know accurate delivery charges. You can save more by applying a voucher!",
                              //         style: TextStyle(
                              //           fontSize: 19.678348541259766,
                              //         ))
                              //   ],
                              // ),
                              SizedBox(height: 50.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery Address",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  InkWell(
                                    onTap: () {
                                      showNewAddressDialog(context);
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text("Edit Address",
                                              style: TextStyle(
                                                fontSize: 24,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add_circle)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: screenSize.width,
                        height: 43,
                        decoration: BoxDecoration(color: Color(0x19ef8f21)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 6.0),
                          child: Text("Address",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      Container(
                        width: screenSize.width,

                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 50.0),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Zip/Postal Code",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.black)),
                                                SizedBox(height: 20.0),
                                                Container(
                                                  width: 356,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(4),
                                                      color: Color(0x2bef8f21)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Text(
                                                        userPostCode?.isNotEmpty == true ? userPostCode![0] : 'N/A',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                        )),
                                                  ),

                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 300.0),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Street Address",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.black)),
                                                SizedBox(height: 20.0),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Container(
                                                    width: 500,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(4),
                                                        color: Color(0x2bef8f21)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(vertical: 10.0,
                                                          horizontal: 20.0),
                                                      child: Text(
                                                          userStAdd?.isNotEmpty == true ? userStAdd![0] : 'N/A',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 30.0),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("District",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.black)),
                                                SizedBox(height: 20.0),
                                                Container(
                                                  width: 356,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(4),
                                                      color: Color(0x2bef8f21)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Text(
                                                        userCity?.isNotEmpty == true ? userCity![0] : 'N/A',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 300.0),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Country",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.black)),
                                                SizedBox(height: 20.0),
                                                Container(
                                                  width: 356,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(4),
                                                      color: Color(0x2bef8f21)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Text(
                                                        userCountry?.isNotEmpty == true ? userCountry![0] : 'N/A',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                        )),
                                                  ),)
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 30.0),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("State/Province",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.black)),
                                                SizedBox(height: 20.0),
                                                Container(
                                                  width: 356,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(4),
                                                      color: Color(0x2bef8f21)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Text(
                                                        userState?.isNotEmpty == true ? userState![0] : 'N/A',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                        )),
                                                  ),)
                                              ],
                                            ),
                                            SizedBox(width: 300.0),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Save address as",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.black)),
                                                SizedBox(height: 20.0),

                                                Row(
                                                  children: [
                                                    Consumer<AddressManager>(
                                                      builder: (context, addressManager, _) {
                                                        return Radio(
                                                          value: AddressType.home,
                                                          groupValue: addressManager.selectedAddressType,
                                                          onChanged: (AddressType? value) async {
                                                            addressManager.selectedAddressType = AddressType.home;

                                                            try {
                                                              await addressManager.updateAddresses();
                                                              retrieveValuesFromSharedPreferences();
                                                            } catch (error) {
                                                              print('Error updating addresses: $error');
                                                            }
                                                          },
                                                          activeColor: Colors.green,
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      "Home Address",
                                                      style: TextStyle(fontSize: 17,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),

                                                // Row(
                                                //   children: [
                                                //     Consumer<AddressManager>(
                                                //       builder: (context, addressManager, _) {
                                                //         return Radio(
                                                //           value: AddressType.work,
                                                //           groupValue: addressManager.selectedAddressType,
                                                //           onChanged: (AddressType? value) async {
                                                //             addressManager.selectedAddressType = AddressType.work;
                                                //
                                                //             try {
                                                //               await addressManager.updateAddresses();
                                                //               retrieveValuesFromSharedPreferences();
                                                //             } catch (error) {
                                                //               print('Error updating addresses: $error');
                                                //             }
                                                //           },
                                                //           activeColor: Colors.green,
                                                //         );
                                                //       },
                                                //     ),
                                                //
                                                //     SizedBox(width: 10.0),
                                                //     Text(
                                                //       "Work Address",
                                                //       style: TextStyle(fontSize: 17,
                                                //           color: Colors.black),
                                                //     ),
                                                //   ],
                                                // ),

                                              ],
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 30.0),
                                        // Row(
                                        //   children: [
                                        //     Align(
                                        //       alignment: Alignment.topLeft,
                                        //       child: Checkbox(
                                        //         checkColor: Color(0xffEF8F21),
                                        //         fillColor:
                                        //         MaterialStateProperty.resolveWith(
                                        //             getColor),
                                        //         value: isChecked,
                                        //         onChanged: (bool? value) {
                                        //           setState(() {
                                        //             isChecked = value!;
                                        //           });
                                        //         },
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 10.0),
                                        //     Text("Make this my default address",
                                        //         style: TextStyle(
                                        //             fontSize: 17, color: Colors.black)),
                                        //   ],
                                        // ),
                                        SizedBox(height: 50.0),
                                        InkWell(
                                          onTap: () {},
                                          child: Center(
                                            child: Container(
                                              width: 220,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    12),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                      0xffEF8F21), // Background color
                                                ),
                                                onPressed: () {

                                               Navigator.push(
                                                  context,
                                                MaterialPageRoute(
                                                   builder: (context) =>
                                                  PaymentPage()));
                                                },
                                                child: Text("CONTINUE",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
          );
        }

      ),
    );
  }


  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  void retrieveValuesFromSharedPreferences() async{
    SharedPreferences prefs =await SharedPreferences.getInstance() ;



    setState(() {

      // Retrieve streetAddressValue
      userStAdd = prefs.getStringList('userStAdd');

      // Retrieve cityValue
      userCity = prefs.getStringList('userCity');

      // Retrieve stateValue
      userState = prefs.getStringList('userState');

      // Retrieve countryValue
      userCountry = prefs.getStringList('userCountry');

      // Retrieve postalCodeValue
      userPostCode = prefs.getStringList('userPostCode');

      // Retrieve addressIdValue
      userAddressId = prefs.getStringList('userAddressId');
      if (userStAdd != null) {
        print('userStAdd: $userStAdd');
      }

      if (userCity != null) {
        print('userCity___: $userCity');
      }

      if (userState != null) {
        print('userState___: $userState');
      }

      if (userCountry != null) {
        print('userCountry: $userCountry');
      }

      if (userPostCode != null) {
        print('userPostCode: $userPostCode');
      }

      if (userAddressId != null) {
        print('userAddressId: $userAddressId');
      }
    });

  }

  Future<void> _getTotalAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      retrievedTotalAmount = prefs.getDouble('totalAmount') ?? 0.0;
    });
  }


  Future<int> getProductsCartLength() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('productsCartLength') ?? 0;
  }

}


