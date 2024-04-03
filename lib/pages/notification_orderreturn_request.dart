import 'package:flutter/material.dart';

class OrderReturn_Send_NotificationDialog extends StatelessWidget {
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
        width: 753,
        height: 192,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: OrderNotification(),
      ),
    );
  }
}

class OrderNotification extends StatefulWidget {
  @override
  State<OrderNotification> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Container(
            width: 753,
            height: 192,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("refund Request Form",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(height: 20.0),
                Container(
                  width: 698.0,
                  height: 50.0,
                  child: Text(
                      "We request to send a refund for order id : 1249757 84225319706903. Could you wait for the confirmation.",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
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
        ));
  }
}

// To show the dialog
showOrderReturn_Send_NotificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return OrderReturn_Send_NotificationDialog();
    },
  );
}
