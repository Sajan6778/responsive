import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage1 extends StatefulWidget {
  @override
  _WishlistPage1State createState() => _WishlistPage1State();
}

class _WishlistPage1State extends State<WishlistPage1> {
  late List<bool> isFavoriteList;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadWishlistStates();
  }

  Future<void> loadWishlistStates() async {
    setState(() {
      isFavoriteList = List.generate(
        10,
            (item) => prefs.getBool('wishlistClicked_$item') ?? false,
      );
    });
  }

  Future<void> toggleWishlist(int item) async {
    setState(() {
      isFavoriteList[item] = !isFavoriteList[item];
    });

    await prefs.setBool('wishlistClicked_$item', isFavoriteList[item]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Page'),
      ),
      body: ListView.builder(
        itemCount: 10, // Adjust this to the number of items in your ListView
        itemBuilder: (context, itemIndex) {
          int item = itemIndex;
          return ListTile(
            title: Text('Item $item'),
            trailing: InkWell(
              onTap: () async {
                toggleWishlist(item);
              },
              child: Icon(
                isFavoriteList[item] ? Icons.favorite : Icons.favorite_border,
                color: isFavoriteList[item] ? Colors.red : null,
                size: 18.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
