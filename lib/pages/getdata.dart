import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  String productName = '';

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('http://192.168.29.106:8081/product/views'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        productName = data[0]['productName'] ?? ''; // Assigning productName
      });
    } else {
      print('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Name'),
      ),
      body: Center(
        child: Text(
          'Product Name: $productName',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
