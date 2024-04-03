import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/regiter%20page.dart';
import 'package:responsive/pages/responsive.dart';

// import '../responsive.dart';
import 'Login.dart';
import 'dashboardpage.dart';

class ResponsiveRegister extends StatefulWidget {
  const ResponsiveRegister({super.key});

  @override
  State<ResponsiveRegister> createState() => _ResponsiveRegisterState();
}

class _ResponsiveRegisterState extends State<ResponsiveRegister> {
  late bool _isobscured1 = true;
  bool isChecked = false;

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
      return RegisterPage();
    } else if (Responsive.isMediumScreen1(context)) {
      return RegisterPage();
    } else if (Responsive.isMediumScreen(context)) {
      return Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Container(
              color: Colors.black,
              width: screenSize.width,
              height: 120,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text("Order Tracking : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            )),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.white, Color(0xffD8D8D8)])
                              .createShader(bounds),
                          child: Text(
                              "Take advantage of our time to save event | Satisfaction guaranteed * ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              )),
                        ),
                      ],
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                              colors: [Colors.white, Color(0xffD8D8D8)])
                          .createShader(bounds),
                      child: Text("| Satisfaction guaranteed * ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text("Language",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ),
                          SizedBox(
                            width: 14.0,
                          ),
                          Container(
                              height: 30,
                              color: Colors.white,
                              child: VerticalDivider(
                                  width: 2, color: Colors.white)),
                          SizedBox(
                            width: 14.0,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              // tooltip: 'Show Snackbar',
                              onPressed: () {}),
                          SizedBox(
                            width: 14.0,
                          ),
                          Container(
                              height: 30,
                              color: Colors.white,
                              child: VerticalDivider(
                                  width: 2, color: Colors.white)),
                          SizedBox(
                            width: 14.0,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              // tooltip: 'Show Snackbar',
                              onPressed: () {}),
                          SizedBox(
                            width: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Other widgets in the Column
            Expanded(
              child: SingleChildScrollView(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 30.0),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 50.0, top: 30.0, bottom: 30.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/image 46.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                    SizedBox(
                                      width: 1040.0,
                                    ),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 50.0,
                                ),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, top: 10.0),
                                child: Divider(
                                  height: 10,
                                  thickness: 2,
                                  endIndent: 1280,
                                  color: Color(0xffEF8F21),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("user ID",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 100.0),
                                            Container(
                                              width: 315,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          children: [
                                            Text("email Address",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 20.0),
                                            Container(
                                              width: 378,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: '@gmail.com',
                                                  hintStyle: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            SizedBox(width: 164.0),
                                            Checkbox(
                                              checkColor: Color(0xffEF8F21),
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked = value!;
                                                });
                                              },
                                            ),
                                            SizedBox(width: 10.0),
                                            Text("Remember me",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black)),
                                            SizedBox(width: 130.0),
                                            Text("Forget email?",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black))
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          children: [
                                            Text("Password",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 70.0),
                                            Container(
                                              width: 378,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'password',
                                                  hintStyle: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  suffixIcon: IconButton(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(end: 12.0),
                                                      icon: _isobscured1
                                                          ? const Icon(
                                                              Icons.visibility)
                                                          : const Icon(Icons
                                                              .visibility_off),
                                                      onPressed: () =>
                                                          setState(() {
                                                            _isobscured1 =
                                                                !_isobscured1;
                                                          })),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,

                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          children: [
                                            Text("Date of Birth",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 40.0),
                                            Container(
                                              width: 287,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  suffixIcon:
                                                      DropdownButton<String>(
                                                    underline: SizedBox(),
                                                    icon: Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      size: 40,
                                                      color: Colors.black,
                                                    ),
                                                    items: <String>[
                                                      'A',
                                                      'B',
                                                      'C',
                                                      'D'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  hintText: 'DD/MM/YYYY',
                                                  hintStyle: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 200.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("user Name",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 100.0),
                                            Container(
                                              width: 315,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'your name',
                                                  hintStyle: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          children: [
                                            Text("Phone Number",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 60.0),
                                            Container(
                                              width: 315,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'xxxxxxxxxx',
                                                  hintStyle: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        SizedBox(height: 40.0),
                                        Row(
                                          children: [
                                            Text("Confirm Password",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 25.0),
                                            Container(
                                              width: 315,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'password',
                                                  hintStyle: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          children: [
                                            Text("Gender",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black)),
                                            SizedBox(width: 145.0),
                                            Container(
                                              width: 222,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color(0x2bef8f21)),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  suffixIcon:
                                                      DropdownButton<String>(
                                                    underline: SizedBox(),
                                                    icon: Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      size: 40,
                                                      color: Colors.black,
                                                    ),
                                                    items: <String>[
                                                      'A',
                                                      'B',
                                                      'C',
                                                      'D'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ), // controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                // validator: validateEmail,
                                                // contentPadding:
                                                //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                      backgroundColor:
                                          Color(0xffEF8F21), // Background color
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                      // final postData = {
                                      //   'name': nameController.text.toString(),
                                      //   'email':
                                      //   emailController.text.toString(),
                                      //   'mobile_number':
                                      //   numberController.text.toString(),
                                      //   'password': _pass.text.toString()
                                      // };
                                      // apiController.postDataToApi(
                                      //     postData, context);
                                    },
                                    child: Text("SUBMIT",
                                        style: TextStyle(
                                          fontSize: 24,
                                        )),
                                  ),
                                ),
                                // ),
                              ),
                              SizedBox(height: 40.0),
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
                              SizedBox(height: 40.0),
                              Center(
                                child: Text("OR",
                                    style: TextStyle(
                                      fontSize: 24,
                                    )),
                              ),
                              SizedBox(height: 40.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 315,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff4285f4)),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 46,
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white)),
                                            ),
                                            Positioned(
                                                left: 22.0,
                                                top: 15.0,
                                                child: Image.asset(
                                                    'images/Google.png')),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30.0,
                                        ),
                                        Text("Continue with Google",
                                            style: TextStyle(
                                              fontSize: 19,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Image.asset(
                                    "images/Line 6.png",
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    width: 320,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff3b5998)),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 46,
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white)),
                                            ),
                                            Positioned(
                                                left: 18.0,
                                                top: 12.0,
                                                child: Image.asset(
                                                  'images/Facebook App Symbol.png',
                                                  width: 25,
                                                  height: 25,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Text("Continue with Facebook",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          width: screenSize.width,
                          height: 329,
                          decoration: BoxDecoration(color: Color(0xe5ef8f21)),
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("KK BAZAR",
                                        style: TextStyle(
                                            fontSize: 30.61224365234375,
                                            color: Colors.white)),
                                    Container(
                                      width: 303.0,
                                      height: 88.0,
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
                                    Text("About us",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
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
                                    Text("Privacy Policy",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text("Term & Conditions",
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
                                    Text("Contact info",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        )),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text("About us",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
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
                                    Text("Privacy Policy",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text("Term & Conditions",
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
                                    Text("Contact info",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        )),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      width: 212.0,
                                      height: 66.0,
                                      child: Text(
                                          "Lorem ipsum dolor sit amet consectetur. Volutpat suspendisse",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text("Email : kkbazar@gmail.com",
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Other widgets after the scrollable content
            )
          ]));
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
                            Container(
                              width: 338,
                              height: 274.16302490234375,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        width: 1, color: Color(0xffEF8F21))),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Username or Email",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Container(
                                        width: 280.2107238769531,
                                        height: 33.59840774536133,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0x2bef8f21)),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                          ), // controller: emailController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          // validator: validateEmail,
                                          // contentPadding:
                                          //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text("Password",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Container(
                                        width: 280.2107238769531,
                                        height: 33.59840774536133,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0x2bef8f21)),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'password',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                            ),
                                            suffixIcon: IconButton(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        end: 10.0),
                                                icon: _isobscured1
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off),
                                                onPressed: () => setState(() {
                                                      _isobscured1 =
                                                          !_isobscured1;
                                                    })),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                          ), // controller: emailController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,

                                          // validator: validateEmail,
                                          // contentPadding:
                                          //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Center(
                                        // child: Obx(
                                        //       () => apiController.isLoading.value
                                        //       ? CircularProgressIndicator()
                                        //       :
                                        child: Container(
                                          width: 211.66998291015625,
                                          height: 33.59840774536133,
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashboardPage()));

                                              // final postData = {
                                              //   'name': nameController.text.toString(),
                                              //   'email':
                                              //   emailController.text.toString(),
                                              //   'mobile_number':
                                              //   numberController.text.toString(),
                                              //   'password': _pass.text.toString()
                                              // };
                                              // apiController.postDataToApi(
                                              //     postData, context);
                                            },
                                            child: Text("SUBMIT",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ),
                                        ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            SizedBox(height: 40.0),
                            Center(
                              child: Text("OR",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                            ),
                            SizedBox(height: 40.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 315,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff4285f4)),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 46,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white)),
                                          ),
                                          Positioned(
                                              left: 22.0,
                                              top: 15.0,
                                              child: Image.asset(
                                                  'images/Google.png')),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text("Continue with Google",
                                          style: TextStyle(
                                            fontSize: 19,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                // Image.asset(
                                //   "images/Line 6.png",
                                //   color: Colors.black,
                                // ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: 320,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff3b5998)),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 46,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white)),
                                          ),
                                          Positioned(
                                              left: 18.0,
                                              top: 12.0,
                                              child: Image.asset(
                                                'images/Facebook App Symbol.png',
                                                width: 25,
                                                height: 25,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text("Continue with Facebook",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                          )),
                                    ],
                                  ),
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
                            Container(
                              width: 338,
                              height: 274.16302490234375,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        width: 1, color: Color(0xffEF8F21))),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Username or Email",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Container(
                                        width: 280.2107238769531,
                                        height: 33.59840774536133,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0x2bef8f21)),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                          ), // controller: emailController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          // validator: validateEmail,
                                          // contentPadding:
                                          //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text("Password",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                      SizedBox(height: 10.0),
                                      Container(
                                        width: 280.2107238769531,
                                        height: 33.59840774536133,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0x2bef8f21)),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'password',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                            ),
                                            suffixIcon: IconButton(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        end: 10.0),
                                                icon: _isobscured1
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off),
                                                onPressed: () => setState(() {
                                                      _isobscured1 =
                                                          !_isobscured1;
                                                    })),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                          ), // controller: emailController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,

                                          // validator: validateEmail,
                                          // contentPadding:
                                          //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Center(
                                        // child: Obx(
                                        //       () => apiController.isLoading.value
                                        //       ? CircularProgressIndicator()
                                        //       :
                                        child: Container(
                                          width: 211.66998291015625,
                                          height: 33.59840774536133,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffEF8F21)
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashboardPage()));

                                              // final postData = {
                                              //   'name': nameController.text.toString(),
                                              //   'email':
                                              //   emailController.text.toString(),
                                              //   'mobile_number':
                                              //   numberController.text.toString(),
                                              //   'password': _pass.text.toString()
                                              // };
                                              // apiController.postDataToApi(
                                              //     postData, context);
                                            },
                                            child: Text("SUBMIT",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ),
                                        ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            SizedBox(height: 40.0),
                            Center(
                              child: Text("OR",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                            ),
                            SizedBox(height: 40.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 315,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff4285f4)),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 46,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white)),
                                          ),
                                          Positioned(
                                              left: 22.0,
                                              top: 15.0,
                                              child: Image.asset(
                                                  'images/Google.png')),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text("Continue with Google",
                                          style: TextStyle(
                                            fontSize: 19,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                // Image.asset(
                                //   "images/Line 6.png",
                                //   color: Colors.black,
                                // ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: 320,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff3b5998)),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 46,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white)),
                                          ),
                                          Positioned(
                                              left: 18.0,
                                              top: 12.0,
                                              child: Image.asset(
                                                'images/Facebook App Symbol.png',
                                                width: 25,
                                                height: 25,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text("Continue with Facebook",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                          )),
                                    ],
                                  ),
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
            ],
          ),
        ),
      ));
    }
  }
}
