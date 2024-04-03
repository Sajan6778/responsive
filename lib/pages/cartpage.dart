
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'dart:convert';

import 'package:responsive/pages/user_profile%20page.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:responsive/pages/wishlist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Aboutus.dart';
import 'Addresspage.dart';
import 'Login.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'dropdown_model.dart';
import 'faqpage.dart';
import 'newproductlist.dart';
import 'order_orderhistory.dart';

class CartPage extends StatelessWidget {
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

class Product {
  final String image;
  final String name;
  final double price;
  final double mrp;
  final String des;
  int quantity;

  Product(this.image, this.name, this.price, this.mrp, this.des,
      {this.quantity = 1});
}


  class ProductCart {
  final String images;
  final String names;
  final double prices;
  final double mrps;
  final String dess;
  final dynamic id;
  final dynamic productListId;
  double shipping;
  int quantitys;
  double totalPricecart;
  double newMRPCart;


  ProductCart(
      this.images,
      this.names,
      this.prices,
      this.mrps,
      this.dess,
      this.id,
      this.productListId,
      this.shipping,
      )   : quantitys = 1,
        totalPricecart = prices * 1,
        newMRPCart = mrps * 1;
  }

class _MyScrollableColumnState extends State<MyScrollableColumn> {
  double totalPriceSum = 0.0;
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;
  // late List<bool> isPressedList;
  // late List<int> counters;
  late List<bool> isPressedListCart;
  late List<int> countersCart;

  @override
  void initState() {
    super.initState();
    // isPressedList = List.generate(products.length, (index) => false);
    // counters = List.generate(products.length, (index) => 1);
    // Generate lists based on the length of productsCart
    // isPressedListCart = List.generate(productsCart.length, (index) => false);
    // countersCart = List.generate(productsCart.length, (index) => 1);
    // fetchData();
    getCartData();
    _initializeState();
  }
  final AuthService authService = AuthService();

  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }

  // List<Product> products = [
  //   Product(
  //     "images/fish.png",
  //     "Men Hoodie",
  //     1452.0,
  //     1568.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //   Product(
  //     "images/mobile.png",
  //     "Women pink top",
  //     1800.0,
  //     2000.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //
  //   Product(
  //     "images/mobile.png",
  //     "Women pink top",
  //     1800.0,
  //     2000.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //   Product(
  //     "images/mobile.png",
  //     "Women pink top",
  //     1800.0,
  //     2000.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //   Product(
  //     "images/mobile.png",
  //     "Women pink top",
  //     1800.0,
  //     2000.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //   Product(
  //     "images/mobile.png",
  //     "Women pink top",
  //     1800.0,
  //     2000.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //   Product(
  //     "images/mobile.png",
  //     "Women pink top",
  //     1800.0,
  //     2000.0,
  //     "Basa Fillet - Fresh Chilled, Preservative Free/Pungas",
  //   ),
  //   // Add other products similarly...
  // ];

  List<ProductCart> productsCart = [];
  dynamic responseData;

  // List<ProductCart> productsCart = [
  //   ProductCart("images/fish.png", "Men Hoodie", 1452.0, 1568.0,
  //       "Basa Fillet - Fresh Chilled, Preservative Free/Pungas", 0.0),
  //   ProductCart("images/mobile.png", "Women pink top", 1800.0, 2000.0,
  //       "Basa Fillet - Fresh Chilled, Preservative Free/Pungas", 0.0),
  //
  //   ProductCart("images/fish.png", "Men Hoodie", 1452.0, 1568.0,
  //       "Basa Fillet - Fresh Chilled, Preservative Free/Pungas", 0.0),
  //   ProductCart("images/mobile.png", "Women pink top", 1800.0, 2000.0,
  //       "Basa Fillet - Fresh Chilled, Preservative Free/Pungas", 0.0),
  //
  //   ProductCart("images/fish.png", "Men Hoodie", 1452.0, 1568.0,
  //       "Basa Fillet - Fresh Chilled, Preservative Free/Pungas", 0.0),
  //   ProductCart("images/mobile.png", "Women pink top", 1800.0, 2000.0,
  //       "Basa Fillet - Fresh Chilled, Preservative Free/Pungas", 0.0),
  //
  //   // Add other products similarly...
  // ];

