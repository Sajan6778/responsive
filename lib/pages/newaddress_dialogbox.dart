import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/payment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Addressmanager.dart';
import 'addresstype.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class newAddressDialog extends StatelessWidget {

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
      width: 1300,
      height: 1100,
      // Add your desired padding, constraints, or sizing for the dialog content
      child: NewAddress(),
    );
  }
}


List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];

class NewAddress extends StatefulWidget {


  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {

  final AddressManager addressManager = AddressManager();
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;


  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }


  void showToastMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  int currentQuantityIndex = 0;
  late List<bool> isPressedList;
  late List<int> counters;
  var fish_list = [
    {
      "image": "images/image 13 (1).png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 1568",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 14 (1).png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 15.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹ 2000",
      "des":
          "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
    },
    {
      "image": "images/image 16.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 1000",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/image 17.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹506",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/image 18.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 765",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/image 13 (1).png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 1568",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 14 (1).png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 15.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹ 2000",
      "des":
          "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
    },
    {
      "image": "images/image 16.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 1000",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/image 17.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹506",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/image 18.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 765",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
  ];

  @override
  void initState() {
    super.initState();
    _initData();

  }

  Future<void> _initData() async {
     addressManager.updateAddresses();
     getUserId();
    retrieveValuesFromSharedPreferences();
  }


  void retrieveValuesFromSharedPreferences() async{
    SharedPreferences prefs =await SharedPreferences.getInstance() ;



    setState(() {

      // Retrieve streetAddressValue
      userStAdd = prefs.getStringList('userStAdd');
      streetAdd.text= userStAdd?.isNotEmpty == true ? userStAdd![0] :"";

      // Retrieve cityValue
      userCity = prefs.getStringList('userCity');
      city.text= userCity?.isNotEmpty == true ? userCity![0] :"";

      // Retrieve stateValue
      userState = prefs.getStringList('userState');
      state.text= userState?.isNotEmpty == true ? userState![0] :"";

      // Retrieve countryValue
      userCountry = prefs.getStringList('userCountry');
      country.text= userCountry?.isNotEmpty == true ? userCountry![0] :"";


      // Retrieve countryValue
      userAddType = prefs.getStringList('userAddType');
      selectedAddType= userAddType?.isNotEmpty == true ? userAddType![0] :"";

      // Retrieve postalCodeValue
      userPostCode = prefs.getStringList('userPostCode');
      postCode.text= userPostCode?.isNotEmpty == true ? userPostCode![0] :"";

      // Retrieve addressIdValue
      userAddressId = prefs.getStringList('userAddressId');
      selectedAddressId=userAddressId?.isNotEmpty == true ? userAddressId![0]:"";

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

  Future<void> sendEditAddress(Map<String, dynamic> data) async {
    int? userId = await getUserId();
    var url = Uri.parse(Constants.ipBaseUrl+'address/save');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Data posted successfully');

        try {
          await addressManager.updateAddresses();
          retrieveValuesFromSharedPreferences();
        } catch (error) {
          print('Error updating addresses: $error');
        }
        print(response.statusCode);
      }
      else if (response.statusCode == 401) {
        // Email already exists or unauthorized
        final responseData = json.decode(response.body);
        final errorMessage = responseData[
        'Message']; // Assuming error message is in 'message' key

        // Show the error message to the user using a toast or dialog
        showToastMessage(errorMessage);
      }
      else {
        // Request failed with an error code
        print('Failed to post data. Error code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occurred during the process
      print('Error while posting data: $error');
    }
  }




  List<String>? userStAdd = [];
  List<String>? userCity = [];
  List<String>? userState = [];
  List<String>? userCountry = [];
  List<String>? userAddType = [];
  List<String>? userPostCode = [];
  List<String>? userAddressId = [];
  dynamic selectedAddressId;
  dynamic selected_myuserId;
  String selectedAddType='';


  TextEditingController streetAdd = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController country = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? userId;

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loadedUserId = prefs.getInt('userId');
    setState(() {
      userId = loadedUserId;
    });

    return prefs.getInt('userId');
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 1200,
                height: 800,
                child: Column(
                  children: [
                    SizedBox(height: 50.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("Delivery Address",
                    //         style: TextStyle(
                    //             fontSize: 24, fontWeight: FontWeight.bold)),
                    //     // InkWell(
                    //     //   onTap: () {
                    //     //     showNewAddressDialog(context);
                    //     //   },
                    //     //   child: Container(
                    //     //     child: Row(
                    //     //       children: [
                    //     //         Text("New Address",
                    //     //             style: TextStyle(
                    //     //               fontSize: 24,
                    //     //             )),
                    //     //         IconButton(
                    //     //             onPressed: () {},
                    //     //             icon: Icon(Icons.add_circle)),
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     // )
                    //   ],
                    // ),

                    // Container(
                    //   width: 1300,
                    //   height: 43,
                    //   decoration: BoxDecoration(color: Color(0x19ef8f21)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 50.0, vertical: 6.0),
                    //     child: Text("Contact Details",
                    //         style: TextStyle(
                    //           fontSize: 24,
                    //           fontWeight: FontWeight.bold,
                    //         )),
                    //   ),
                    // ),
                    // Container(
                    //   width: screenSize.width,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 50.0, vertical: 50.0),
                    //     child: Row(
                    //       children: [
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text("Password",
                    //                 style: TextStyle(
                    //                     fontSize: 24, color: Colors.black)),
                    //             SizedBox(height: 20.0),
                    //             Container(
                    //               width: 356,
                    //               height: 50,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   color: Color(0x2bef8f21)),
                    //               child: TextFormField(
                    //                 decoration: InputDecoration(
                    //                   hintText: 'xxxxxxxx',
                    //                   hintStyle: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   border: OutlineInputBorder(
                    //                     borderSide: BorderSide.none,
                    //                   ),
                    //                 ), // controller: emailController,
                    //                 autovalidateMode:
                    //                     AutovalidateMode.onUserInteraction,
                    //
                    //                 // validator: validateEmail,
                    //                 // contentPadding:
                    //                 //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(width: 300.0),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text("Phone",
                    //                 style: TextStyle(
                    //                     fontSize: 24, color: Colors.black)),
                    //             SizedBox(height: 20.0),
                    //             Container(
                    //               width: 356,
                    //               height: 50,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   color: Color(0x2bef8f21)),
                    //               child: TextFormField(
                    //                 decoration: InputDecoration(
                    //                   hintText: 'xxxxxxxx',
                    //                   hintStyle: TextStyle(
                    //                     fontSize: 18,
                    //                   ),
                    //                   border: OutlineInputBorder(
                    //                     borderSide: BorderSide.none,
                    //                   ),
                    //                 ), // controller: emailController,
                    //                 autovalidateMode:
                    //                     AutovalidateMode.onUserInteraction,
                    //
                    //                 // validator: validateEmail,
                    //                 // contentPadding:
                    //                 //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),


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
                    SizedBox(height: 40.0),

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
                                          child: TextFormField(
                                            controller: postCode,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            // validator: validateEmail,
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
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
                                        Container(
                                          width: 356,
                                          height:100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            controller: streetAdd,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              maxLines: null,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            // validator: validateEmail,
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          )
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
                                          child: TextFormField(
                                            controller: city,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            // controller: emailController,

                                            // validator: validateEmail,
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
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
                                            // child: Padding(
                                            //   padding: const EdgeInsets.all(10.0),
                                            //   child: DropdownButton<String>(
                                            //     isExpanded: true,
                                            //     icon: Icon(
                                            //       Icons.arrow_drop_down_outlined,
                                            //       size: 30,
                                            //       color: Colors.black,
                                            //     ),
                                            //     value: dropdownValue,
                                            //     underline:
                                            //         Container(), // This removes the underline
                                            //     onChanged: (String? value) {
                                            //       setState(() {
                                            //         dropdownValue = value!;
                                            //       });
                                            //     },
                                            //     items: list.map((String value) {
                                            //       return DropdownMenuItem<String>(
                                            //         value: value,
                                            //         child: Text(value),
                                            //       );
                                            //     }).toList(),
                                            //   ),
                                            // )),
                                          child: TextFormField(
                                            controller: country,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            // controller: emailController,

                                            // validator: validateEmail,
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        )
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
                                          height: 50, // Adjust the height as needed
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Color(0x2bef8f21),
                                          ),
                                          child: TextFormField(
                                            controller: state,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            // maxLines: null, // Set maxLines to null to allow unlimited lines
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(width: 300.0),
                                    // Column(
                                    //   crossAxisAlignment:
                                    //   CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text("Save address as",
                                    //         style: TextStyle(
                                    //             fontSize: 24,
                                    //             color: Colors.black)),
                                    //     SizedBox(height: 20.0),
                                    //
                                    //     Row(
                                    //       children: [
                                    //         Consumer<AddressManager>(
                                    //           builder: (context, addressManager, _) {
                                    //             return Radio(
                                    //               value: AddressType.home,
                                    //               groupValue: addressManager.selectedAddressType,
                                    //               onChanged: (AddressType? value) async {
                                    //                 addressManager.selectedAddressType = AddressType.home;
                                    //
                                    //                 try {
                                    //                   await addressManager.updateAddresses();
                                    //                   retrieveValuesFromSharedPreferences();
                                    //                 } catch (error) {
                                    //                   print('Error updating addresses: $error');
                                    //                 }
                                    //               },
                                    //               activeColor: Colors.green,
                                    //             );
                                    //           },
                                    //         ),
                                    //         SizedBox(width: 10.0),
                                    //         Text(
                                    //           "Home Address",
                                    //           style: TextStyle(fontSize: 17,
                                    //               color: Colors.black),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //
                                    //     Row(
                                    //       children: [
                                    //         Consumer<AddressManager>(
                                    //           builder: (context, addressManager, _) {
                                    //             return Radio(
                                    //               value: AddressType.work,
                                    //               groupValue: addressManager.selectedAddressType,
                                    //               onChanged: (AddressType? value) async {
                                    //                 addressManager.selectedAddressType = AddressType.work;
                                    //
                                    //                 try {
                                    //                   await addressManager.updateAddresses();
                                    //                   retrieveValuesFromSharedPreferences();
                                    //                 } catch (error) {
                                    //                   print('Error updating addresses: $error');
                                    //                 }
                                    //               },
                                    //               activeColor: Colors.green,
                                    //             );
                                    //           },
                                    //         ),
                                    //         SizedBox(width: 10.0),
                                    //         Text(
                                    //           "Work Address",
                                    //           style: TextStyle(fontSize: 17,
                                    //               color: Colors.black),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //
                                    //   ],
                                    // ),
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
                                //             MaterialStateProperty.resolveWith(
                                //                 getColor),
                                //         value: isChecked,
                                //         onChanged: (bool? value) {
                                //           setState(() {
                                //             isChecked = value!;
                                //           });
                                //         },
                                //       ),
                                //     ),
                                //     // SizedBox(width: 10.0),
                                //     // Text("Make this my default address",
                                //     //     style: TextStyle(
                                //     //         fontSize: 17, color: Colors.black)),
                                //   ],
                                // ),
                                SizedBox(height: 50.0),
                                Center(
                                  child: Container(
                                    width: 226,
                                    height: 33,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        Color(0xffEF8F21), // Background color
                                      ),
                                      onPressed: () async {

                                        if (_formKey.currentState!.validate()) {
                                          dynamic addressId = selectedAddressId;
                                          print("addressId:$addressId");
                                          var jsonData = {
                                            "streetAddress": streetAdd.text,
                                            "city": city.text,
                                            "state": state.text,
                                            "country": country.text,
                                            "postalCode": postCode.text,
                                            "userAddressId": selectedAddressId,
                                            "userId": userId,
                                            "addressType": "Home",

                                          };
                                          sendEditAddress(jsonData);
                                          print("edit request:$jsonData");
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text("Submit",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}




showNewAddressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return newAddressDialog();
    },
  );
}

