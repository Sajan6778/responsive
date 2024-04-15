import 'package:flutter/material.dart';
import 'package:responsive/pages/Addressmanager.dart';
import 'package:responsive/pages/Login.dart';
import 'package:responsive/pages/demodesign.dart';
import 'package:responsive/pages/newdeatail.dart';
import 'package:responsive/pages/pdf%20file.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:responsive/pages/Responsive_login.dart';
import 'package:responsive/pages/dashboardpage.dart';
import 'package:responsive/pages/dialogbox.dart';
import 'package:responsive/pages/new.dart';
import 'package:responsive/pages/newproductlist.dart';
import 'package:responsive/pages/product_detail.dart';
import 'package:responsive/pages/referpage.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  runApp(const MyApp());
  setUrlStrategy(PathUrlStrategy());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddressManager()),
        // Add more providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KK BAZAR',
        theme: ThemeData(
          fontFamily: 'RedRose',
        ),
        onGenerateRoute: (settings) {
          // Define your routes here
          return MaterialPageRoute(
            builder: (context) {
              // Depending on the route settings, return the corresponding widget
              return Login();
            },
          );
        },
      ),
    );
  }
}