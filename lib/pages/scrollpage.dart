import 'package:flutter/material.dart';

class ScrollItemsPerPage extends StatefulWidget {
  @override
  _ScrollItemsPerPageState createState() => _ScrollItemsPerPageState();
}

class _ScrollItemsPerPageState extends State<ScrollItemsPerPage> {
  PageController _pageController = PageController();
  int currentPage = 0;
  int itemsPerPage = 6;

  var fish_list = [
    {
      "image": "images/image 13 (1).png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 1568",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 14 (1).png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Fresho Kolkata/Bengali Saral Puti Fish - Whole, Uncleaned, 500 g"
    },
    {
      "image": "images/image 15.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹ 2000",
      "des":
          "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
    },
    {
      "image": "images/image 16.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 1000",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/image 17.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹506",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/image 18.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 765",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
  ];

  var product_list = [
    {
      "image": "images/fish.png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 1568",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/mobile.png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/jewells.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹ 2000",
      "des":
          "Vastate Makeup Drawer Organiser Box, Case Holder for Brush, Pen and Jewelry Organizer to Save Space"
    },
    {
      "image": "images/meat.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 1000",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/jewells.png",
      "name": "Jewells",
      "price": "₹ 1800",
      "mrp": "₹ 2000",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/meat.png",
      "name": "Meat",
      "price": "₹ 500",
      "mrp": "₹ 765",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/fish.png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/mobile.png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/fish.png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 1568",
      "des": "Basa Fillet - Fresh Chilled, Preservative Free/Pungas"
    },
    {
      "image": "images/mobile.png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/fish.png",
      "name": "Fish",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/mobile.png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
  ];

  var mob_list = [
    {
      "image": "images/mobile.png",
      "name": "Mobile",
      "price": "₹ 1452",
      "mrp": "₹ 2000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
    {
      "image": "images/mobile.png",
      "name": "Mobile",
      "price": "₹ 19052",
      "mrp": "₹ 21000",
      "des": "Seer Fish - Large Steaks, Fresh & Flavourful, 2-3 pcs,"
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = product_list.length;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 670,
            child: Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemCount: (product_list.length / itemsPerPage).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  int startIndex = index * itemsPerPage;
                  int endIndex = (index + 1) * itemsPerPage;
                  endIndex = endIndex < product_list.length
                      ? endIndex
                      : product_list.length;

                  List<Widget> gridItems = [];
                  for (int i = startIndex; i < endIndex; i++) {
                    gridItems.add(
                      Container(
                        width: screenSize.width,
                        height: 670,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 9,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 50,
                            mainAxisSpacing: 40,
                            mainAxisExtent: 310,
                          ),
                          itemBuilder: (context, itemIndex) {
                            int item = startIndex + itemIndex;
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(9.91282844543457),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Center(
                                        child: Image.asset(
                                          fish_list[item]["image"]!,
                                          width: 205,
                                          height: 205,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              width: 197.0,
                                              height: 24.0,
                                              child: Text(
                                                fish_list[item]["des"]!,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "MRP:",
                                                  style: TextStyle(
                                                    color: Color(0xff717171),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                                Text(
                                                  fish_list[item]["mrp"]!,
                                                  style: TextStyle(
                                                    color: Color(0xff717171),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Price:",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  product_list[item]["price"]!,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  "(${product_list[item]["price"]} / g)",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "(inclusive of all taxes)",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                Text(
                                                  "You Save: 31% OFF",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xff00B312),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 180.0,
                                  top: 10.0,
                                  child: Container(
                                    width: 21,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.5),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8.0),
                                        Image.asset("images/Heart (1).png"),
                                        SizedBox(height: 6.0),
                                        Image.asset(
                                            "images/Shopping bag (2).png"),
                                        SizedBox(height: 6.0),
                                        Image.asset(
                                            "images/More three dots button.png"),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 70.5,
                                  top: 170.0,
                                  child: Container(
                                    width: 81,
                                    height: 21.999996185302734,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.5),
                                      color: Color(0xc4ffffff),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Quick view",
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: gridItems),
                  );
                },
              ),
            ),
          ),
          _buildDotsIndicator(),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator() {
    int totalItems = product_list.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItems / itemsPerPage).ceil(),
        (index) {
          return InkWell(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index ? Colors.blue : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDotsIndicatormob() {
    int totalItems = mob_list.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItems / itemsPerPage).ceil(),
        (index) {
          return InkWell(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index ? Colors.blue : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
