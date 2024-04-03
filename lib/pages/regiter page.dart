import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive/pages/constants.dart';
import 'package:responsive/pages/privacypolicy.dart';

import 'Aboutus.dart';
import 'Login.dart';
import 'dashboardpage.dart';
import 'faqpage.dart';

class RegisterPage extends StatelessWidget {
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

class MyScrollableColumn extends StatefulWidget {
  @override
  _MyScrollableColumnState createState() => _MyScrollableColumnState();
}

class _MyScrollableColumnState extends State<MyScrollableColumn> {
  String? _apiResponse;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void showToastMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool isChecked = false;
  late bool _isobscured1 = true;
  late bool _isobscured = true;
  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter your name.";
    }
    RegExp nameRegExp = RegExp(r'^[a-z A-z]+$');
    if (!nameRegExp.hasMatch(value)) {
      return "Enter correct name.";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email address.";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email address.";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a Phone number.";
    }

    if (value.length != 10) {
      return "Please enter a valid 10-digit Phone number.";
    }

    // Check if the value contains only numeric digits
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Phone number should contain only numbers.";
    }

    return null;
  }

  String? validatePassword(String? Passvalue) {
    if (Passvalue == null || Passvalue.isEmpty) {
      return "Please enter a password.";
    }
    if (Passvalue.length < 8) {
      return "Password must be atleast 8 characters long.";
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }

    final RegExp dateRegex =
        RegExp(r'^\d{4}-\d{2}-\d{2}$'); // Date format: YYYY-MM-DD

    if (!dateRegex.hasMatch(value)) {
      return 'Please enter a valid date in the format YYYY-MM-DD';
    }

    return null;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();

  Future<void> sendPostRequest(Map<String, dynamic> data) async {
    var url = Uri.parse(Constants.ipBaseUrl+'user/save');

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
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

  // Future<void> sendPostRequest(Map<String, dynamic> data) async {
  //   var url = Uri.parse('http://192.168.29.106:8081/user/save');
  //
  //   try {
  //     var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );
  //
  //     final responseData = jsonDecode(response.body);
  //     print('Response Data: $responseData'); // Print response data
  //
  //     if (response.statusCode == 200) {
  //       print('Data posted successfully');
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => Login()),
  //       );
  //     } else if (response.statusCode == 401) {
  //       // Email already exists or unauthorized
  //       final errorMessage = responseData['Message'] ?? 'Unauthorized';
  //
  //       // Show the error message to the user using a toast or dialog
  //       showToastMessage(errorMessage);
  //     } else {
  //       // Request failed with an error code
  //       print('Failed to post data. Error code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle any errors that occurred during the process
  //     print('Error while posting data: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Other widgets in the Column
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 30.0),
                      child: Column(
                        children: [
                          Container(
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
                                // SizedBox(
                                //   width: 1120.0,
                                // ),

                                Container(
                                  child: Row(
                                    children: [
                                      Text("Home",
                                          style: TextStyle(
                                              fontSize: 24, color: Colors.black)),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      IconButton(
                                          icon:
                                              const Icon(Icons.arrow_forward_ios),
                                          // tooltip: 'Show Snackbar',
                                          onPressed: () {}),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text("Register",
                                          style: TextStyle(
                                              fontSize: 24, color: Colors.black)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 50.0, top: 40.0),
                            child: Row(
                              children: [
                                Text("Register on ",
                                    style: TextStyle(
                                      fontSize: 24,
                                    )),
                                Text("KK BAZAR",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                          //   child: Divider(
                          //     height: 10,
                          //     thickness: 2,
                          //     endIndent: 1280,
                          //     color: Color(0xffEF8F21),
                          //   ),
                          // ),
                          SizedBox(height: 50.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Text("user ID",
                                    //         style: TextStyle(
                                    //             fontSize: 24,
                                    //             color: Colors.black)),
                                    //     SizedBox(width: 100.0),
                                    //     Container(
                                    //       width: 315,
                                    //       height: 50,
                                    //       decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(4),
                                    //           color: Color(0x2bef8f21)),
                                    //       child: TextFormField(
                                    //         decoration: InputDecoration(
                                    //           border: OutlineInputBorder(
                                    //             borderSide: BorderSide.none,
                                    //           ),
                                    //         ), // controller: emailController,
                                    //         autovalidateMode: AutovalidateMode
                                    //             .onUserInteraction,
                                    //         // validator: validateEmail,
                                    //         // contentPadding:
                                    //         //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 40.0),
                                    Row(
                                      children: [
                                        Text("Email Address",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 65.0),
                                        Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            controller: emailController,
                                            validator: (value)
                                            {
                                              if (value == null || value.isEmpty) {
                                              return "Please enter an email address.";
                                             }
                                             RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                             if (!emailRegExp.hasMatch(value)) {
                                             return "Please enter a valid email address.";
                                             }
                                             return null;
                                             },
                                            decoration: InputDecoration(
                                              hintText: '@gmail.com',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),

                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(width: 164.0),
                                    //     Checkbox(
                                    //       checkColor: Color(0xffEF8F21),
                                    //       fillColor:
                                    //           MaterialStateProperty.resolveWith(
                                    //               getColor),
                                    //       value: isChecked,
                                    //       onChanged: (bool? value) {
                                    //         setState(() {
                                    //           isChecked = value!;
                                    //         });
                                    //       },
                                    //     ),
                                    //     SizedBox(width: 10.0),
                                    //     Text("Remember me",
                                    //         style: TextStyle(
                                    //             fontSize: 17,
                                    //             color: Colors.black)),
                                    //     SizedBox(width: 130.0),
                                    //     Text("Forget email?",
                                    //         style: TextStyle(
                                    //             fontSize: 17,
                                    //             color: Colors.black))
                                    //   ],
                                    // ),
                                    // SizedBox(height: 40.0),
                                    Row(
                                      children: [
                                        Text("Date of Birth",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 85.0),
                                        Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            controller: dateOfBirth,
                                            validator:(value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your date of birth';
                                              }

                                              final RegExp dateRegex =
                                              RegExp(r'^\d{4}-\d{2}-\d{2}$'); // Date format: YYYY-MM-DD

                                              if (!dateRegex.hasMatch(value)) {
                                                return 'Please enter a valid date in the format YYYY-MM-DD';
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              // suffixIcon: DropdownButton<String>(
                                              //   underline: SizedBox(),
                                              //   icon: Icon(
                                              //     Icons.arrow_drop_down_outlined,
                                              //     size: 40,
                                              //     color: Colors.black,
                                              //   ),
                                              //   items: <String>[
                                              //     'A',
                                              //     'B',
                                              //     'C',
                                              //     'D'
                                              //   ].map((String value) {
                                              //     return DropdownMenuItem<String>(
                                              //       value: value,
                                              //       child: Text(value),
                                              //     );
                                              //   }).toList(),
                                              //   onChanged: (newValue) {
                                              //     setState(() {});
                                              //   },
                                              // ),
                                              hintText: 'YYYY-MM-DD',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ), // controller: emailController,

                                            // validator: validateEmail,
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Text("Phone Number 1",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 48.0),
                                        Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            controller: number1Controller,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return "Please enter a Phone number.";
                                              }

                                              if (value.length != 10) {
                                                return "Please enter a valid 10-digit Phone number.";
                                              }

                                              // Check if the value contains only numeric digits
                                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                                return "Phone number should contain only numbers.";
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'xxxxxxxxxx',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),

                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Text("Password",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 115.0),
                                        Container(
                                            width: 350,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Color(0x2bef8f21),
                                            ),
                                          child: TextFormField(
                                            // validator: validatePassword,

                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "Please enter a password.";
                                              }
                                              if (value.length < 8) {
                                                return "Password must be atleast 8 characters long.";
                                              }
                                              return null;
                                            },
                                            obscureText: _isobscured1,
                                            controller: _pass,
                                            decoration: InputDecoration(
                                              hintText: 'Password',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              suffixIcon: IconButton(
                                                padding: EdgeInsetsDirectional.symmetric(horizontal: 12.0, vertical: 5.0),
                                                icon: _isobscured1
                                                    ? const Icon(Icons.visibility)
                                                    : const Icon(Icons.visibility_off),
                                                onPressed: () => setState(() {
                                                  _isobscured1 = !_isobscured1;
                                                }),
                                              ),
                                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                                              // contentPadding: EdgeInsets.symmetric(
                                              //   vertical: 12.0,
                                              //   horizontal: 5.0,
                                              // ),
                                            ),
                                            // style: TextStyle(fontSize: 18),
                                          ),

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 130.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("User Name",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 110.0),
                                        Container(
                                          width: 315,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return "Enter your name.";
                                              }
                                              RegExp nameRegExp = RegExp(r'^[a-z A-z]+$');
                                              if (!nameRegExp.hasMatch(value)) {
                                                return "Enter correct name.";
                                              }
                                              return null;
                                            },
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              hintText: 'your name',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Text("Gender",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 158.0),
                                        Container(
                                          width: 315,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return "Enter your Gender.";
                                              }
                                              return null;
                                            },
                                            controller: genderController,
                                            decoration: InputDecoration(
                                              hintText: 'your Gender',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Text("Phone Number 2",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 50.0),
                                        Container(
                                          width: 315,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                            controller: number2Controller,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return "Please enter a Phone number.";
                                              }

                                              if (value.length != 10) {
                                                return "Please enter a valid 10-digit Phone number.";
                                              }

                                              // Check if the value contains only numeric digits
                                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                                return "Phone number should contain only numbers.";
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'xxxxxxxxxx',
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                            ),

                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Text("Confirm Password",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black)),
                                        SizedBox(width: 22.0),
                                        Container(
                                          width: 315,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0x2bef8f21)),
                                          child: TextFormField(
                                              obscureText: _isobscured,
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                    padding: EdgeInsetsDirectional
                                                        .only(end: 12.0),
                                                    icon: _isobscured
                                                        ? const Icon(
                                                            Icons.visibility)
                                                        : const Icon(
                                                            Icons.visibility_off),
                                                    onPressed: () => setState(() {
                                                          _isobscured =
                                                              !_isobscured;
                                                        })),
                                                hintText: 'password',
                                                hintStyle: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              controller: _confirmPass,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please enter  re-password.";
                                                }
                                                if (_pass.text !=
                                                    _confirmPass.text) {
                                                  return "Password Do Not Match.";
                                                }
                                                return null;
                                              }),

                                          // controller: emailController,
                                          // validator: validateEmail,
                                          // contentPadding:
                                          //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: 30.0),
                                    // Row(
                                    //   children: [
                                    //     Text("Gender",
                                    //         style: TextStyle(
                                    //             fontSize: 24,
                                    //             color: Colors.black)),
                                    //     SizedBox(width: 160.0),
                                    //     Container(
                                    //       width: 222,
                                    //       height: 50,
                                    //       decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(4),
                                    //           color: Color(0x2bef8f21)),
                                    //       child: TextFormField(
                                    //         decoration: InputDecoration(
                                    //           suffixIcon: DropdownButton<String>(
                                    //             underline: SizedBox(),
                                    //             icon: Icon(
                                    //               Icons.arrow_drop_down_outlined,
                                    //               size: 40,
                                    //               color: Colors.black,
                                    //             ),
                                    //             items: <String>[
                                    //               'A',
                                    //               'B',
                                    //               'C',
                                    //               'D'
                                    //             ].map((String value) {
                                    //               return DropdownMenuItem<String>(
                                    //                 value: value,
                                    //                 child: Text(value),
                                    //               );
                                    //             }).toList(),
                                    //             onChanged: (newValue) {
                                    //               setState(() {});
                                    //             },
                                    //           ),
                                    //           border: OutlineInputBorder(
                                    //             borderSide: BorderSide.none,
                                    //           ),
                                    //         ), // controller: emailController,
                                    //         autovalidateMode: AutovalidateMode
                                    //             .onUserInteraction,
                                    //         // validator: validateEmail,
                                    //         // contentPadding:
                                    //         //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 50.0),
                          Center(
                            // child: Obx(
                            //       () => apiController.isLoading.value
                            //       ? CircularProgressIndicator()
                            //       :
                            child: Container(
                              width: 315,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffEF8F21), // Background color
                                ),
                                onPressed: () {

                                  if (_formKey.currentState!.validate()) {
                                    var jsonData = {
                                      "userName": nameController.text,
                                      "emailId": emailController.text,
                                      "mobileNumber": number1Controller.text,
                                      "alternateMobileNumber": number2Controller.text,
                                      "gender": genderController.text,
                                      "dateOfBirth": dateOfBirth.text,
                                      "password": _pass.text,
                                      "confirmPassword": _confirmPass.text
                                    };
                                    sendPostRequest(jsonData);
                                    print("processing data");
                                  }
                                },
                                child: Text("SUBMIT",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white)),
                              ),
                            ),
                            // ),
                          ),
                          SizedBox(height: 40.0),
                          _apiResponse != null
                              ? Text(
                                  _apiResponse!,
                                  style: TextStyle(fontSize: 18),
                                )
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    // print('Text Clicked');
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Aldready Have an account? ',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      ' Use Login ',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Color(0xFFEF8F21),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          // SizedBox(height: 40.0),
                          // Center(
                          //   child: Text("OR",
                          //       style: TextStyle(
                          //         fontSize: 24,
                          //       )),
                          // ),
                          // SizedBox(height: 40.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       width: 315,
                          //       height: 50,
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           color: Color(0xff4285f4)),
                          //       child: Row(
                          //         children: [
                          //           Stack(
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Container(
                          //                     width: 46,
                          //                     height: 38,
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                             BorderRadius.circular(10),
                          //                         color: Colors.white)),
                          //               ),
                          //               Positioned(
                          //                   left: 22.0,
                          //                   top: 15.0,
                          //                   child:
                          //                       Image.asset('images/Google.png')),
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             width: 30.0,
                          //           ),
                          //           Text("Continue with Google",
                          //               style: TextStyle(
                          //                 fontSize: 19,
                          //               ))
                          //         ],
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 20.0,
                          //     ),
                          //     Image.asset(
                          //       "images/Line 6.png",
                          //       color: Colors.black,
                          //     ),
                          //     SizedBox(
                          //       width: 20.0,
                          //     ),
                          //     Container(
                          //       width: 320,
                          //       height: 50,
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           color: Color(0xff3b5998)),
                          //       child: Row(
                          //         children: [
                          //           Stack(
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Container(
                          //                     width: 46,
                          //                     height: 38,
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                             BorderRadius.circular(10),
                          //                         color: Colors.white)),
                          //               ),
                          //               Positioned(
                          //                   left: 18.0,
                          //                   top: 12.0,
                          //                   child: Image.asset(
                          //                     'images/Facebook App Symbol.png',
                          //                     width: 25,
                          //                     height: 25,
                          //                   )),
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             width: 20.0,
                          //           ),
                          //           Text("Continue with Facebook",
                          //               style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 19,
                          //               )),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
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
              ),
            ),
          ),
          // Other widgets after the scrollable content
        ],
      ),
    );
  }
}
