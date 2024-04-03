import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'package:http/http.dart' as http;

class editAddressDialog extends StatelessWidget {
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
      child: EditAddress(),
    );
  }
}

List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];

class EditAddress extends StatefulWidget {
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
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
  int? userId;



  @override
  void initState() {
    super.initState();
    isPressedList = List.generate(fish_list.length, (index) => false);
    counters = List.generate(fish_list.length, (index) => 1);
    getUserId();
    getUserAddress();
  }

  late List<dynamic> responseAddress=[];
  List<String> userStAdd= [];
  List<String> userCity= [];
  List<String> userState= [];
  List<String> userCountry= [];
  List<dynamic> userPostCode= [];
  List<dynamic> userAddressId= [];
  List<dynamic> myuserId= [];
 dynamic selectedAddressId;
 dynamic selected_myuserId;




  Future<void> getUserAddress() async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl+'userWithAddress';

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
          setState(() {
            responseAddress = jsonDecode(response.body);
            print('Address for User ID $userId: $responseAddress');


            if (responseAddress.isNotEmpty) {
              List<String> streetAddressValue = [];
              List<String> cityValue = [];
              List<String> stateValue = [];
              List<String> countryValue = [];
              List<dynamic> postalCodeValue = [];
              List<dynamic> AddressIdValue = [];
              List<dynamic> userIdValue = [];

              for (var Address in responseAddress) {
                String streetAddress = Address['streetAddress']?? '';
                String city = Address['city']?? '';
                String state = Address['state']?? '';
                String country = Address['country']?? '';
                var postalCode = Address['postalCode'].toString()?? '';
                print("postalCode:$postalCode");
                final AddressId = Address['userAddressId'];
                print("AddressId:$AddressId");

                final userId = Address['userId'];
                print("userId:$userId");


                streetAddressValue.add(streetAddress);
                cityValue.add(city);
                stateValue.add(state);
                countryValue.add(country);
                postalCodeValue.add(postalCode);
                AddressIdValue.add(AddressId);
                userIdValue.add(userId);
              }
              setState(() {
                userStAdd = streetAddressValue;
                print("userStAdd: $userStAdd");
                streetAdd.text=userStAdd.isNotEmpty ? userStAdd[0] : "";

                userCity = cityValue;
                print("userCity: $userCity");
                city.text=userCity.isNotEmpty ? userCity[0] : "";

                userState = stateValue;
                print("userState: $userState");
                state.text=userState.isNotEmpty ? userState[0] : "";

                userCountry = countryValue;
                print("userCountry: $userCountry");
                country.text=userCountry.isNotEmpty ? userCountry[0] : "";

                userPostCode = postalCodeValue;
                print("userPostCode: $userPostCode");
                postCode.text=userPostCode.isNotEmpty ? userPostCode[0] : "";

                userAddressId=AddressIdValue;
                print("userAddressId: $userAddressId");
                selectedAddressId=userAddressId.isNotEmpty ? userAddressId[0] : "";
                print("selectedAddressId:$selectedAddressId");


                myuserId=userIdValue;
                print("myuserId: $myuserId");
                selected_myuserId=myuserId.isNotEmpty ? myuserId[0] : "";
                print("selected_myuserId:$selected_myuserId");

              });

            }
          });
        }

      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }



  TextEditingController streetAdd = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController country = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showToastMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
        getUserAddress();
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
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                width: 1200,
                height: 750,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 60.0),
                      child: Row(
                        children: [
                          Text(
                              "Address (Shipping and Billing) ",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(width: 650.0),
                          Container(
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
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        width: screenSize.width,
                        height: 460,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0x2bef8f21)),
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:30.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(

                                      height: 150.0,
                                      child: Text("Street Address",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Text("City",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                    Text("State/Province",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                    Text("Zip/Postal Code",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                    Text("Country",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(width: 160.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(

                                      height: 150,
                                      child: Text(":",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Text(":",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                    Text(":",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                    Text(":",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                    Text(":",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(width: 80.0),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0),
                                  Container(
                                    width: 500.0,
                                    height: 150,
                                    child: TextFormField(
                                      controller: streetAdd,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      ),
                                      maxLines: 5,),

                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                                    child: TextFormField(
                                      controller: city,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                  ),
                                  SizedBox(height: 25.0),
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                                    child: TextFormField(
                                      controller: state,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                  ),
                                  SizedBox(height: 25.0),
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                                    child: TextFormField(
                                      controller: postCode,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        )),
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 20.0,
                                        child: TextFormField(
                                          controller: country,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
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
                              int? addressId = await getAddressId();
                              print("addressId:$addressId");
                              var jsonData = {
                                "streetAddress": streetAdd.text,
                                "city": city.text,
                                "state": state.text,
                                "country": country.text,
                                "postalCode": postCode.text,
                                "userAddressId": selectedAddressId,
                                "userId": userId,

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
            ),
          ),
        ));
  }
}

// To show the dialog
showEditAddressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return editAddressDialog();
    },
  );
}



Future<int?> getAddressId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('AddressId');
}
