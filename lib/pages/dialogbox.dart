import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:responsive/pages/Addresspage.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Cartpage.dart';
import 'Login.dart';
import 'buynow_qty page.dart';
import 'constants.dart';

class ProductDetailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Adjust dialog shape and appearance as needed
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      // Add your desired padding, constraints, or sizing for the dialog content
      // child: ProductDetail1(detailListId: 1),
    );
  }
}

class ProductDetail1 extends StatefulWidget {
   int detailListId=0 ;
  int sendingProductId=0 ;
   ProductDetail1({super.key, required this.detailListId ,required this.sendingProductId });

  @override
  State<ProductDetail1> createState() => _ProductDetail1State();
}

class _ProductDetail1State extends State<ProductDetail1> {
  bool isChecked = false;

  int currentQuantityIndex = 0;
  late List<bool> isPressedList;
  late List<int> counters;

  String baseUrl = "http://192.168.29.43:8081";
  String baseUrl1 = "http://192.168.29.43:8081/";
  String largeImageUrl='';


  List<String> categoryNames = [];
  List<String> proNames = [];
  List<String> description = [];
  List<int> catid = [];

  List<Map<String, dynamic>> responseData = [];
  List<Map<String, dynamic>> responseProductData = [];
  late int receivedId;
  double price=0.0;
   int? productListId;

  List<dynamic> ourresponseData = [];
  List<dynamic> ourresponseDatass = [];

  String? categoryName="";
  String? productName="";
  String? descriptions="";
  double? mrp;
  double? totalAmount;
  double? discountPerc;
  late List<dynamic> datas = [];
  late List<dynamic>
  datass = [];


