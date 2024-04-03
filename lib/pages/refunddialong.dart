import 'package:flutter/material.dart';

import 'RefundAmont.dart';
import 'notification_orderreturn_accepted.dart';
import 'notification_orderreturn_request.dart';

class OrderRefundDialog extends StatelessWidget {
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
        height: 421,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: OrderRefund(),
      ),
    );
  }
}

class OrderRefund extends StatefulWidget {
  @override
  State<OrderRefund> createState() => _OrderRefundState();
}

class _OrderRefundState extends State<OrderRefund> {
  bool paymentvalue = false;
  bool paymentvalue1 = false;
  bool show = false;
  bool show1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 828,
        height: 421,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Column(
          children: [
            Container(
              width: 828,
              height: 71,
              decoration: BoxDecoration(color: Color(0x2bef8f21)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text("Refund",
                      style: TextStyle(
                        fontSize: 28,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.0),
                  Text("payment Type",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    width: 769,
                    height: 144,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      elevation: 10.0,
                      child: Column(
                        children: [
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                paymentvalue = true; // Set the hovered index
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                paymentvalue = false; // Reset when mouse exits
                              });
                            },
                            child: Container(
                              width: 769,
                              height: 68,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // color: Color(0x2bef8f21)
                                  color: paymentvalue == true || show == true
                                      ? Color(0x2bef8f21)
                                      : Colors.white),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Visibility(
                                            visible:
                                                show == true ? true : false,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  show = false;
                                                });
                                              },
                                              child: Container(
                                                width: 17.0,
                                                height: 17.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffEF8F21),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                show == true ? false : true,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  show = true;
                                                  show1 = false;
                                                });
                                              },
                                              child: Container(
                                                width: 17.0,
                                                height: 17.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Color(0xffEF8F21),
                                                      width: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20.0),
                                      Text("Google pay",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                paymentvalue1 = true; // Set the hovered index
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                paymentvalue1 = false; // Reset when mouse exits
                              });
                            },
                            child: Container(
                              width: 769,
                              height: 68,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: paymentvalue1 == true || show1 == true
                                      ? Color(0x2bef8f21)
                                      : Colors.white),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Visibility(
                                            visible:
                                                show1 == true ? true : false,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  show1 = false;
                                                });
                                              },
                                              child: Container(
                                                width: 17.0,
                                                height: 17.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffEF8F21),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                show1 == true ? false : true,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  show1 = true;
                                                  show = false;
                                                });
                                              },
                                              child: Container(
                                                width: 17.0,
                                                height: 17.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Color(0xffEF8F21),
                                                      width: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20.0),
                                      Text("other",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      showRefunAmountDialog(context);
                    },
                    child: Container(
                      width: 769,
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xbcef8f21)),
                      child: Center(
                        child: Text("PROCEED",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// To show the dialog
showOrderRefundDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return OrderRefundDialog();
    },
  );
}
