import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:responsive/pages/wishlist_page.dart';

import 'package:http/http.dart' as http;
import 'Cartpage.dart';
import 'constants.dart';
import 'dialogbox.dart';
import 'dropdown_model.dart';
import 'newproductlist.dart';
import 'order_orderhistory.dart';

List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];
List<String> list2 = <String>[
  'Mobile',
  'Fish',
  'Meat',
  'Vegetables',
  'Groceries',
  'Cosmetics',
  'Footwear',
  'Apparels',
  'Artificial Jewelry',
];

List<String> brand = <String>[
  'Chanel',
  'Christian Dior',
  'louis vuitton',
  'Calvin Klein',
];



class ProductListPage extends StatefulWidget {
 final List<int> carosalcatid ;
  const ProductListPage({super.key, required this.carosalcatid });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {


  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  List<bool> checkedList = List.generate(list2.length, (index) => false);
  List<bool> checkedList1 = List.generate(brand.length, (index) => false);

  int hoveredIndex = -1;
  int hoveredIndex1 = -2;
  int hoveredIndexrecom = -3;




  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  int currentQuantityIndex = 0;
  late List<bool> isPressedList;
  late List<int> counters;
  List<dynamic>  datas=[];
  late List<dynamic> productDatas=[];
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
  late List<dynamic> productmainimage=[];

  @override
  void initState() {
    super.initState();
    isPressedList = List.generate(fish_list.length, (index) => false);
    counters = List.generate(fish_list.length, (index) => 1);

    _fetchData();
  }

  Future<void> _fetchData() async {
    List<int> receivedId = widget.carosalcatid;
    await getData(receivedId);
    print('All data fetched'); // This will be printed after all data is fetched
  }

  PageController _pageControllerfish = PageController();
  int currentPagefish = 0;
  int itemsPerPagefish = 5;

  @override
  void disposefish() {
    _pageControllerfish.dispose();
    super.dispose();
  }

  void onPageChangedfish(int page2) {
    setState(() {
      currentPagefish = page2;
    });
  }

  PageController _pageControllerfish1 = PageController();
  int currentPagefish1 = 0;
  int itemsPerPagefish1 = 5;

  @override
  void disposefish1() {
    _pageControllerfish1.dispose();
    super.dispose();
  }

  void onPageChangedfish1(int page3) {
    setState(() {
      currentPagefish1 = page3;
    });
  }

  Future<void> getData(List<int> receivedId) async {
    final String baseUrl = 'http://192.168.29.106:8081/product/category/view';

    try {
      for (int id in receivedId) {
        final url = Uri.parse('$baseUrl/$id');

        try {
          final response = await http.get(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);

            // Handle further actions as needed upon successful response
            print('Data for ID $id: $responseData');

            if (responseData.isNotEmpty) {
              for (var data in responseData) {
                List<dynamic> productDetails = data['productDetails'];

                for (var product in productDetails) {
                  List<dynamic> productListDetails = product['productListDetails'];
                  List<dynamic> productImages = product['productImages'];

                  // Accessing productImages
                  String productImageUploadUrl = productImages.isNotEmpty
                      ? productImages[0]['productImagesUploadUrl']
                      : '';

                  // Accessing productListDetails for each product
                  for (var details in productListDetails) {
                    String productName = details['productName'];
                    double sellRate = details['sellRate'];

                    // Accessing productVarientImagesList
                    List<dynamic> productVarientImagesList = details['productVarientImagesList'];

                    // Use these values as needed
                    print('Product Image Upload URL: $productImageUploadUrl');
                    print('Product Name: $productName');
                    print('Sell Rate: $sellRate');

                    // Accessing productVarientImagesList details
                    for (var varientImage in productVarientImagesList) {
                      String varientImageUrl = varientImage['productVarientImageUrl'];
                      // Access other required fields similarly
                      print('Varient Image URL: $varientImageUrl');
                      // Print or use other details accordingly
                    }
                  }
                }
              }
            }
          } else {
            print('Failed to fetch data for ID $id. Status code: ${response.statusCode}');
          }
        } catch (error) {
          print('Error fetching data for ID $id: $error');
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Future<void> getData1(List<int> receivedId) async {
  //   final String baseUrl = 'http://192.168.29.106:8081/productList/views';
  //
  //   try {
  //     for (int id in receivedId) {
  //       final url = Uri.parse('$baseUrl/$id');
  //
  //       try {
  //         final response = await http.get(
  //           url,
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //           },
  //         );
  //
  //         if (response.statusCode == 200) {
  //           final responseData = jsonDecode(response.body);
  //
  //           // Handle further actions as needed upon successful response
  //           print('Data for ID $id: $responseData');
  //
  //           if (responseData.isNotEmpty) {
  //             for (var data in responseData) {
  //                String productName = data['productName'];
  //               List<dynamic> productDetails = data['productList'];
  //
  //               for (var product in productDetails) {
  //                 List<dynamic> productListDetails = product['varientList'];
  //                 double mrpValue = product['mrp'];
  //                 double sellRate = product['sellRate'];
  //                 double des = product['description'];
  //
  //
  //                 // Accessing productListDetails for each product
  //                 for (var details in productListDetails) {
  //
  //
  //                   // Accessing productVarientImagesList
  //                   List<dynamic> varientImages = details['varientImages'];
  //
  //                   String productImageUploadUrl = varientImages.isNotEmpty
  //                       ? varientImages[0]['productImagesUploadUrl']
  //                       : '';
  //
  //                   // Use these values as needed
  //                   // print('Product Image Upload URL: $productImageUploadUrl');
  //                   // print('Product Name: $productName');
  //                   // print('Sell Rate: $sellRate');
  //
  //                   // Accessing productVarientImagesList details
  //                   for (var varientImage in varientImages) {
  //                     String varientImageUrl = varientImage['productVarientImageUrl'];
  //                     // Access other required fields similarly
  //                     print('Varient Image URL: $varientImageUrl');
  //                     // Print or use other details accordingly
  //                   }
  //                 }
  //               }
  //             }
  //           }
  //         } else {
  //           print('Failed to fetch data for ID $id. Status code: ${response.statusCode}');
  //         }
  //       } catch (error) {
  //         print('Error fetching data for ID $id: $error');
  //       }
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }


  Future<List<DropdownModel>> getPost() async {
    try {
      final categoryResponse = await http.get(
        Uri.parse(Constants.ipBaseUrl + 'category?CategoryImage=CategoryDetail'),
      );

      if (categoryResponse.statusCode == 200) {
        final List<dynamic> body = json.decode(categoryResponse.body);

        if (body is List) {
          final List<DropdownModel> dropdownModels = body.map((e) {
            final map = e as Map<String, dynamic>;
            return DropdownModel(
              categoryId: map['categoryId'],
              categoryName: map['categoryName'],
              categoryImage: map['categoryImage'],
              url: map['url'],
            );
          }).toList();

          return dropdownModels;
        } else {
          // Return an empty list if the response body is not a List
          return [];
        }
      }
    } catch (error) {
      // Handle exceptions
      print("Error fetching data: $error");
      throw Exception("Error fetching data");
    }

    // Return an empty list if an error occurs
    return [];
  }
  var selectedValue;

  @override
  Widget build(BuildContext context) {
    int totalItemsfish = fish_list.length;
    int totalItemsfish1 = fish_list.length;
    var screenSize = MediaQuery.of(context).size;
    List<int> receivedId = widget.carosalcatid;
    print("receivedId :$receivedId");
    // getData(receivedId);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar:  PreferredSize(
          preferredSize: Size(screenSize.width, 77.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Padding(
              padding: const EdgeInsets.only(left: 50.0, top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Order Tracking : ",
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  // ShaderMask(
                  //   shaderCallback: (bounds) =>
                  //       LinearGradient(colors: [Colors.white, Color(0xffD8D8D8)])
                  //           .createShader(bounds),
                  //   child:
                  Text(
                      "Take advantage of our time to save event | Satisfaction guaranteed * ",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  // )
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 20.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text("Language",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                      SizedBox(
                        width: 14.0,
                      ),
                      Container(
                          height: 30,
                          color: Colors.white,
                          child: VerticalDivider(width: 2, color: Colors.white)),
                      SizedBox(
                        width: 14.0,
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          // tooltip: 'Show Snackbar',
                          onPressed: () {}),
                      SizedBox(
                        width: 14.0,
                      ),
                      Container(
                          height: 30,
                          color: Colors.white,
                          child: VerticalDivider(width: 2, color: Colors.white)),
                      SizedBox(
                        width: 14.0,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                          // tooltip: 'Show Snackbar',
                          onPressed: () {}),
                      SizedBox(
                        width: 50.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "images/image 46.png",
                      width: 100,
                      height: 100,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 182,
                          height: 51,
                          decoration: BoxDecoration(
                            color: Color(0x0c9c271b),
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Color(0xffD2D2D2)),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50.0),
                            ),
                          ),
                          child: Center(
                              child: DropdownButton<String>(
                            value: dropdownValue,
                            underline:
                                Container(), // This removes the underline
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                        ),
                        Container(
                            width: 170,
                            height: 51,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffD2D2D2)),
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                              ),
                            )),
                        Stack(
                          children: [
                            Container(
                              width: 52,
                              height: 51,
                              decoration: BoxDecoration(
                                color: Color(0xffef8f21),
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Color(0xffD2D2D2)),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(50.0),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5.0,
                              left: 3.0,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()));
                          },
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage(
                              'images/profile.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Image.asset(
                          "images/Notification (2).png",
                          width: 25.0,
                          height: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderHistoryPage()));
                          },
                          child: Image.asset(
                            "images/package.png",
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishlistPage()));
                          },
                          child: Image.asset(
                            "images/Heart.png",
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
                          },
                          child: Image.asset(
                            "images/Add to basket.png",
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: 77,
                child: Row(
                  children: [
                    FutureBuilder<List<DropdownModel>>(
                      future: getPost(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Text('No data available');
                        } else {
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: 320,
                              height: 77,
                              decoration: BoxDecoration(
                                color: Color(0xffef8f21),
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Color(0xffD2D2D2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                child: Center(
                                  child: DropdownButton<String>(
                                    underline:  Container(),
                                    dropdownColor: Color(0xffef8f21),
                                    value: selectedValue,
                                    icon: Container(
                                        margin: EdgeInsets.only(left: 30.0),
                                        child: Icon(Icons.menu, size: 25.0,color: Colors.white)),
                                    hint: Text("All Categories",style: TextStyle(
                                        color: Colors.white, fontSize: 22),),
                                    items: snapshot.data!.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.categoryName.toString(),
                                        child: Text(e.categoryName ?? '', style: TextStyle(
                                            color: Colors.white, fontSize: 22),),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });


                                      DropdownModel selectedCategory = snapshot.data!.firstWhere(
                                            (element) => element.categoryName == selectedValue,
                                      );
                                      print("Selected categoryId: ${selectedCategory.categoryId}");

                                      // Navigate to the NextPage with the selected categoryId
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewProductListPage(carosalcatid: [selectedCategory.categoryId ?? 0]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Container(
                      width: 820,
                      height: 77,
                      decoration: BoxDecoration(
                        color: Color(0x0c9c271b),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(0xffD2D2D2)),
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SizedBox(width: 20.0),
                      //     Text("Home",
                      //         style:
                      //         TextStyle(fontSize: 20, color: Colors.black)),
                      //     SizedBox(width: 20.0),
                      //     Text("Mobile",
                      //         style:
                      //         TextStyle(fontSize: 20, color: Colors.black)),
                      //     SizedBox(width: 20.0),
                      //     Text("Meat",
                      //         style:
                      //         TextStyle(fontSize: 20, color: Colors.black)),
                      //     SizedBox(width: 20.0),
                      //     Text("Fish",
                      //         style:
                      //         TextStyle(fontSize: 20, color: Colors.black)),
                      //     SizedBox(width: 20.0),
                      //     Text("Vegetables",
                      //         style:
                      //         TextStyle(fontSize: 20, color: Colors.black)),
                      //     SizedBox(width: 20.0),
                      //   ],
                      // ),
                    ),
                    Container(
                      width: 298,
                      height: 77,
                      decoration: BoxDecoration(
                        color: Color(0xffef8f21),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(0xffD2D2D2)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20.0),
                          Image.asset("images/Online support.png"),
                          SizedBox(width: 20.0),
                          Text("+00 123 456 789",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    Text("Home",
                        style: TextStyle(fontSize: 24, color: Colors.black)),
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        // tooltip: 'Show Snackbar',
                        onPressed: () {}),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("product list",
                        style: TextStyle(fontSize: 24, color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  width: 87,
                  height: 29,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffef8f21)),
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 2.0),
                      Text("Filter",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 269,
                        height: 1000,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0x0cffffff),
                            border: Border.all(color: Color(0xffCDCDCD))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 242,
                              height: 51,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0x0c9c271b)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("All Categories",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  SizedBox(width: 5.0),
                                  Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 420,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: list2.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              primarySwatch: Colors.blue,
                                              unselectedWidgetColor: Color(
                                                  0xffD2D2D2), // Your color
                                            ),
                                            child: Checkbox(
                                              checkColor: Color(0xffEF8F21),
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: checkedList[index],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  checkedList[index] =
                                                      value ?? false;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(list2[index],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Text("Select by Price",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          primarySwatch: Colors.blue,
                                          unselectedWidgetColor:
                                              Color(0xffD2D2D2), // Your color
                                        ),
                                        child: Checkbox(
                                          checkColor: Color(0xffEF8F21),
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text("Below 1000",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          primarySwatch: Colors.blue,
                                          unselectedWidgetColor:
                                              Color(0xffD2D2D2), // Your color
                                        ),
                                        child: Checkbox(
                                          checkColor: Color(0xffEF8F21),
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: isChecked2,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked2 = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text("Above 1000",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          primarySwatch: Colors.blue,
                                          unselectedWidgetColor:
                                              Color(0xffD2D2D2), // Your color
                                        ),
                                        child: Checkbox(
                                          checkColor: Color(0xffEF8F21),
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: isChecked1,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked1 = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text("Above 10000",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                  ),
                                  child: Text("Select by Brand",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: 200,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: brand.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              primarySwatch: Colors.blue,
                                              unselectedWidgetColor: Color(
                                                  0xffD2D2D2), // Your color
                                            ),
                                            child: Checkbox(
                                              checkColor: Color(0xffEF8F21),
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: checkedList1[index],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  checkedList1[index] =
                                                      value ?? false;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(brand[index],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30.0),
                      Container(
                        height: 1000,
                        child: Container(
                            width: 1096,
                            height: 514.1705322265625,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffCDCDCD)),
                                borderRadius:
                                    BorderRadius.circular(8.374112129211426),
                                color: Color(0xf7ffffff)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 40.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Fish",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'RedRose',
                                              fontWeight: FontWeight.bold)),
                                      // Container(
                                      //   width: 38.0,
                                      //   height: 38.0,
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: Color(0xfffab442),
                                      //   ),
                                      //   child: Center(
                                      //     child: IconButton(
                                      //       icon: Icon(Icons.close),
                                      //       color: Colors.white,
                                      //       onPressed: () {},
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(height: 26.0),
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
                                        width: 840,
                                        height: 416.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Image.asset(
                                          width: 725,
                                          height: 698.6990356445312,
                                          "images/image 13 (1).png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Container(
                                      height: 415,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.0),
                                            Container(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Description",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    )),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            Container(
                                              width: 1000,
                                              height: 117.2375717163086,
                                              child: Card(
                                                elevation: 20.0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Center(
                                                    child: Text(
                                                        "Seer fish is known for its great taste and different health benefits. It is one of the favourite fish in the south. It is used to make different delicacies including fish pickles. Seer fish is good for the heart and has a rich content of Omega-3 fatty acids. This Fresho Seer Fish Large Steaks sliced seer fish comes without the head. It is clean and gutted. This comes in 6-8 pcs which are perfect for 6-8 people. Fresho takes utmost care in selecting the best suppliers to provide you with high quality and succulent products. Every product is stored in our cold storage right until your doorstep ensuring freshness and utmost hygiene.",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff717171),
                                                          fontSize: 10,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            Text("MRP:₹779",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xff717171))),
                                            SizedBox(height: 10.0),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("Price: ",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      )),
                                                  Text("₹539 ",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Text("(₹2.16 ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff717171))),
                                                        Text("/ g) ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff717171))),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                        "You Save:31% OFF",
                                                        style: TextStyle(
                                                            fontSize:
                                                                10.297520637512207,
                                                            color: Color(
                                                                0xff00B312))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            Text("(inclusive of all taxes)",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                )),
                                            SizedBox(height: 20.0),
                                            Container(
                                              width: 84,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  color: Color(0x99fab442)),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  Text("Quantity",
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                      )),
                                                  SizedBox(
                                                    width: 6.0,
                                                  ),
                                                  hideButton1()
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20.0),
                                            Row(
                                              children: [
                                                Container(
                                                    width: 194,
                                                    height: 40.1379280090332,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xfffab442)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                color: Colors
                                                                    .white))
                                                      ],
                                                    )),
                                                SizedBox(width: 40.0),
                                                Container(
                                                    width: 194,
                                                    height: 40.1379280090332,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xfffab442)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "images/Heart.png",
                                                          width: 14.0,
                                                          height: 14.0,
                                                          color:
                                                              Color(0xfffab442),
                                                        ),
                                                        SizedBox(width: 10.0),
                                                        Text("Whishlist",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Color(
                                                                    0xfffab442)))
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ]))
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fish",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'RedRose',
                              fontWeight: FontWeight.bold)),
                      _buildDotsIndicatorfish(),
                    ],
                  )),
              Container(
                height: 360,
                child: Expanded(
                  child: Container(
                    height: 500,
                    child: Expanded(
                      child: PageView.builder(
                        controller: _pageControllerfish,
                        onPageChanged: onPageChangedfish,
                        itemCount: (totalItemsfish / itemsPerPagefish).ceil(),
                        itemBuilder: (BuildContext context, int index) {
                          int startIndex = index * itemsPerPagefish;
                          int endIndex = startIndex + itemsPerPagefish;
                          endIndex = endIndex < totalItemsfish
                              ? endIndex
                              : totalItemsfish;

                          List<Widget> pageItems = [];
                          for (int i = startIndex; i < endIndex; i++) {
                            pageItems.add(
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(9.91282844543457),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 20.0),
                                      child: Stack(
                                        children: [
                                          MouseRegion(
                                            onEnter: (_) {
                                              setState(() {
                                                hoveredIndex =
                                                    i; // Set the hovered index
                                              });
                                            },
                                            onExit: (_) {
                                              setState(() {
                                                hoveredIndex =
                                                    -1; // Reset when mouse exits
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        9.91282844543457),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Center(
                                                    child: Image.asset(
                                                      fish_list[i]["image"]!,
                                                      width: 205,
                                                      height: 205,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Container(
                                                          width: 197.0,
                                                          height: 24.0,
                                                          child: Text(
                                                            fish_list[i]
                                                                ["des"]!,
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
                                                                color: Color(
                                                                    0xff717171),
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 9,
                                                              ),
                                                            ),
                                                            Text(
                                                              fish_list[i]
                                                                  ["mrp"]!,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff717171),
                                                                decoration:
                                                                    TextDecoration
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
                                                              fish_list[i]
                                                                  ["price"]!,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              "(${fish_list[i]["price"]} / g)",
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
                                                          children: [
                                                            Text(
                                                              "(inclusive of all taxes)",
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 20.0),
                                                            Text(
                                                              "You Save: 31% OFF",
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                color: Color(
                                                                    0xff00B312),
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
                                          ),
                                          if (hoveredIndex == i)
                                            Positioned(
                                              left: 180.0,
                                              top: 10.0,
                                              child: Container(
                                                width: 21,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.5),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 8.0),
                                                    Image.asset(
                                                        "images/Heart (1).png"),
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
                                          if (hoveredIndex == i)
                                            Positioned(
                                              left: 70.5,
                                              top: 170.0,
                                              child: InkWell(
                                                onTap: () {
                                                  showProductDetailDialog(
                                                      context);

                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageRouteBuilder(
                                                  //     pageBuilder: (BuildContext
                                                  //             context,
                                                  //         Animation<double>
                                                  //             animation,
                                                  //         Animation<double>
                                                  //             secondaryAnimation) {
                                                  //       return FadeTransition(
                                                  //         opacity: animation,
                                                  //         child:
                                                  //             ProductDetail(),
                                                  //       );
                                                  //     },
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  width: 81,
                                                  height: 21.999996185302734,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.5),
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
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: pageItems),
                          );
                        },
                      ),
                    ),
                  ),
                  // Adjust the spacing between the two containers
                ),
              ),
              SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Salmon",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    _buildDotsIndicatorfish1(),
                  ],
                ),
              ),
              Container(
                height: 360,
                child: Expanded(
                  child: Container(
                    height: 500,
                    child: Expanded(
                      child: PageView.builder(
                        controller: _pageControllerfish1,
                        onPageChanged: onPageChangedfish1,
                        itemCount: (totalItemsfish1 / itemsPerPagefish1).ceil(),
                        itemBuilder: (BuildContext context, int index) {
                          int startIndex = index * itemsPerPagefish1;
                          int endIndex = startIndex + itemsPerPagefish1;
                          endIndex = endIndex < totalItemsfish1
                              ? endIndex
                              : totalItemsfish1;

                          List<Widget> pageItems = [];
                          for (int i = startIndex; i < endIndex; i++) {
                            pageItems.add(
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(9.91282844543457),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 20.0),
                                      child: Stack(
                                        children: [
                                          MouseRegion(
                                            onEnter: (_) {
                                              setState(() {
                                                hoveredIndex1 =
                                                    i; // Set the hovered index
                                              });
                                            },
                                            onExit: (_) {
                                              setState(() {
                                                hoveredIndex1 =
                                                    -2; // Reset when mouse exits
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        9.91282844543457),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Center(
                                                    child: Image.asset(
                                                      fish_list[i]["image"]!,
                                                      width: 205,
                                                      height: 205,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Container(
                                                          width: 197.0,
                                                          height: 24.0,
                                                          child: Text(
                                                            fish_list[i]
                                                                ["des"]!,
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
                                                                color: Color(
                                                                    0xff717171),
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 9,
                                                              ),
                                                            ),
                                                            Text(
                                                              fish_list[i]
                                                                  ["mrp"]!,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff717171),
                                                                decoration:
                                                                    TextDecoration
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
                                                              fish_list[i]
                                                                  ["price"]!,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              "(${fish_list[i]["price"]} / g)",
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
                                                            SizedBox(
                                                                width: 20.0),
                                                            Text(
                                                              "You Save: 31% OFF",
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                color: Color(
                                                                    0xff00B312),
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
                                          ),
                                          if (hoveredIndex1 == i)
                                            Positioned(
                                              left: 180.0,
                                              top: 10.0,
                                              child: Container(
                                                width: 21,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.5),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 8.0),
                                                    Image.asset(
                                                        "images/Heart (1).png"),
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
                                          if (hoveredIndex1 == i)
                                            Positioned(
                                              left: 70.5,
                                              top: 170.0,
                                              child: InkWell(
                                                onTap: () {
                                                  showProductDetailDialog(
                                                      context);

                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageRouteBuilder(
                                                  //     pageBuilder: (BuildContext
                                                  //             context,
                                                  //         Animation<double>
                                                  //             animation,
                                                  //         Animation<double>
                                                  //             secondaryAnimation) {
                                                  //       return FadeTransition(
                                                  //         opacity: animation,
                                                  //         child:
                                                  //             ProductDetail(),
                                                  //       );
                                                  //     },
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  width: 81,
                                                  height: 21.999996185302734,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.5),
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
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: pageItems),
                          );
                        },
                      ),
                    ),
                  ),
                  // Adjust the spacing between the two containers
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: screenSize.width,
                height: 350,
                decoration: BoxDecoration(color: Color(0xe5ef8f21)),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("KK BAZAR",
                              style: TextStyle(
                                  fontSize: 30.61224365234375,
                                  color: Colors.white)),
                          Container(
                            width: 303.0,
                            height: 100.0,
                            child: Text(
                                "Lorem ipsum dolor sit amet consectetur. Volutpat suspendisse nulla elementum sed. Consectetur phasellus tortor pretium netus",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "images/Instagram.png",
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Image.asset(
                                "images/Whatsapp.png",
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Image.asset(
                                "images/Youtube.png",
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Image.asset(
                                "images/Twitter.png",
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              )),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text("About us",
                              style:
                              TextStyle(fontSize: 18, color: Colors.white)),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Delivery Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Privacy Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Term & Conditions",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Contact info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              )),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text("About us",
                              style:
                              TextStyle(fontSize: 18, color: Colors.white)),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Delivery Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Privacy Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Term & Conditions",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Contact info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 212.0,
                            height: 80.0,
                            child: Text(
                                "Lorem ipsum dolor sit amet consectetur. Volutpat suspendisse",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Email : kkbazar@gmail.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("www.kkbazar.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: 200,
                decoration: BoxDecoration(color: Color(0x21ef8f21)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                        "Our Store | Shippping | Payments | Checkout | Discount | Term & Condition | Policy Shipping",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    SizedBox(
                      height: 30.0,
                    ),
                    Image.asset(
                      "images/image 1.png",
                      width: 144,
                      height: 15.75,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("© 2022 copyrights reserved",
                        style: TextStyle(fontSize: 20, color: Colors.black))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget hideButton1() {
    return Container(
      width: 36,
      height: 15,
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

  Widget _buildDotsIndicatorfish() {
    int totalItemsfish = fish_list.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItemsfish / itemsPerPagefish).ceil(),
        (index2) {
          return InkWell(
            onTap: () {
              _pageControllerfish.animateToPage(
                index2,
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
              );
              onPageChangedfish(
                  index2); // Update currentPagemob when dot is tapped
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentPagefish == index2 ? Color(0xffEF8F21) : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDotsIndicatorfish1() {
    int totalItemsfish1 = fish_list.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (totalItemsfish1 / itemsPerPagefish1).ceil(),
        (index2) {
          return InkWell(
            onTap: () {
              _pageControllerfish1.animateToPage(
                index2,
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
              );
              onPageChangedfish(
                  index2); // Update currentPagemob when dot is tapped
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPagefish1 == index2
                    ? Color(0xffEF8F21)
                    : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