  // void incrementCounter(int index) {
  //   setState(() {
  //     products[index].quantity++;
  //   });
  // }
  //
  // void decrementCounter(int index) {
  //   setState(() {
  //     if (products[index].quantity > 1) {
  //       products[index].quantity--;
  //     }
  //   });
  // }

  void incrementCounters(int index) {
    setState(() {
      productsCart[index].quantitys++;

      productsCart[index].totalPricecart =
          productsCart[index].prices * productsCart[index].quantitys;
      productsCart[index].newMRPCart =
          productsCart[index].mrps * productsCart[index].quantitys;
      totalCartPrice = getTotalCartPrice(productsCart);

    });
  }

  void decrementCounters(int index) {
    setState(() {
      if (productsCart[index].quantitys > 1) {
        productsCart[index].quantitys--;
        // Recalculate totalPrice and newMRP when quantity changes
        productsCart[index].totalPricecart =
            productsCart[index].prices * productsCart[index].quantitys;
        productsCart[index].newMRPCart =
            productsCart[index].mrps * productsCart[index].quantitys;

        totalCartPrice = getTotalCartPrice(productsCart);
      }
    });
  }

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  double getTotalCartPrice(List<ProductCart> cartItems) {
    double totalCartPrice = 0;

    for (var cartItem in cartItems) {
      totalCartPrice += cartItem.totalPricecart;
    }

    print('Total Price of Cart: $totalCartPrice');
    return totalCartPrice;
  }

  List<dynamic> productList = [];


  // Future<void> fetchData() async {
  //   final response = await http
  //       .get(Uri.parse('http://192.168.29.43:8081/userAddToCartDetails'));
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       productList = json.decode(response.body);
  //       print(productList);
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  String baseUrl = "http://192.168.29.43:8081";
  String baseUrl1 = "http://192.168.29.43:8081/";


  dynamic productlistId;
  String Message="";

  Future<void> getCartData() async {
    int? userId = await getUserId();
    print("userId:$userId");
    final String baseUrl = Constants.ipBaseUrl+'getAllCartDetailsByUserId';

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

          print('Cart Data for User ID $userId: $responseData');

          setState(() {
            productsCart = responseData.map<ProductCart>((item) {
              return ProductCart(
                item['productVarientImageUrl'],
                item['productName'],
                item['totalAmount'],
                item['mrp'],
                item['listDescription'],
                item['addToCartId'],// Assuming 'productName' is the description
                0.0,
                item['productListId'],
                // quantitys: item['quantity'],
              );
            }).toList();
          });

          // Generate lists based on the length of productsCart
          isPressedListCart = List.generate(productsCart.length, (index) => false);
          countersCart = List.generate(productsCart.length, (index) => 1);

          // List<String> Names = [];
          // List<String> images = [];
          // List<double> price = [];
          // List<double> mrp = [];
          //
          // for (var categoryData in responseData) {
          //   productName = categoryData['productName'];
          //   print("productName: $productName");
          //   productImage = categoryData['productImagesUploadUrl'];
          //   priceValue = categoryData['totalAmount'];
          //   mrpValue = categoryData['mrp'];
          //   Names.add(productName);
          //   images.add(productImage);
          //   price.add(priceValue);
          //   mrp.add(mrpValue);
          // }
          // setState(() {
          //   productNames = Names;
          //   productImages = images;
          //   totalPrice = price;
          //   totalMrp = mrp;
          // });
          //
          // print('Product Names: $productNames');
          // print('Total Price: $totalPrice');
          // print('Total Mrp: $totalMrp');


        }
          else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
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
  double totalCartPrice=0.0;
  double totalCardAmount=0.0;


