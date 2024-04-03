import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();

  Future<void> _performSearch(String query) async {
    final apiUrl = "http://your-api-endpoint.com/search";

    // Perform your POST request here using the http package
    // You can customize headers, body, etc., based on your API requirements
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'query': query},
    );

    if (response.statusCode == 200) {
      // Handle the successful response
      print("API Response: ${response.body}");
    } else {
      // Handle errors
      print("API Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter your search query',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = _searchController.text;
                    _performSearch(query);
                  },
                ),
              ),
            ),
            // Add other UI components as needed
          ],
        ),
      ),
    );
  }
}
