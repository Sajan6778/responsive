import 'package:flutter/material.dart';

import 'notification_orderreturn_accepted.dart';
import 'notification_orderreturn_request.dart';

class RefundAmountDialog extends StatelessWidget {
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
        height: 484,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: RefundAmount(),
      ),
    );
  }
}

class RefundAmount extends StatefulWidget {
  @override
  State<RefundAmount> createState() => _RefundAmountState();
}

class _RefundAmountState extends State<RefundAmount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 828,
        height: 484,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Column(
          children: [
            Container(
              width: 828,
              height: 98,
              decoration: BoxDecoration(color: Color(0x2bef8f21)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Center(
                      child: Text("Order Return",
                          style: TextStyle(
                            fontSize: 28,
                          )),
                    ),
                    Positioned(
                      right: 30,
                      top: 20.0,
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
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Refund Amount",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(height: 20.0),
                  Container(
                      width: 745,
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0x2bef8f21)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount paid",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                Text("₹539.00",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Customer Charge",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                Text("₹0.00",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Refund Amount",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                Text("₹539.00",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Text("Return Tracking",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(height: 20.0),
                  Visibility(
                    visible: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff0A9A21),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Visibility(
                            visible: true,
                            child: Text(
                                "Refund will be transferred tomorrow or the after tomorrow",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 828,
              height: 51,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0x2bdbdbdb)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Image.asset("images/Viber.png"),
                    SizedBox(width: 20.0),
                    Text("6349803472",
                        style: TextStyle(
                          fontSize: 20,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// To show the dialog
showRefunAmountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RefundAmountDialog();
    },
  );
}