  Future<void> getData(receivedId) async {
    final String baseUrl = 'productList/views';
    final url = Uri.parse(Constants.ipBaseUrl + '$baseUrl/$receivedId');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> decodedResponse = jsonDecode(response.body);
          setState(() {
            responseData = decodedResponse.cast<Map<String, dynamic>>();
            if (responseData.isNotEmpty) {
              // Parse the value as an integer
              productListId = responseData[0]['productListId'];

              if (productListId != null) {
                print("productListId: $productListId");

                // Call the function to save productListId to SharedPreferences
                _saveProductListId(productListId);
              } else {
                print('Invalid productListId format: ${responseData[0]['productListId']}');
              }
            }
            else {
              print('No data received for ID $receivedId');
            }
          });
        });
      } else {
        print('Failed to fetch datas for ID $receivedId. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data for ID $receivedId: $error');
    }
  }


  Future<void> getOrderDetail(receivedId) async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl + 'productList/views';

    try {
      final url = Uri.parse('$baseUrl/$receivedId');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        ourresponseData = jsonDecode(response.body);

        print('orderDetailData for User ID $userId: $ourresponseData');
        setState(() {
          if (ourresponseData.isNotEmpty) {

            for (var categoryData in ourresponseData) {
              productListIdValue = categoryData['productListId'];
              _saveProductListId(productListIdValue);
              categoryName = categoryData['categoryName'];
              productName = categoryData['productName'];
              descriptions = categoryData['description'];
              mrp = categoryData['mrp'];
              totalAmount = categoryData['totalAmount'];
              discountPerc= categoryData['discountPercentage'];
              datas=categoryData['varientImages'];
              print("yah categoryName:$categoryName");
              print("yah varientImages:$datas");


              if (productListId != null) {
                print("productListId: $productListId");

                _saveProductListId(productListId);
              } else {
                print('Invalid productListId format: ${ourresponseData[0]['productListId']}');
              }
            }


          }
          else {
            print('Failed to fetch data. Status code: ${response.statusCode}');
          }
        });
      }

    } catch (error) {
      print('Error: $error');
    }
  }


  Future<void> _saveProductListId(int? productListId) async {
    if (productListId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('productListId', productListId);
      print('saved productListId: $productListId');
    } else {
      print('productListId is null, not saving to SharedPreferences');
    }
  }

  Future<void> getDataProduct() async {
    final String baseUrl = Constants.ipBaseUrl+'product/views';
    final url = Uri.parse('$baseUrl/$receivedIdProduct');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        ourresponseDatass = jsonDecode(response.body);
        print('orderDetailData : $ourresponseDatass');
        setState(() {
          for (var categoryDatas in ourresponseDatass) {
            datass=categoryDatas["productList"];
            print("datass:$datass");
          }
        });
      }
      else {
        print('Failed to fetch data for Product ID $receivedIdProduct. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data for Product ID $receivedIdProduct: $error');
    }
  }


   int? productListIdValue;
  late dynamic productVarientImagesId;
  String Message='';
  String errorMessage='';

  void postCart(productListIdValue,productVarientImagesId) async {
    int? userId = await getUserId();

    if (userId != null) {
      final Uri url = Uri.parse(Constants.ipBaseUrl+'cartDetails/save');


      Map<String, dynamic> queryParamsMobile = {
        'userId': userId.toString(),
        'productListId': productListIdValue.toString(),
        'productVarientImagesId': productVarientImagesId.toString(),

      };

      Uri uri = url.replace(queryParameters: queryParamsMobile);

      try {
        final responseAddCart = await http.post(uri);

        if (responseAddCart.statusCode == 200) {
          print('response Addtocart: ${responseAddCart.body}');
          final responseData = json.decode(responseAddCart.body);
          Message = responseData['message'];
          showToast();

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

  final AuthService authService = AuthService();


  @override
  void initState() {
    super.initState();
    receivedIdProduct  = widget.sendingProductId;
     receivedId  = widget.detailListId;
    _fetchData();
    _fetchDataProduct();

    // if (responseData.isNotEmpty &&
    //     responseData[0]['varientImages'] != null &&
    //     responseData[0]['varientImages'].isNotEmpty &&
    //     responseData[0]['varientImages'][0]['productVarientImageUrl'] !=
    //         null) {
    //   largeImageUrl =
    //       Constants.ipBaseUrl + responseData[0]['varientImages'][0]['productVarientImageUrl'];
    // }


  }


  int? receivedIdProduct;
  Future<void> _fetchDataProduct() async {
     receivedIdProduct  = widget.sendingProductId;
    await getDataProduct();
    print('receivedId Product:$receivedIdProduct');
    print('All Product data fetched'); // This will be printed after all data is fetched
  }

  Future<void> _fetchData() async {
    int receivedId  = widget.detailListId;
    await getOrderDetail(receivedId);
    print('receivedId:$receivedId');
    print('All data fetched'); // This will be printed after all data is fetched
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

  //
  // Future<void> getData(int receivedId) async {
  //   final String baseUrl = 'http://192.168.29.106:8081/productList/views';
  //
  //   final url = Uri.parse('$baseUrl/$receivedId'); // Use receivedId directly
  //
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //
  //       print('Data for ID $receivedId: $responseData');
  //
  //       if (responseData.isNotEmpty) {
  //         for (var productData in responseData) {
  //           setState(() {
  //
  //             detailDes = responseData['description'] ?? '';
  //             detailProName = responseData['productName'] ?? '';
  //             detailCategoryName = responseData['categoryName'] ?? '';
  //             detailmrp = responseData['mrp'] ?? 0;
  //             detailprice = responseData['totalAmount'] ?? 0;
  //             DisPerc = responseData['discountPercentage'] ?? 0;
  //             Images = responseData['varientImages'] ?? [];
  //
  //
  //           });
  //         }
  //       }
  //     } else {
  //       print('Failed to fetch data for ID $receivedId. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error fetching data for ID $receivedId: $error');
  //   }
  // }

  // Future<void> getData(List<int> receivedId) async {
  //   final String baseUrl = 'http://192.168.29.106:8081/productList/views';
  //
  //   try {
  //     for (int id in receivedId) {
  //       final url = Uri.parse('$baseUrl/$id');
  //
  //       try {
  //         final response = await http.get(
  //           url,
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //           },
  //         );
  //
  //         if (response.statusCode == 200) {
  //           List<dynamic> datas1 = [];
  //           final responseData = jsonDecode(response.body);
  //
  //           print('Detail Data for ID $id: $responseData');
  //
  //           if (responseData.isNotEmpty) {
  //             for (var productData in responseData) {
  //               detailprice = productData['totalAmount']??0;
  //               DisPerc= productData['discountPercentage']??0;
  //               detailmrp= productData['mrp']??0;
  //               detailProName = productData['productName']??'';
  //               print("detailProName:$detailProName");
  //                detailDes = productData['description']??'';
  //           }
  //
  //           }
  //         }
  //         else {
  //           print('Failed to fetch data for ID $id. Status code: ${response.statusCode}');
  //         }
  //       } catch (error) {
  //         print('Error fetching data for ID $id: $error');
  //       }
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text("$categoryName",
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'RedRose',
                            fontWeight: FontWeight.bold)),
                    // Container(
                    //   width: 38.0,
                    //   height: 38.0,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Color(0xfffab442),
                    //   ),
                    //   child: Center(
                    //     child: IconButton(
                    //       icon: Icon(Icons.close),
                    //       color: Colors.white,
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //       },
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(height: 50.0),
                Expanded(
                  child: Row(
                    children: [

                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: datas.length??0,
                          itemBuilder: (BuildContext context, int index) {
                            productListIdValue=ourresponseData[0]["productListId"];
                            productVarientImagesId=datas[index]['productVarientImagesId'];
                            price=ourresponseData[0]['totalAmount'];
                              _savePrice(price);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (
                                      datas!= null &&
                                      datas.isNotEmpty &&
                                          datas[index]['productVarientImageUrl'] !=
                                          null) {
                                    largeImageUrl =
                                        Constants.ipBaseUrl+datas[index]['productVarientImageUrl'];
                                  } else {
                                    largeImageUrl = Constants.ipBaseUrl+ datas[index]['productVarientImageUrl']; // Set a default image if there's no image available
                                  }
                                });
                              },
                              child: InkWell(
                                onTap: (){
                                  setState(() {


                                    if (
                                        datas!= null &&
                                            datas.isNotEmpty &&
                                        datas[index]['productVarientImageUrl'] !=
                                            null) {
                                      largeImageUrl =
                                          Constants.ipBaseUrl+datas[index]['productVarientImageUrl'];
                                    } else {
                                      largeImageUrl = Constants.ipBaseUrl+ datas[index]['productVarientImageUrl']; // Set a default image if there's no image available
                                    }
                                  });
                                },
                                child: Column(
                                  children: <Widget>[
                                    datas[index]['productVarientImageUrl'] != null
                                        ? Image.network(
                                      Constants.ipBaseUrl+ datas[index]['productVarientImageUrl'],
                                      width: 134,
                                      height: 134,
                                    )
                                        : Text('No image available'),
                                    SizedBox(height: 40.0),
                                  ],
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                      SizedBox(width: 30.0),
                      Container(

                        width: 488,
                        height: 480,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: largeImageUrl.isNotEmpty
                            ?
                        Image.network(
                          largeImageUrl,
                          width: 468,
                          height: 480,
                          fit: BoxFit.cover,
                        ):

                        Image.network(
                          Constants.ipBaseUrl+ datas[0]['productVarientImageUrl'],
                          width: 468,
                          height: 480,
                          fit: BoxFit.cover,
                        )
                            // : Text('No image available'),
                      ),
                      SizedBox(width: 30.0),
                      Container(
                          width: 650,
                          height: 480,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("KK BAZAR",
                                //         style: TextStyle(
                                //           shadows: [
                                //             Shadow(
                                //                 color: Color(0xff717171),
                                //                 offset: Offset(0, -10))
                                //           ],
                                //           color: Colors.transparent,
                                //           decorationColor: Color(0xff717171),
                                //           decoration: TextDecoration.underline,
                                //           fontSize: 20,
                                //         )),
                                //     // Container(
                                //     //   width: 67,
                                //     //   height: 23,
                                //     //   decoration: BoxDecoration(
                                //     //       borderRadius: BorderRadius.circular(17),
                                //     //       color: Color(0x99fab442)),
                                //     //   child: Padding(
                                //     //     padding: const EdgeInsets.symmetric(
                                //     //         horizontal: 10.0),
                                //     //     child: Row(
                                //     //       mainAxisAlignment:
                                //     //       MainAxisAlignment.center,
                                //     //       children: [
                                //     //         Image.asset(
                                //     //             "images/Delivery man.png"),
                                //     //         SizedBox(width: 5.0),
                                //     //         Text("8 hrs",
                                //     //             style: TextStyle(
                                //     //               fontSize: 10.399999618530273,
                                //     //             ))
                                //     //       ],
                                //     //     ),
                                //     //   ),
                                //     // )
                                //   ],
                                // ),
                                // SizedBox(height: 10.0),
                                Container(
                                  width: 474.0,
                                  height: 30.0,
                                  child: Text(
                                      "$productName",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),

                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     // Text(detailDes,
                                //     //     style: TextStyle(
                                //     //       fontSize: 18,
                                //     //     )),
                                //     // Row(
                                //     //   children: [
                                //     //     Text("Nagercoil",
                                //     //         style: TextStyle(
                                //     //           fontSize: 12.361445426940918,
                                //     //         )),
                                //     //     IconButton(
                                //     //         onPressed: () {},
                                //     //         icon:
                                //     //         Icon(Icons.location_on_outlined))
                                //     //   ],
                                //     // ),
                                //   ],
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                                  child: Container(
                                    width: 650,
                                    height: 100,
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.grey),
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     color: Color(0xeaffffff)),
                                    child: Card(
                                      elevation: 20.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "$descriptions",
                                            style: TextStyle(
                                              color: Color(0xff717171),
                                              fontSize: 11.757447242736816,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("MRP:",
                                        style: TextStyle(
                                            fontSize: 18, color: Color(0xff717171))),
                                    Text(
                                      "$mrp", // Convert mrp to a string with two decimal places
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff717171),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text("Price: ",
                                              style: TextStyle(
                                                fontSize: 18,
                                              )),
                                          Text( "$totalAmount",
                                              style: TextStyle(
                                                fontSize: 18,
                                              )),
                                          // Padding(
                                          //   padding:
                                          //   const EdgeInsets.only(top: 8.0),
                                          //   child: Row(
                                          //     children: [
                                          //       Text("(₹2.16 ",
                                          //           style: TextStyle(
                                          //               fontSize: 14,
                                          //               color:
                                          //               Color(0xff717171))),
                                          //       Text("/ g) ",
                                          //           style: TextStyle(
                                          //               fontSize: 14,
                                          //               color:
                                          //               Color(0xff717171))),
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(width: 5.0),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Text("You Save: ",
                                                    style: TextStyle(
                                                        fontSize: 10.297520637512207,
                                                        color: Color(0xff00B312))),
                                                Text("$discountPerc",
                                                    style: TextStyle(
                                                        fontSize: 10.297520637512207,
                                                        color: Color(0xff00B312))),
                                                Text("% OFF",
                                                    style: TextStyle(
                                                        fontSize: 10.297520637512207,
                                                        color: Color(0xff00B312))),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   width: 103,
                                    //   height: 19,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(17),
                                    //       color: Color(0x99fab442)),
                                    //   child: Row(
                                    //     children: [
                                    //       SizedBox(
                                    //         width: 4.0,
                                    //       ),
                                    //       Text("Quantity",
                                    //           style: TextStyle(
                                    //             fontSize: 11,
                                    //           )),
                                    //       SizedBox(
                                    //         width: 11.0,
                                    //       ),
                                    //       hideButton1()
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Text("(inclusive of all taxes)",
                                    style: TextStyle(
                                      fontSize: 11,
                                    )),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(


                                      onTap: () async {
                                        bool isAuthenticated = await authService.isAuthenticated();
                                        if (isAuthenticated) {
                                          print("productListIdValue:$productListIdValue");
                                          print("productVarientImagesId:$productVarientImagesId");
                                          postCart(productListIdValue,productVarientImagesId);
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                                        } else {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                        }
                                      },

                                  //
                                  // onTap: ()
                                  //   {
                                  //     print("productListIdValue:$productListIdValue");
                                  //     print("productVarientImagesId:$productVarientImagesId");
                                  //     postCart(productListIdValue,productVarientImagesId);
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => CartPage(),
                                  //       ),
                                  //     );
                                  //       },


                                      child: Container(
                                          width: 232,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: Color(0xfffab442)),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/Add to basket.png",
                                                width: 14.0,
                                                height: 14.0,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 10.0),
                                              Text("Add Cart",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ),
                                    GestureDetector(
                                      // onTap: (){
                                      //   showBuyNow_QtyDialog(context);
                                      // },

                                      onTap: () async {
                                        bool isAuthenticated = await authService.isAuthenticated();
                                        if (isAuthenticated) {
                                          showBuyNow_QtyDialog(context);
                                        } else {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                        }
                                      },
                                      child: Container(
                                          width: 222,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xfffab442)),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/Heart.png",
                                                width: 14.0,
                                                height: 14.0,
                                                color: Color(0xfffab442),
                                              ),
                                              SizedBox(width: 10.0),
                                              GestureDetector(
                                                onTap: (){

                                                  showBuyNow_QtyDialog(context);
                                                },
                                                child: Center(
                                                  child: Text("Buy Now",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Color(0xfffab442))),
                                                ),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Text("${datass.length} Similar Products",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'RedRose',
                                        fontWeight: FontWeight.bold)),

                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: datass.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      var productList = datass[index];
                                      var varientImages = productList['varientImages'];

                                      if (varientImages != null && varientImages.isNotEmpty) {
                                        return GestureDetector(
                                          onTap: () {
                                            int productListId = productList['productListId'];
                                            getOrderDetail(productListId);
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  dynamic receivedId = productList['productListId'];
                                                  print("varient images list id is:$receivedId");
                                                  getOrderDetail(receivedId);
                                                  largeImageUrl= Constants.ipBaseUrl+
                                                      varientImages[0]['productVarientImageUrl'];
                                                },
                                                child: Image.network(
                                                  Constants.ipBaseUrl+
                                                      varientImages[0]['productVarientImageUrl'],
                                                  width: 100,
                                                  height: 200,
                                                ),
                                              ),
                                              SizedBox(width: 20.0),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return SizedBox(); // Return an empty SizedBox or handle the case when varientImages is empty
                                      }
                                    },
                                  ),
                                ),



                              ]))
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ));
  }

  Widget hideButton1() {
    return Container(
      width: 44,
      height: 19,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Color(0xfffab442)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (counters[currentQuantityIndex] != 1) {
                    counters[currentQuantityIndex]--;
                  } else {
                    isPressedList[currentQuantityIndex] = false;
                  }
                });
              },
              child: Image.asset(
                "images/minus.png",
                color: Colors.white,
                width: 7.0,
                height: 7.0,
              ),
            ), // <-- Text

            Center(
              child: Text(
                "${counters[currentQuantityIndex]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  if (counters[currentQuantityIndex] <= 4) {
                    counters[currentQuantityIndex]++;
                  }
                });
              },
              child: Image.asset(
                "images/plus.png",
                color: Colors.white,
                width: 7.0,
                height: 7.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hideButton(int index)  {
  //   return InkWell(
  //     // onTap: () {
  //     //   setState(() {
  //     //     isPressed = false;
  //     //   });
  //     // },
  //     child: Container(
  //       width: 153,
  //       height: 47,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(30), color: Colors.white),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   // _counter != 1 ? _counter-- : isPressed = false;
  //                   countersCart[index] != 1
  //                       ? countersCart[index]--
  //                       : isPressedListCart[index] = false;
  //                   decrementCounters(index);
  //                 });
  //               },
  //               child: Image.asset(
  //                 "images/minus.png",
  //               ),
  //             ), // <-- Text
  //
  //             Center(
  //               child: Text(
  //                 "${countersCart[index]}",
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   if (countersCart[index] <= 4) {
  //                     countersCart[index]++;
  //                     incrementCounters(index);
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
}


Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

Future<void> _savePrice(double price) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('pricevalue', price);
  print('saved  pricevalue: $price');
}

// Future<void> _saveProductListId(int productListId) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setInt('productListId', productListId);
//   print('saved  productListId: $productListId');
// }


// To show the dialog
showProductDetailDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ProductDetailDialog();
    },
  );
}
