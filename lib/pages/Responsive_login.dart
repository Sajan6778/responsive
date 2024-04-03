import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive/pages/regiter%20page.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../responsive.dart';
import 'package:responsive/pages/responsive.dart';

import 'Login.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'package:http/http.dart' as http;

class ResponsiveLogin extends StatefulWidget {
  const ResponsiveLogin({super.key});

  @override
  State<ResponsiveLogin> createState() => _ResponsiveLoginState();
}

class _ResponsiveLoginState extends State<ResponsiveLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  late bool _isobscured1 = true;
  bool isChecked = false;
  bool _isLoading = false;
  String errorMessage='';
  final AuthService authService = AuthService();


  Future<void> postData(String email, String password) async {
    final url = Uri.parse( Constants.ipBaseUrl+'user/login');

    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final responseData = jsonDecode(response.body);
      print('Output for login: $responseData');

      if (response.statusCode == 200) {
        final token = responseData['token'];
        final userId = responseData['id'];

        if (userId != null && (userId is int || userId is String)) {
          final parsedUserId = (userId is int) ? userId : int.tryParse(userId);

          if (parsedUserId != null) {
            print('Token: $token');
            print('userId: $parsedUserId');

            // Save userId in SharedPreferences
            await saveUserId(parsedUserId);

            await authService.login();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          }
          else {
            print('Invalid or missing user ID in the response');
          }
        } else {
          print('Invalid or missing user ID in the response');
        }
      }
      else if (response.statusCode == 401) {
        // Email already exists or unauthorized
        final responseData = json.decode(response.body);
        errorMessage = responseData[
        'Message']; // Assuming error message is in 'message' key

        showToast();
      }
      else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController numberController = TextEditingController();
  //
  // String? validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter an email address.";
  //   }
  //   RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   if (!emailRegExp.hasMatch(value)) {
  //     return "Please enter a valid email address.";
  //   }
  //   return null;
  // }
  //
  // String? validatePhone(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter a Phone number.";
  //   }
  //
  //   if (value.length != 10) {
  //     return "Please enter a valid 10-digit Phone number.";
  //   }
  //
  //   // Check if the value contains only numeric digits
  //   if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
  //     return "Phone number should contain only numbers.";
  //   }
  //
  //   return null;
  // }
  //
  // Text errorMessage = Text('');
  // void submitForm() {
  //   String email = emailController.text;
  //   String number = numberController.text;
  //
  //   if (email.isNotEmpty && number.isNotEmpty) {
  //     // Both email and phone fields are entered
  //     setState(() {
  //       errorMessage = Text(
  //         'Only enter either email or phone, not both',
  //         style: TextStyle(color: Colors.red),
  //       );
  //     });
  //   } else {
  //     String? emailError = validateEmail(email);
  //     String? phoneError = validatePhone(number);
  //
  //     if (emailError == null || phoneError == null) {
  //       // Either email or phone validations passed
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => PasswordPage(email: emailController.text)),
  //       );
  //     } else {
  //       // Both email and phone validations failed
  //       // You can display error messages or handle it as needed
  //       setState(() {
  //         errorMessage = Text(
  //           'Email Error: $emailError\nPhone Error: $phoneError',
  //           style: TextStyle(color: Colors.red),
  //         );
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (Responsive.isLargeScreen(context)) {
      return Login();
    } else if (Responsive.isMediumScreen1(context)) {
      return Login();
    } else if (Responsive.isMediumScreen(context)) {
      return Login();
    } else if (Responsive.isSmallScreen(context)) {
      return Scaffold(
          body: SafeArea(
        child: Container(
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 50.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "images/image 46.png",
                          width: 47,
                          height: 47,
                        ),
                        // SizedBox(
                        //   width: 1120.0,
                        // ),

                        Container(
                          child: Row(
                            children: [
                              Text("Home",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                              SizedBox(
                                width: 10.0,
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                  // tooltip: 'Show Snackbar',
                                  onPressed: () {}),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Login",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              // Static container that remains at the top

              // Scrollable container
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Text("Login on ",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  Text("KK BAZAR",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 20.0, top: 10.0),
                            //   child: Divider(
                            //     height: 10,
                            //     thickness: 2,
                            //     endIndent: 150,
                            //     color: Color(0xffEF8F21),
                            //   ),
                            // ),
                            // FractionallySizedBox(
                            //   widthFactor: 0.93, // Adjust this value as needed
                            //   child: Divider(
                            //     height: 10,
                            //     thickness: 2,
                            //     endIndent: MediaQuery.of(context).size.width *
                            //         0.8, // Adjust this value as needed
                            //     color: Color(0xffEF8F21),
                            //   ),
                            // ),
                            SizedBox(height: 20.0),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 403,
                                  height: 415,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            width: 1, color: Color(0xffEF8F21))),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 42.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Email",
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors.black)),
                                          SizedBox(height: 20.0),
                                          Container(
                                            width: 417,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: Color(0x2bef8f21)),
                                            child: TextFormField(
                                              controller: emailController,

                                              validator: (value) {
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
                                                hintText: 'Email',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ), // controller: emailController,
                                              // validator: validateEmail,
                                              // contentPadding:
                                              //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Text("Password",
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors.black)),
                                          SizedBox(height: 20.0),
                                          Container(
                                            width: 417,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: Color(0x2bef8f21)),
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



                                          SizedBox(height: 39.0),
                                          Center(
                                            // child: Obx(
                                            //   () => apiController.isLoading.value
                                            //       ? CircularProgressIndicator()
                                            child: Container(
                                              width: 315,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                      0xffEF8F21), // Background color
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState!.validate()) {
                                                    setState(() {
                                                      _isLoading = true; // Set loading state to true
                                                    });
                                                    String email = emailController.text.trim();
                                                    String password = _pass.text.trim();
                                                    postData(email, password);
                                                    print("processing data");

                                                    setState(() {
                                                      _isLoading = false; // Set loading state to false
                                                    });
                                                  }
                                                },
                                                child: Text("SUBMIT",
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            // ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Loading indicator
                                if (_isLoading)
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xffEF8F21)),
                                  ),
                              ],
                            ),
                            SizedBox(height: 40.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // print('Text Clicked');
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Are you new to KK BAZAR?',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()));
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        ' create account',
                                        style: TextStyle(
                                          fontSize: 20.0,
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
                            // Column(
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
                            //                             BorderRadius.circular(
                            //                                 10),
                            //                         color: Colors.white)),
                            //               ),
                            //               Positioned(
                            //                   left: 22.0,
                            //                   top: 15.0,
                            //                   child: Image.asset(
                            //                       'images/Google.png')),
                            //             ],
                            //           ),
                            //           SizedBox(
                            //             width: 20.0,
                            //           ),
                            //           Text("Continue with Google",
                            //               style: TextStyle(
                            //                 fontSize: 19,
                            //               ))
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 20.0,
                            //     ),
                            //     // Image.asset(
                            //     //   "images/Line 6.png",
                            //     //   color: Colors.black,
                            //     // ),
                            //     SizedBox(
                            //       height: 20.0,
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
                            //                             BorderRadius.circular(
                            //                                 10),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    } else {
      return Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: 50.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "images/image 46.png",
                              width: 47,
                              height: 47,
                            ),
                            // SizedBox(
                            //   width: 1120.0,
                            // ),

                            Container(
                              child: Row(
                                children: [
                                  Text("Home",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                      // tooltip: 'Show Snackbar',
                                      onPressed: () {}),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text("Login",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  // Static container that remains at the top

                  // Scrollable container
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 30.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Login on ",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                      Text("KK BAZAR",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(left: 20.0, top: 10.0),
                                //   child: Divider(
                                //     height: 10,
                                //     thickness: 2,
                                //     endIndent: 150,
                                //     color: Color(0xffEF8F21),
                                //   ),
                                // ),
                                // FractionallySizedBox(
                                //   widthFactor: 0.93, // Adjust this value as needed
                                //   child: Divider(
                                //     height: 10,
                                //     thickness: 2,
                                //     endIndent: MediaQuery.of(context).size.width *
                                //         0.8, // Adjust this value as needed
                                //     color: Color(0xffEF8F21),
                                //   ),
                                // ),
                                SizedBox(height: 20.0),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 403,
                                      height: 415,
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(
                                                width: 1, color: Color(0xffEF8F21))),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0, vertical: 42.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Email",
                                                  style: TextStyle(
                                                      fontSize: 20, color: Colors.black)),
                                              SizedBox(height: 20.0),
                                              Container(
                                                width: 417,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(4),
                                                    color: Color(0x2bef8f21)),
                                                child: TextFormField(
                                                  controller: emailController,

                                                  validator: (value) {
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
                                                    hintText: 'Email',
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                    ),
                                                  ), // controller: emailController,
                                                  // validator: validateEmail,
                                                  // contentPadding:
                                                  //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                                ),
                                              ),
                                              SizedBox(height: 20.0),
                                              Text("Password",
                                                  style: TextStyle(
                                                      fontSize: 20, color: Colors.black)),
                                              SizedBox(height: 20.0),
                                              Container(
                                                width: 417,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(4),
                                                    color: Color(0x2bef8f21)),
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



                                              SizedBox(height: 39.0),
                                              Center(
                                                // child: Obx(
                                                //   () => apiController.isLoading.value
                                                //       ? CircularProgressIndicator()
                                                child: Container(
                                                  width: 315,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color(
                                                          0xffEF8F21), // Background color
                                                    ),
                                                    onPressed: () {
                                                      if (_formKey.currentState!.validate()) {
                                                        setState(() {
                                                          _isLoading = true; // Set loading state to true
                                                        });
                                                        String email = emailController.text.trim();
                                                        String password = _pass.text.trim();
                                                        postData(email, password);
                                                        print("processing data");

                                                        setState(() {
                                                          _isLoading = false; // Set loading state to false
                                                        });
                                                      }
                                                    },
                                                    child: Text("SUBMIT",
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white)),
                                                  ),
                                                ),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Loading indicator
                                    if (_isLoading)
                                      CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xffEF8F21)),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 40.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          // print('Text Clicked');
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Are you new to KK BAZAR?',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterPage()));
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            ' create account',
                                            style: TextStyle(
                                              fontSize: 20.0,
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
                                // Column(
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
                                //                             BorderRadius.circular(
                                //                                 10),
                                //                         color: Colors.white)),
                                //               ),
                                //               Positioned(
                                //                   left: 22.0,
                                //                   top: 15.0,
                                //                   child: Image.asset(
                                //                       'images/Google.png')),
                                //             ],
                                //           ),
                                //           SizedBox(
                                //             width: 20.0,
                                //           ),
                                //           Text("Continue with Google",
                                //               style: TextStyle(
                                //                 fontSize: 19,
                                //               ))
                                //         ],
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 20.0,
                                //     ),
                                //     // Image.asset(
                                //     //   "images/Line 6.png",
                                //     //   color: Colors.black,
                                //     // ),
                                //     SizedBox(
                                //       height: 20.0,
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
                                //                             BorderRadius.circular(
                                //                                 10),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
  }
  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
    print('saved login userId: $userId');
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      webBgColor: '#3D3B40',
      timeInSecForIosWeb: 3,
      // backgroundColor: Color(0x2bef8f21),
      textColor: Colors.white,
      fontSize: 20.0,

    );
  }
}
