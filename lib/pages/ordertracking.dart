import 'package:flutter/material.dart';

class OrderTrackingDialog extends StatelessWidget {
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
        height: 599,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: OrderTracking(),
      ),
    );
  }
}

class OrderTracking extends StatefulWidget {
  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
            width: 828,
            height: 600,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            child: Column(
              children: [
                Container(
                  width: 783,
                  height: 64,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEF8F21)),
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x2bef8f21)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Order Tracking",
                        style: TextStyle(
                          fontSize: 33.970794677734375,
                        )),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffEF8F21), width: 1),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Image.asset("images/Line 21.png"),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text("order placed",
                                  style: TextStyle(
                                    fontSize: 19,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10.0),
                                child: Row(
                                  children: [
                                    Text(".",
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Text("On Sat, 28 Oct",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffEF8F21), width: 1),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Image.asset("images/Line 21.png"),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Column(
                            children: [
                              Text("order confirmed",
                                  style: TextStyle(
                                    fontSize: 19,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 10.0),
                                child: Row(
                                  children: [
                                    Text(".",
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Text("On Sat, 28 Oct",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffEF8F21), width: 1),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Image.asset("images/Line 21.png"),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            children: [
                              Text("Shipment has been processed",
                                  style: TextStyle(
                                    fontSize: 19,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 130.0, top: 10.0),
                                child: Row(
                                  children: [
                                    Text(".",
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Text("On Sat, 28 Oct",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffEF8F21), width: 1),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Image.asset("images/Line 22.png"),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            children: [
                              Text("Shipment is ready",
                                  style: TextStyle(
                                    fontSize: 19,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, top: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(".",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Center(
                                          child: Text("On Sat, 28 Oct",
                                              style: TextStyle(
                                                fontSize: 15,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Text(".",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Center(
                                          child: Text("On Sat, 28 Oct",
                                              style: TextStyle(
                                                fontSize: 15,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Text(".",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Center(
                                          child: Text("On Sat, 28 Oct",
                                              style: TextStyle(
                                                fontSize: 15,
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffEF8F21), width: 1),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Image.asset("images/Line 24.png"),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            children: [
                              Text("Ready to pickup",
                                  style: TextStyle(
                                    fontSize: 19,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, top: 10.0),
                                child: Row(
                                  children: [
                                    Text(".",
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Text("On Sat, 28 Oct",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      // Column(
                      //   children: [
                      //
                      //     SizedBox(height: 5.0),
                      //     Container(
                      //       width: 4.2,
                      //       height: 4.2,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: Color(0xffEF8F21), width: 1),
                      //       ),
                      //     ),
                      //     SizedBox(height: 5.0),
                      //     Image.asset("images/Line 21.png"),
                      //     SizedBox(height: 5.0),
                      //     Container(
                      //       width: 4.2,
                      //       height: 4.2,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: Color(0xffEF8F21), width: 1),
                      //       ),
                      //     ),
                      //     SizedBox(height: 5.0),
                      //     Image.asset(
                      //       "images/Line 22.png",
                      //       height: 100.0,
                      //     ),
                      //     SizedBox(height: 5.0),
                      //     Container(
                      //       width: 4.2,
                      //       height: 4.2,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: Color(0xffEF8F21), width: 1),
                      //       ),
                      //     ),
                      //     SizedBox(height: 5.0),
                      //     Image.asset("images/Line 21.png"),
                      //     SizedBox(height: 5.0),
                      //     Container(
                      //       width: 4.2,
                      //       height: 4.2,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: Color(0xffEF8F21), width: 1),
                      //       ),
                      //     ),
                      //     SizedBox(height: 5.0),
                      //     Image.asset("images/Line 24.png"),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 783,
                    height: 47,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffEF8F21)),
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x2bef8f21)),
                    child: Center(
                      child: Text("OK", style: TextStyle(fontSize: 24)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

// To show the dialog
showOrderTrackingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return OrderTrackingDialog();
    },
  );
}
