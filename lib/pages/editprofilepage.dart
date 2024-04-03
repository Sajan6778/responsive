import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/payment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class editProfileDialog extends StatelessWidget {
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
      child: EditProfile(),
    );
  }
}

List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];

class EditProfile extends StatefulWidget {


  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController genderController = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showToastMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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



  late List<dynamic> responseData=[];
  String user_name='';
  String gender='';
  String email_id='';
  String date_of_birth='';
  var number1;
  var number2;

  Future<void> getUserData() async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl+'userDetailsById';

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
        }

        for (var userData in responseData) {
          setState(() {
            user_name = userData['userName']??"";
            print("userName: $user_name");
            _namecontroller.text=user_name;

            email_id = userData['emailId']??"";
            print("email_id: $email_id");
            _emailController.text=email_id;
            print("email_id: $_emailController");
            gender = userData['gender']??"";
            print("gender: $gender");
            genderController.text=gender;
            date_of_birth = userData['dateOfBirth']??"";
            print("date_of_birth: $date_of_birth");
            dateOfBirth.text=date_of_birth;
            number1 = userData['mobileNumber'].toString()??"";
            print("number1: $number1");
            number1Controller.text=number1;
            number2 = userData['alternateMobileNumber'].toString()??"";
            print("number2: $number2");
            number2Controller.text=number2;
          });
        }

      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  Future<void> sendEditProfile(Map<String, dynamic> data) async {
    int? userId = await getUserId();
    var url = Uri.parse(Constants.ipBaseUrl+'user/edit/$userId');

    try {
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Data posted successfully');
        getUserData();
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

  @override
  void initState() {
    super.initState();
    getUserData();
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
                height: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 60.0),
                      child: Row(
                        children: <Widget>[
                          Text("Profile ",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(width: 950.0),
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
                        height: 530,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0x2bef8f21)),
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("User Name",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      )),

                                  // Text("Email Address",
                                  //     style: TextStyle(
                                  //       fontSize: 24,
                                  //       color: Colors.black,
                                  //     )),
                                  Text("Phone Number 1",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      )),
                                  Text("Phone Number 2",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      )),
                                  Text("Date of Birth",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      )),
                                  Text("Gender",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      )),
                                  // Text("Password",
                                  //     style: TextStyle(
                                  //       fontSize: 24,
                                  //       color: Colors.black,
                                  //     )),
                                ],
                              ),
                              SizedBox(width: 170.0),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(":",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      )),
                                  // Text(":",
                                  //     style: TextStyle(
                                  //       fontSize: 24,
                                  //       color: Colors.black,
                                  //     )),
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
                                  // Text(":",
                                  //     style: TextStyle(
                                  //       fontSize: 24,
                                  //       color: Colors.black,
                                  //     )),
                                ],
                              ),
                              SizedBox(width: 80.0),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                               // child:Text(user_name),
                                    child: TextFormField(
                                      controller: _namecontroller,
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
                                  SizedBox(height: 38),
                                  // Container(
                                  //   width: 500.0,
                                  //   height: 55.0,
                                  //   child: TextFormField(
                                  //
                                  //       controller: _emailController,
                                  //       decoration: InputDecoration(
                                  //         border: OutlineInputBorder(
                                  //           borderSide: BorderSide.none,
                                  //         ),
                                  //       ),
                                  //       style: TextStyle(
                                  //         fontSize: 24,
                                  //         color: Colors.black,
                                  //       )),
                                  // ),

                                  SizedBox(height: 40),
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                                    child: TextFormField(
                                      controller: number1Controller,
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
                                  SizedBox(height: 80),
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                                    child: TextFormField(
                                      controller: number2Controller,
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
                                  SizedBox(height: 75),
                                  Container(
                                    width: 200.0,
                                    height: 20.0,
                                    child: TextFormField(
                                      controller: dateOfBirth,
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
                                  SizedBox(height: 85),
                                      Container(
                                        width: 200.0,
                                        height: 20.0,
                                        child: TextFormField(
                                          controller: genderController,
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
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              var jsonData = {
                                "userName": _namecontroller.text,
                                // "email_id": _emailController.text,
                                "mobileNumber": number1Controller.text,
                                "alternateMobileNumber": number2Controller.text,
                                "gender": genderController.text,
                                "dateOfBirth": dateOfBirth.text,
                              };
                              sendEditProfile(jsonData);
                              print("edit request");
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
showEditProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return editProfileDialog();
    },
  );
}
Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}
