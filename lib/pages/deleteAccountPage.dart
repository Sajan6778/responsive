import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive/pages/dashboardpage.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'package:http/http.dart' as http;

class DeleteAccountDialog extends StatelessWidget {
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
    return Center(
      child: Container(
        width: 828,
        height: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: DeleteAccount(),
      ),
    );
  }
}

class DeleteAccount extends StatefulWidget {
  @override
  State<DeleteAccount> createState() => _OrderReturnState();
}

class _OrderReturnState extends State<DeleteAccount> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _reason = TextEditingController();

  late bool _isobscured1 = true;
  late bool _isobscured = true;

  String password = "";
  String confirmPassword = "";
  String reason =  "";

  final AuthService authService = AuthService();

  String Message="";

  Future<void> postData() async {
    int? userId = await getUserId();
    print(userId);
    print(password);
    print(confirmPassword);
    print(reason);
    final url = Uri.parse( Constants.ipBaseUrl+'accountDeactivationDetails/save');

    final Map<String, dynamic> data = {
      'userId':userId,
      'currentPassword': password,
      'repeatPassword':confirmPassword,
      'reasonForDeactivation':reason
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
      print('Output for deactivation: $responseData');

      if (response.statusCode == 200) {

        final responseData = json.decode(response.body);
        Message = responseData[
        'message']; // Assuming error message is in 'message' key

        showToast();
        await authService.logout();
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );

      }
      else if (response.statusCode == 400) {

        final responseData = json.decode(response.body);
         Message = responseData[
        'message']; // Assuming error message is in 'message' key

        showToast();
      }
      else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void showToastMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          width: 828,
          height: 900,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: Colors.white),
          child: Column(
            children: [
              Container(
                width: 828,
                height: 98,
                decoration: BoxDecoration(color: Color(0x2bef8f21)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text("Delete Your Account",
                              style: TextStyle(
                                fontSize: 33.970794677734375,
                              )),
                        ),
                      ),
                      SizedBox(width: 350.0),
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
              ),
              SizedBox(height: 20.0),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black)),
                    SizedBox(height: 10.0),
                    Container(
                      width: 350,
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
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 5.0,
                          ),
                        ),
                        style: TextStyle(fontSize: 18),
                      ),// controller: emailController,

                        // contentPadding:
                        //     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      ),
                    SizedBox(height: 30.0),
                    Text("Confirm Password",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black)),
                    SizedBox(height: 10.0),
                    Container(
                      width: 350,
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
                    SizedBox(height: 40.0),
                    Text("Give Reason For Delete Your Account",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(height: 20.0),
                    Container(
                        width: 783,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x2bef8f21)),
                        child: TextFormField(

                          maxLines: 30,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                          controller: _reason,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Enter reason.";
                            }
                            return null;
                          },
                        ),

                    ),
                    SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            password = _pass.text.trim();
                           confirmPassword = _confirmPass.text.trim();
                            reason = _reason.text.trim();
                            postData();
                          }
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 61,
                          height: 33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xbcef8f21)),
                          child: Center(
                            child: Text("OK",
                                style:
                                TextStyle(fontSize: 22, color: Colors.white)),
                          ),
                        ),
                      ),
                    )



                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}

// To show the dialog
showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteAccountDialog();
    },
  );
}
