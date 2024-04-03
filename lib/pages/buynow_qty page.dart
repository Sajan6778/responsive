import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/Addresspage.dart';
import 'package:responsive/pages/payment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Addressmanager.dart';
import 'addresstype.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class BuyNow_QtysDialog extends StatelessWidget {

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
      width: 1000,
      height: 370,
      // Add your desired padding, constraints, or sizing for the dialog content
      child: BuyNowQty(),
    );
  }
}


class BuyNowQty extends StatefulWidget {




  @override
  State<BuyNowQty> createState() => _NewAddressState();
}

class _NewAddressState extends State<BuyNowQty> {

  @override
  void initState() {
    super.initState();
    isPressedList = List.generate(5, (index) => false);
    counters = List.generate(5, (index) => 1);
    initializeData();
    getProductListId();

  }

  int? userId;
  dynamic productlistId;
  late List<bool> isPressedList;
  late List<int> counters;
  int currentQuantityIndex = 0;


  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loadedUserId = prefs.getInt('userId');
    setState(() {
      userId = loadedUserId;
    });

    return prefs.getInt('userId');
  }


  Future<int?> getProductListId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? productListIdValue = prefs.getInt('productListId');
    setState(() {
      productlistId = productListIdValue;
      print("buynow_productlistId:$productlistId");
    });

    return prefs.getInt('userId');
  }

  void initializeData() {
    Future.delayed(Duration.zero, () async {
      await getcardPrice();
      updateTotalPrice();
    });
  }

  dynamic pricevalue;
  Future<double?> getcardPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? price= prefs.getDouble('pricevalue');
    setState(() {
      pricevalue = price;
      print("pricevalue:$pricevalue");
    });
  }

  dynamic totalPrice=0.0;

  Future<void> _saveTotalAmount(totalPrice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalAmount', totalPrice);
  }

  Future<void> saveProductsCartLength(int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('productsCartLength', length);
  }

  Future<void> _saveAmount(totalPrice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('amount', totalPrice);
  }


  void _saveValuesInSharedPreferences(
      double totalCardAmount,double cardprice, int productListId, int quantity,int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('cardprice_$index', cardprice);
    print("cardprice_$index,$cardprice");
    prefs.setInt('productListId_$index', productListId);
    print("productListId_$index,$productListId");
    prefs.setInt('quantity_$index', quantity);
    print("quantity_$index,$quantity");
    prefs.setDouble('totalCardAmount_$index', totalCardAmount);
    print("totalCardAmount_$index,$totalCardAmount");
  }



  void incrementCounters() {
    setState(() {
      if (counters[currentQuantityIndex] < 5) {
        counters[currentQuantityIndex]++;
        updateTotalPrice();
      }
    });
  }

  void decrementCounters() {
    setState(() {
      if (counters[currentQuantityIndex] > 1) {
        counters[currentQuantityIndex]--;
        updateTotalPrice();
      }
    });
  }

  void updateTotalPrice() {
    setState(() {

      totalPrice = pricevalue != null ? pricevalue! * counters[currentQuantityIndex] : null;
    });
  }


  Widget hideButton1() {
    return Container(
      width: 44,
      height: 19,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Color(0xfffab442)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (counters[currentQuantityIndex] != 1) {
                    decrementCounters();
                  }
                });
              },
              child: Image.asset(
                "images/minus.png",
                color: Colors.white,

              ),
            ), // <-- Text

            Center(
              child: Text(
                "${counters[currentQuantityIndex]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  if (counters[currentQuantityIndex] <5) {
                    incrementCounters();
                  }

                });
              },
              child: Image.asset(
                "images/plus.png",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        SingleChildScrollView(
            child: Center(
              child: Container(
                width: 1000,
                height: 370,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price Details",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 38.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xfffab442),
                              ),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Quantity",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              SizedBox(height: 20.0),
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
                                  hideButton1(),
                          ),

                      ],),
                          Column(
                            children: [
                              Text("Total Price",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              SizedBox(height: 20.0),
                              Text("₹${totalPrice.toString()}",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),

                            ],)
                    ],
                  ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: (){
                          _saveTotalAmount(totalPrice);
                          // saveProductsCartLength(counters[currentQuantityIndex]);
                          _saveValuesInSharedPreferences(
                              pricevalue,totalPrice, productlistId, counters[currentQuantityIndex],0);
                           saveProductsCartLength(1);
                          _saveAmount(totalPrice);
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddressPage()),
                          );

                        },
                        child: Center(
                          child: Container(
                            width: 238,
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15.608919143676758),
                                color: Color(0xffef8f21)),
                            child: Center(
                              child: Text("Continue",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                                ]),
                ),
            ),
          ),
        ));
  }
}




showBuyNow_QtyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BuyNow_QtysDialog();
    },
  );
}