  Future<void> deleteCartItem(dynamic seletedCartId) async {

    final String otherApiUrl = Constants.ipBaseUrl+'cart/delete/$seletedCartId';
    try {
      final response = await http.delete(
        Uri.parse(otherApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print('Successfully deleted item with addToCartId: $seletedCartId');
        final responseData = json.decode(response.body);
        Message = responseData['message'];
        print("Message:$Message");
        showToast();
      } else {
        print('Failed to delete item. Status code: ${response.statusCode}');
        // Handle failure, if needed
      }
    } catch (error) {
      print('Error deleting item: $error');
      // Handle error, if needed
    }
  }

 late dynamic seletedCartId;
  late String search;
  TextEditingController searchController = TextEditingController();

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
    double totalCartPrice = getTotalCartPrice(productsCart);
    print('Total Cart Price: $totalCartPrice');
    _saveAmount(totalCartPrice);

    double shiping = 0.0;

    double TotalAmount = shiping + totalCartPrice;

    _saveTotalAmount(TotalAmount);

    saveProductsCartLength(productsCart.length);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(height: 30.0),
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
                                    visible: true,
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
                          Text("Your Order",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 40.0),
                          Container(
                              width: screenSize.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color: Color(0xffef8f21)),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Total Order Amount",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        // SizedBox(height: 15.0),
                                        // Text("Savings",
                                        //     style: TextStyle(
                                        //       fontSize: 24,
                                        //       color: Colors.white,
                                        //     )),
                                        SizedBox(height: 15.0),
                                        Text("Shipping Cost",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        SizedBox(height: 15.0),
                                        Text("Total Amount",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(width: 100.0),
                                    Column(
                                      children: [
                                        Text(":",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        SizedBox(height: 15.0),
                                        Text(":",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        SizedBox(height: 15.0),
                                        Text(":",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        // SizedBox(height: 15.0),
                                        // Text(":",
                                        //     style: TextStyle(
                                        //       fontSize: 24,
                                        //       color: Colors.white,
                                        //     )),
                                        // SizedBox(height: 15.0),
                                        // Text(":",
                                        //     style: TextStyle(
                                        //       fontSize: 24,
                                        //       color: Colors.white,
                                        //     )),
                                      ],
                                    ),
                                    SizedBox(width: 50.0),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("₹${totalCartPrice.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        // SizedBox(height: 15.0),
                                        // Text("₹240.00",
                                        //     style: TextStyle(
                                        //       fontSize: 24,
                                        //       color: Colors.white,
                                        //     )),
                                        SizedBox(height: 15.0),
                                        Text("₹${shiping.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        SizedBox(height: 15.0),
                                        Text("₹${TotalAmount.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            )),
                                        // SizedBox(height: 15.0),
                                        // Text(" ",
                                        //     style: TextStyle(
                                        //       fontSize: 24,
                                        //       color: Colors.white,
                                        //     )),
                                        // SizedBox(height: 15.0),
                                      ],
                                    ),
                                    SizedBox(width: 450.0),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Container(
                                        //   width: 434,
                                        //   height: 43,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //       BorderRadius.circular(27),
                                        //       color: Colors.white),
                                        //   child: Center(
                                        //     child: Text(
                                        //         "Estimated delivery by 19 Nov 2023",
                                        //         style: TextStyle(
                                        //           fontSize: 24,
                                        //         )),
                                        //   ),
                                        // ),

                                        // child: Obx(
                                        //       () => apiController.isLoading.value
                                        //       ? CircularProgressIndicator()
                                        //       :
                                        InkWell(
                                          onTap: () {
                                            if(productsCart.isEmpty){
                                              print("Your KK BAZAR Cart is empty");
                                              Message="Your KK BAZAR Cart is empty";
                                              showToast();
                                            }
                                            else{
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          AddressPage()));
                                            }

                                          },
                                          child: Container(
                                            width: 205,
                                            height: 49,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(27),
                                                color: Colors.white),
                                            child: Center(
                                              child: Text("Checkout",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color:
                                                      Color(0xffEF8F21))),
                                            ),
                                          ),
                                        ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(height: 60.0),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Items ",
                                      style: TextStyle(
                                        fontSize: 24,
                                      )),
                                  SizedBox(width: 5.0),
                                  Row(
                                    children: [
                                      Text("(",
                                          style: TextStyle(
                                            fontSize: 24,
                                          )),
                                      Text("${productsCart.length}",
                                          style: TextStyle(
                                            fontSize: 24,
                                          )),
                                      Text(" items)",
                                          style: TextStyle(
                                            fontSize: 24,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 790.0),
                              Text("Quantity ",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              SizedBox(width: 105.0),
                              Text("Sub-total ",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                            ],
                          ),
                          SizedBox(height: 40.0),
                          SingleChildScrollView(
                            child: Container(
                                width: screenSize.width,
                                height: 600,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27),
                                    color: Color(0x66ef8f21)),
                                child: ListView(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: productsCart.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // final productcart =
                                          // pr[index];
                                              final item = productsCart[index];
                                             totalCardAmount=  productsCart[index].prices;
                                          // final totalPricecart =
                                          //     productcart.prices *
                                          //         productcart.quantitys;
                                          // final newMRPCart = productcart.mrps *
                                          //     productcart.quantitys;
                                          //
                                          // final saved = productsCart[index]
                                          //     .totalPricecart -
                                          //     productsCart[index].newMRPCart;

                                              final saved = (productsCart[index].mrps - productsCart[index].prices) * productsCart[index].quantitys;

                                              print("quantity:${countersCart[index]}");

                                              totalCartPrice=productsCart[index].prices* productsCart[index].quantitys;
                                              print(
                                                  'Total Price of Cart: $totalCartPrice');

                                              productlistId=responseData[index]["productListId"];
                                              print("productlistId:$productlistId");

                                              _saveValuesInSharedPreferences(
                                                  totalCardAmount,totalCartPrice, productlistId, countersCart[index],index);

                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 1325,
                                              height: 168,
                                              // Adjust the height as needed
                                              child: Card(
                                                color: Color(0x66ffffff),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      27.0),
                                                ),
                                                elevation: 6,
                                                child: Stack(
                                                  children: [
                                                    Row(children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(10.0),
                                                        child: Container(
                                                          width: 550,
                                                          height: 149,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  27),
                                                              color:
                                                              Colors.white),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          27),
                                                                      color: Colors
                                                                          .white),
                                                                  child:
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        25),
                                                                    child:  Constants.ipBaseUrl+item
                                                                        .images!=null ?
                                                                    Image.network(
                                                                        width:
                                                                        100,
                                                                        height:
                                                                        160,
                                                                        Constants.ipBaseUrl+item
                                                                            .images):Text("No image available")
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                    30.0),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      20.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        item.names,
                                                                        style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                        365, // Adjust the width as needed
                                                                        height:
                                                                        36, // Adjust the height as needed
                                                                        child:
                                                                        Text(
                                                                          item
                                                                              .dess,
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            13,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                          10.0),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "₹${item.prices}",
                                                                            style:
                                                                            TextStyle(
                                                                              fontSize: 19.874778747558594,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 8.0),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets.only(top: 7.0),
                                                                            child: Text("₹${item.mrps}",
                                                                                style: TextStyle(
                                                                                  decoration: TextDecoration.lineThrough,
                                                                                  color: Color(0xff717171),
                                                                                  fontSize: 11.15052604675293,
                                                                                )),
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
                                                      SizedBox(width: 350.0),
                                                      Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Container(
                                                                width: 153,
                                                                height: 47,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        30),
                                                                    color: Colors
                                                                        .white),
                                                                child:
                                                                hideButton(
                                                                    index)),
                                                            // SizedBox(
                                                            //     height: 20.0),
                                                            // Text(
                                                            //     "Delete | Save for later",
                                                            //     style: TextStyle(
                                                            //         fontSize:
                                                            //             14,
                                                            //         fontWeight:
                                                            //             FontWeight
                                                            //                 .bold))
                                                          ]),
                                                      SizedBox(width: 100.0),
                                                      Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            SizedBox(
                                                                height: 10.0),
                                                            Text(
                                                              totalCartPrice.toStringAsFixed(2),
                                                              // "₹${productsCart[index].totalPricecart.toStringAsFixed(2)}",
                                                              style: TextStyle(
                                                                fontSize:
                                                                19.874778747558594,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 33.0),
                                                            Row(
                                                              children: [
                                                                Text("Saved:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        fontWeight:
                                                                        FontWeight.bold)),
                                                                SizedBox(
                                                                    width: 6.0),
                                                                Text(
                                                                    "₹${saved.toStringAsFixed(1)}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        fontWeight:
                                                                        FontWeight.bold)),
                                                              ],
                                                            )
                                                          ]),
                                                    ]),
                                                    Align(
                                                      alignment:
                                                      Alignment.topRight,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(10.0),
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
                                                                setState(() {
                                                                  seletedCartId=item.id;
                                                                  print("selected id:${item.id}");
                                                                  deleteCartItem(item.id);
                                                                  productsCart
                                                                      .removeAt(
                                                                      index);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.close),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(15.0),
                                    //   child: Container(
                                    //       width: 1325,
                                    //       height: 55,
                                    //       decoration: BoxDecoration(
                                    //           borderRadius:
                                    //           BorderRadius.circular(27),
                                    //           color: Color(0xb2ffffff)),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 20.0,
                                    //             vertical: 10.0),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //           MainAxisAlignment
                                    //               .spaceBetween,
                                    //           children: [
                                    //             Text("Discounts and Coupons",
                                    //                 style: TextStyle(
                                    //                   fontSize: 22,
                                    //                 )),
                                    //             Container(
                                    //               width: 205,
                                    //               height: 35,
                                    //               decoration: BoxDecoration(
                                    //                 borderRadius:
                                    //                 BorderRadius.circular(
                                    //                     37),
                                    //                 color: Color(0xffef8f21),
                                    //               ),
                                    //               child: Center(
                                    //                 child: Text(
                                    //                     "12% off Coupons",
                                    //                     style: TextStyle(
                                    //                         fontSize:
                                    //                         17.44378662109375,
                                    //                         color:
                                    //                         Colors.white)),
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //       )),
                                    // )
                                  ],
                                )),
                          ),
                          // SizedBox(height: 40.0),
                          // Text("Before you checkout",
                          //     style: TextStyle(
                          //       fontSize: 32,
                          //       fontWeight: FontWeight.bold,
                          //     )),
                          // SizedBox(height: 20.0),
                          // Container(
                          //     width: screenSize.width,
                          //     height: 60,
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(37),
                          //         color: Color(0x66ef8f21)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 40.0),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text("Mobiles",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Groceries",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Groceries",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Cosmetics",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Meat",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Artificial Jewelry",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Footwear",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //           Text("Apparels",
                          //               style: TextStyle(
                          //                 fontSize: 24,
                          //               )),
                          //         ],
                          //       ),
                          //     )),
                          // SizedBox(height: 30.0),
                          // Container(
                          //   child: GridView.builder(
                          //     shrinkWrap: true,
                          //     physics: NeverScrollableScrollPhysics(),
                          //     itemCount: products.length,
                          //     gridDelegate:
                          //     SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: _crossAxisCount(context),
                          //       crossAxisSpacing: 20.0,
                          //       mainAxisSpacing: 20.0,
                          //       mainAxisExtent: 600,
                          //     ),
                          //     itemBuilder: (context, index) {
                          //       final product = products[index];
                          //       final totalPrice =
                          //           product.price * product.quantity;
                          //       final newMRP = product.mrp * product.quantity;
                          //
                          //       return Column(
                          //         children: [
                          //           Container(
                          //             decoration: BoxDecoration(
                          //                 borderRadius:
                          //                 BorderRadius.circular(20),
                          //                 color: Colors.white),
                          //             child: Card(
                          //               elevation: 10,
                          //               child: Column(
                          //                 children: [
                          //                   SizedBox(
                          //                     height: 20.0,
                          //                   ),
                          //                   Stack(
                          //                     children: [
                          //                       ClipRRect(
                          //                         borderRadius:
                          //                         BorderRadius.circular(
                          //                             40.0),
                          //                         child: Image.asset(
                          //                           fit: BoxFit.contain,
                          //                           product.image,
                          //                           // product_list[index]
                          //                           //     ["image"]!,
                          //                           width: 227,
                          //                           height: 173,
                          //                         ),
                          //                       ),
                          //                       // Positioned(
                          //                       //   right: 100.0,
                          //                       //   top: 10.0,
                          //                       //   child: Row(
                          //                       //     mainAxisAlignment:
                          //                       //         MainAxisAlignment
                          //                       //             .center,
                          //                       //     children: [
                          //                       //       Text(
                          //                       //         "${product.price}",
                          //                       //         // "₹${totalPrice.toStringAsFixed(2)}",
                          //                       //         // product_list[index]
                          //                       //         //     ["price"]!,
                          //                       //         style: TextStyle(
                          //                       //             fontSize:
                          //                       //                 19.874778747558594,
                          //                       //             color: Colors.black,
                          //                       //             fontWeight:
                          //                       //                 FontWeight
                          //                       //                     .bold),
                          //                       //       ),
                          //                       //       SizedBox(width: 8.0),
                          //                       //       Padding(
                          //                       //         padding:
                          //                       //             const EdgeInsets
                          //                       //                 .only(top: 7.0),
                          //                       //         child: Text(
                          //                       //             "${product.mrp}",
                          //                       //             // product_list[index]
                          //                       //             //     ["mrp"]!,
                          //                       //             style: TextStyle(
                          //                       //               decoration:
                          //                       //                   TextDecoration
                          //                       //                       .lineThrough,
                          //                       //               color: Color(
                          //                       //                   0xff717171),
                          //                       //               fontSize:
                          //                       //                   11.15052604675293,
                          //                       //             )),
                          //                       //       ),
                          //                       //     ],
                          //                       //   ),
                          //                       // ),
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10.0,
                          //                   ),
                          //                   Row(
                          //                     mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                     children: [
                          //                       Text(
                          //                         "₹${product.price}",
                          //                         // "₹${totalPrice.toStringAsFixed(2)}",
                          //                         // product_list[index]
                          //                         //     ["price"]!,
                          //                         style: TextStyle(
                          //                             fontSize:
                          //                             19.874778747558594,
                          //                             color: Colors.black,
                          //                             fontWeight:
                          //                             FontWeight.bold),
                          //                       ),
                          //                       SizedBox(width: 8.0),
                          //                       Padding(
                          //                         padding:
                          //                         const EdgeInsets.only(
                          //                             top: 7.0),
                          //                         child: Text("₹${product.mrp}",
                          //                             // product_list[index]
                          //                             //     ["mrp"]!,
                          //                             style: TextStyle(
                          //                               decoration:
                          //                               TextDecoration
                          //                                   .lineThrough,
                          //                               color:
                          //                               Color(0xff717171),
                          //                               fontSize:
                          //                               11.15052604675293,
                          //                             )),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   Padding(
                          //                     padding:
                          //                     const EdgeInsets.symmetric(
                          //                         horizontal: 30.0),
                          //                     child: Container(
                          //                       width: 280.0,
                          //                       height: 150.0,
                          //                       child: Center(
                          //                         child: Text(
                          //                           product.des,
                          //                           // product_list[index]["des"]!,
                          //                           style: TextStyle(
                          //                             fontSize:
                          //                             15.822525978088379,
                          //                             fontWeight:
                          //                             FontWeight.bold,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //
                          //                   // hideButton1(index),
                          //                   SizedBox(
                          //                     height: 20.0,
                          //                   ),
                          //                   Container(
                          //                     width: 306,
                          //                     height: 88,
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                         BorderRadius.circular(10),
                          //                         border: Border.all(
                          //                             color: Color(0xffBFBFBF)),
                          //                         color: Colors.white),
                          //                     child: Center(
                          //                       child: Text("Add",
                          //                           style: TextStyle(
                          //                               fontSize: 24,
                          //                               color:
                          //                               Color(0xffEF8F21))),
                          //                     ),
                          //                   )
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   ),
                          // ),
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

  Widget hideButton(int index)  {
    return InkWell(
      // onTap: () {
      //   setState(() {
      //     isPressed = false;
      //   });
      // },
      child: Container(
        width: 153,
        height: 47,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    // _counter != 1 ? _counter-- : isPressed = false;
                    countersCart[index] != 1
                        ? countersCart[index]--
                        : isPressedListCart[index] = false;
                    decrementCounters(index);
                  });
                },
                child: Image.asset(
                  "images/minus.png",
                ),
              ), // <-- Text

              Center(
                child: Text(
                  "${countersCart[index]}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (countersCart[index] <= 4) {
                      countersCart[index]++;
                      incrementCounters(index);
                    }
                  });
                },
                child: Image.asset(
                  "images/plus.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hideButton1(int index) {
  //   return InkWell(
  //     // onTap: () {
  //     //   setState(() {
  //     //     isPressed = false;
  //     //   });
  //     // },
  //     child: Container(
  //       width: 307,
  //       height: 44,
  //       decoration: BoxDecoration(color: Color(0x2bef8f21)),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 50.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   decrementCounter(index);
  //                   // _counter != 1 ? _counter-- : isPressed = false;
  //                   counters[index] != 1
  //                       ? counters[index]--
  //                       : isPressedList[index] = false;
  //                   // cardSubTotal =
  //                   //     (product_list[index]["price"]! * counters[index])
  //                   //         .toString();
  //                 });
  //               },
  //               child: Image.asset(
  //                 "images/minus.png",
  //               ),
  //             ), // <-- Text
  //
  //             Center(
  //               child: Text(
  //                 "${counters[index]}",
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   if (counters[index] <= 4) {
  //                     counters[index]++;
  //
  //                     incrementCounter(index);
  //                     // cardSubTotal =
  //                     //     (product_list[index]["price"]! * counters[index])
  //                     //         .toString();
  //                   }
  //                 });
  //               },
  //               child: Image.asset(
  //                 "images/plus.png",
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }



  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }


  Future<void> _saveTotalAmount(double totalAmount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalAmount', totalAmount);
  }

  //
  // Future<void> _saveProductListId(int productListId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('productListId', productListId);
  // }

  Future<void> _saveAmount(double Amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('amount', Amount);
  }

  // Future<void> _saveCardQuantity(int quantity) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('quantity', quantity);
  // }

  // Future<void> _saveCardPrice(double cardprice) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble('cardprice', cardprice);
  // }

  Future<void> saveProductsCartLength(int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('productsCartLength', length);
  }


  void _saveValuesInSharedPreferences(
      double totalCardAmount,double cardprice, int productListId, int quantity,int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('cardprice_$index', cardprice);
    prefs.setInt('productListId_$index', productListId);
    prefs.setInt('quantity_$index', quantity);
    prefs.setDouble('totalCardAmount_$index', totalCardAmount);
  }
}
