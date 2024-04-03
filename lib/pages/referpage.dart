import 'package:flutter/material.dart';
import 'package:responsive/pages/productlistpage.dart';

class YourPage extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  // Your variables and controllers
  late PageController _pageControllermeat;
  int hoveredIndexmeat = -2;

  List<Map<String, String>> meat_list = [
    {
      "image": "images/image 27.png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 1568",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 29.png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 30.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹ 2000",
      "des":
      "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
    },
    {
      "image": "images/image 31.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 1000",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
  ];

  PageController _pageControllersmeat = PageController();
  int currentPagemeat = 0;
  int itemsPerPagemeat = 4;

  @override
  void disposemeat() {
    _pageControllersmeat.dispose();
    super.dispose();
  }

  void onPageChangedmeat(int page3) {
    setState(() {
      currentPagemeat = page3;
    });
  }
  List<Map<String, dynamic>> wishlistItems = [];
  List<bool> isFavoriteList = List.generate(FishData.length, (index) => false);

  @override
  Widget build(BuildContext context) {

    int totalItemsmeat = meat_list.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Meat Page'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: FishData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                isFavoriteList[index] = !isFavoriteList[index];
                // You can add logic here to handle wishlist items if needed
              });
            },
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Text('Item ${index + 1}'),
                ),
                Positioned(
                  top: 5.0,
                  right: 5.0,
                  child: Icon(
                    isFavoriteList[index]
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavoriteList[index] ? Colors.red : null,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
List< dynamic> FishData = List.generate(
  20,
      (index) => {'name': 'Fish ${index + 1}', 'description': 'Description $index'},
);