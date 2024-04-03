import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'notification_orderreturn_accepted.dart';
import 'package:http/http.dart' as http;

class OrderReturnDialog extends StatelessWidget {
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
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: OrderReturn(),
      ),
    );
  }
}

class OrderReturn extends StatefulWidget {

  @override
  State<OrderReturn> createState() => _OrderReturnState();
}

class _OrderReturnState extends State<OrderReturn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reason = TextEditingController();

  String reason =  "";
  String Message="";

  Future<void> postData() async {
    int? userId = await getUserId();
    int? orderItemListId = await getOrderItemListId();
    print(reason);
    final url = Uri.parse( Constants.ipBaseUrl+'orderReturn/save');

    final Map<String, dynamic> data = {
      'userId':userId,
      'reasonForReturn':reason,
      'orderItemListId':orderItemListId,
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
      print('Output for return: $responseData');

      if (response.statusCode == 200) {

        final responseData = json.decode(response.body);
        Message = responseData[
        'message']; // Assuming error message is in 'message' key

        showToast();

        Navigator.of(context).pop();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DashboardPage()),
        // );

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
          height: 500,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Center(
                          child: Text("Order Return",
                              style: TextStyle(
                                fontSize: 33.970794677734375,
                              )),
                        ),
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
              SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reason for Return",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(height: 20.0),
                    Container(
                        width: 783,
                        height: 200,
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
                        )),
                    SizedBox(height: 40.0),
                    // Text("Return Instructions",
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //     )),
                    // SizedBox(height: 20.0),
                    // Container(
                    //   width: 783,
                    //   height: 340,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(4),
                    //       color: Color(0x2bef8f21)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 30.0, vertical: 10.0),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Column(
                    //               children: [
                    //                 SizedBox(height: 2.0),
                    //                 Text(".",
                    //                     style: TextStyle(
                    //                         fontSize: 35,
                    //                         fontWeight: FontWeight.bold)),
                    //                 SizedBox(height: 30.0),
                    //                 Text(".",
                    //                     style: TextStyle(
                    //                         fontSize: 35,
                    //                         fontWeight: FontWeight.bold)),
                    //                 Text(".",
                    //                     style: TextStyle(
                    //                         fontSize: 35,
                    //                         fontWeight: FontWeight.bold)),
                    //                 Text(".",
                    //                     style: TextStyle(
                    //                         fontSize: 35,
                    //                         fontWeight: FontWeight.bold)),
                    //                 SizedBox(height: 3.0),
                    //                 Text(".",
                    //                     style: TextStyle(
                    //                         fontSize: 35,
                    //                         fontWeight: FontWeight.bold)),
                    //               ],
                    //             ),
                    //             SizedBox(width: 20.0),
                    //             Column(
                    //               children: [
                    //                 SizedBox(height: 20.0),
                    //                 Container(
                    //                   width: 600,
                    //                   height: 50,
                    //                   child: Text(
                    //                       "Lorem ipsum dolor sit amet consectetur At eget nibh amet facilisis ",
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                       )),
                    //                 ),
                    //                 SizedBox(height: 20.0),
                    //                 Container(
                    //                   width: 600,
                    //                   child: Text(
                    //                       "Lorem ipsum dolor sit amet consectetur ",
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                       )),
                    //                 ),
                    //                 SizedBox(height: 20.0),
                    //                 Container(
                    //                   width: 600,
                    //                   child: Text(
                    //                       "Lorem ipsum dolor sit amet consectetur  ",
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                       )),
                    //                 ),
                    //                 SizedBox(height: 20.0),
                    //                 Container(
                    //                   width: 600,
                    //                   child: Text(
                    //                       "Lorem ipsum dolor sit amet consectetur  ",
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                       )),
                    //                 ),
                    //                 SizedBox(height: 20.0),
                    //                 Container(
                    //                   width: 600,
                    //                   child: Text(
                    //                       "Lorem ipsum dolor sit amet consectetur At ",
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                       )),
                    //                 ),
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15.0),

                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();

                    if (_formKey.currentState!.validate()) {
                      reason = _reason.text.trim();
                      postData();
                    }
                    // showOrderReturn_Accepted_NotificationDialog(
                    //     context);
                  },
                  child: Container(
                      width: 79,
                      height: 39,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xbcef8f21)),
                      child: Center(
                        child: Text("OK",
                            style: TextStyle(
                                fontSize: 22, color: Colors.white)),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

Future<int?> getOrderItemListId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('orderitemlistid');
}

// To show the dialog
showOrderReturnDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return OrderReturnDialog();
    },
  );
}
