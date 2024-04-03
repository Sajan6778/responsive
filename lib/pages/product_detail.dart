import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isChecked = false;

  int currentQuantityIndex = 0;
  late List<bool> isPressedList;
  late List<int> counters;
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

  @override
  void initState() {
    super.initState();
    isPressedList = List.generate(fish_list.length, (index) => false);
    counters = List.generate(fish_list.length, (index) => 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Fish",
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'RedRose',
                            fontWeight: FontWeight.bold)),
                    Container(
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
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                  children: [
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "images/image 13 (1).png",
                          width: 112.21310424804688,
                          height: 112.21310424804688,
                        ),
                        SizedBox(height: 40.0),
                        Image.asset(
                          "images/image 13 (1).png",
                          width: 112.21310424804688,
                          height: 112.21310424804688,
                        ),
                        SizedBox(height: 40.0),
                        Image.asset(
                          "images/image 13 (1).png",
                          width: 112.21310424804688,
                          height: 112.21310424804688,
                        ),
                      ],
                    ),
                    SizedBox(width: 40.0),
                    Container(
                      width: 408.6566467285156,
                      height: 420.783935546875,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image.asset(
                        width: 200,
                        height: 200,
                        "images/image 13 (1).png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 40.0),
                    Container(
                        width: 730,
                        height: 480,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("KK BAZAR",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Color(0xff717171),
                                              offset: Offset(0, -10))
                                        ],
                                        color: Colors.transparent,
                                        decorationColor: Color(0xff717171),
                                        decoration: TextDecoration.underline,
                                        fontSize: 20,
                                      )),
                                  Container(
                                    width: 67,
                                    height: 23,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        color: Color(0x99fab442)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "images/Delivery man.png"),
                                          SizedBox(width: 5.0),
                                          Text("8 hrs",
                                              style: TextStyle(
                                                fontSize: 10.399999618530273,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: 396.0,
                                height: 50.0,
                                child: Text(
                                    "Seer Fish - Large Steaks, Fresh & Flavourful/Surmai/Anjal, 250 g",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Description",
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                  Row(
                                    children: [
                                      Text("Nagercoil",
                                          style: TextStyle(
                                            fontSize: 12.361445426940918,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              Icon(Icons.location_on_outlined))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: 396.9328918457031,
                                height: 117.2375717163086,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.grey),
                                //     borderRadius: BorderRadius.circular(10),
                                //     color: Color(0xeaffffff)),
                                child: Card(
                                  elevation: 20.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                        "Seer fish is known for its great taste and different health benefits. It is one of the favourite fish in the south. It is used to make different delicacies including fish pickles. Seer fish is good for the heart and has a rich content of Omega-3 fatty acids. This Fresho Seer Fish Large Steaks sliced seer fish comes without the head. It is clean and gutted. This comes in 6-8 pcs which are perfect for 6-8 people. Fresho takes utmost care in selecting the best suppliers to provide you with high quality and succulent products. Every product is stored in our cold storage right until your doorstep ensuring freshness and utmost hygiene.",
                                        style: TextStyle(
                                          color: Color(0xff717171),
                                          fontSize: 10,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text("MRP:₹779",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff717171))),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("Price: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                        Text("₹539 ",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: [
                                              Text("(₹2.16 ",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xff717171))),
                                              Text("/ g) ",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xff717171))),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text("You Save:31% OFF",
                                              style: TextStyle(
                                                  fontSize: 10.297520637512207,
                                                  color: Color(0xff00B312))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 103,
                                    height: 19,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        color: Color(0x99fab442)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text("Quantity",
                                            style: TextStyle(
                                              fontSize: 11,
                                            )),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        hideButton1()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Text("(inclusive of all taxes)",
                                  style: TextStyle(
                                    fontSize: 11,
                                  )),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 194,
                                      height: 40.1379280090332,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xfffab442)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "images/Add to basket.png",
                                            width: 14.0,
                                            height: 14.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10.0),
                                          Text("Add Cart",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white))
                                        ],
                                      )),
                                  Container(
                                      width: 194,
                                      height: 40.1379280090332,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xfffab442)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "images/Heart.png",
                                            width: 14.0,
                                            height: 14.0,
                                            color: Color(0xfffab442),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text("Whishlist",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xfffab442)))
                                        ],
                                      ))
                                ],
                              ),
                            ]))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hideButton(int index) {
    return InkWell(
      // onTap: () {
      //   setState(() {
      //     isPressed = false;
      //   });
      // },
      child: Container(
        width: 44,
        height: 19,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Color(0xfffab442)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    // _counter != 1 ? _counter-- : isPressed = false;
                    counters[index] != 1
                        ? counters[index]--
                        : isPressedList[index] = false;
                  });
                },
                child: Image.asset(
                  "images/minus.png",
                  color: Colors.white,
                  width: 7.0,
                  height: 7.0,
                ),
              ), // <-- Text

              Center(
                child: Text(
                  "${counters[index]}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (counters[index] <= 4) {
                      counters[index]++;
                    }
                  });
                },
                child: Image.asset(
                  "images/plus.png",
                  color: Colors.white,
                  width: 7.0,
                  height: 7.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hideButton1() {
    return Container(
      width: 44,
      height: 19,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Color(0xfffab442)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (counters[currentQuantityIndex] != 1) {
                    counters[currentQuantityIndex]--;
                  } else {
                    isPressedList[currentQuantityIndex] = false;
                  }
                });
              },
              child: Image.asset(
                "images/minus.png",
                color: Colors.white,
                width: 7.0,
                height: 7.0,
              ),
            ), // <-- Text

            Center(
              child: Text(
                "${counters[currentQuantityIndex]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  if (counters[currentQuantityIndex] <= 4) {
                    counters[currentQuantityIndex]++;
                  }
                });
              },
              child: Image.asset(
                "images/plus.png",
                color: Colors.white,
                width: 7.0,
                height: 7.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
