
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/searchdetailspage.dart';
import 'package:responsive/pages/user_profile%20page.dart';
import 'package:http/http.dart' as http;
import 'package:responsive/pages/userprovider.dart';
import 'package:responsive/pages/wishlist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Aboutus.dart';
import 'Cartpage.dart';
import 'Login.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'dropdown_model.dart';
import 'newproductlist.dart';
import 'order_orderhistory.dart';

class faqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: MyScrollableColumn(), // Assuming RegisterPage contains the widget
    );
  }
}

List<String> list = <String>['All Categories', 'One', 'Two', 'Three', 'Four'];
List<String> list1 = <String>['All Department', 'One', 'Two', 'Three', 'Four'];

class MyScrollableColumn extends StatefulWidget {
  @override
  _MyScrollableColumnState createState() => _MyScrollableColumnState();
}

class _MyScrollableColumnState extends State<MyScrollableColumn> with WidgetsBindingObserver{
  String dropdownValue = list.first;
  String dropdownValues = list1.first;
  bool isChecked = false;

  String baseUrl = "http://192.168.29.43:8081";
  String baseUrl1 = "http://192.168.29.43:8081/";

  bool show1 = false;
  bool show2 = false;
  bool show3 = false;
  bool show4 = false;
  bool show5 = false;
  bool show6 = false;
  bool show7 = false;
  bool show8 = false;

  late List<dynamic> responseData=[];

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }


  void showToast() {
    Fluttertoast.showToast(
      msg: Message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      webBgColor: '#FF8911',
      timeInSecForIosWeb: 3,
      // backgroundColor: Color(0x2bef8f21),
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _initializeState();
  }

  final AuthService authService = AuthService();

  Future<void> _initializeState() async {
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      getUserProfileDetails();
    }

  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }




  String Message="";

  var selectedValue;
  late String search;
  TextEditingController searchController = TextEditingController();

  late List<dynamic> responseProfile=[];
  String userImageUrl='';

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

  Future<void> getUserProfileDetails() async {
    int? userId = await getUserId();
    print("this my user Id:$userId");
    final String baseUrl = Constants.ipBaseUrl + 'userProfileDetails';

    try {
      final url = Uri.parse('$baseUrl/$userId');

      try {
        final response = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          responseProfile = jsonDecode(response.body);
          print('ProfileData for User ID $userId: $responseProfile');

          for (var userData in responseProfile) {
            setState(() {
              userImageUrl = userData['userProfileImageUrl'] ?? ''; // Use '' if 'userName' is null
              print("userImageUrl: $userImageUrl");


            });
          }
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Expanded(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Other widgets in the Column
              Container(

                margin: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardPage()),
                        );
                      },
                      child: Image.asset(
                        "images/image 46.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            width: 300,
                            height: 51,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffD2D2D2)),
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50.0),
                              ),
                            ),
                            child: TextField(
                              controller: searchController,
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
                                onPressed: () {
                                  search=searchController.text.trim();
                                  print("search:$search");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SearchDetailsPage(searchText: search)),
                                  );
                                  // Reset the search query when navigating back
                                  setState(() {
                                    searchController.text = '';
                                  });
                                },
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
                          onTap: () async {
                            bool isAuthenticated = await authService.isAuthenticated();
                            if (isAuthenticated) {
                              getUserProfileDetails();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
                            }
                            else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            }
                          },
                          child: CircleAvatar(
                            radius: 30.0,

                            backgroundImage: NetworkImage(Constants.ipBaseUrl + userImageUrl),
                            child: (userImageUrl != null && userImageUrl.isNotEmpty)
                                ? null // No child if NetworkImage is available
                                : Image.asset('images/pic.png'),
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

              Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // height: 1800,
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Home",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black)),
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
                                Text("FAQs",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black)),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 400,
                                    width: 600,
                                    child: Center(
                                      child: Image(image: AssetImage("images/call-center.png"),width: 522.0,height: 325.0,),
                                    ))
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("How can we help you?",style: TextStyle(fontSize: 24.0,),),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Top FAQs",
                                        style: TextStyle(fontSize: 24.0,),
                                      )
                                    ]
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    width: 1057.0,
                                    // height: 1087.0,
                                    color: Color(0xffFAF4F3),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("How can I check my order status?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                    visible: show1==false
                                                   ? true
                                                   : false,
                                                      child: IconButton(onPressed: (){
                                                        setState(() {
                                                          show1=true;
                                                        });
                                                      }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                  visible: show1==true
                                                      ? true
                                                      : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show1=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: show1==true
                                            ? true
                                            : false,
                                              child: Container(
                                                width: 1000,
                                                  height: 50,
                                                child:Text("To check your order status on KK Bazar website,"
                                                    " log in to your account and navigate to the “Order Status” section. Enter your order History page and view the current status of your order",style: TextStyle(fontSize: 16.0)),
                                              ),
                    
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("How can I return/replace an item?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show2==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show2=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show2==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show2=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: show2==true
                                                ? true
                                                : false,
                                            child: Container(
                                              width: 1000,
                                              height: 50,
                                              child:Text("To initiate a return or replacement for an item purchased from KK Bazar, There is a option delivered in order history page from that you can place return after contact their customer support and follow their specific return or exchange process.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("How will my order be delivered?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show3==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show3=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show3==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show3=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible:show3==true
                                                ? true
                                                : false,
                                            child: Container(
                                              width: 1000,
                                              height: 40,
                                              child:Text("All orders are shipped by sellers through courier service providers who deliver the packages to your doorstep.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Can I take the shipment after opening and checking the contents inside?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show4==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show4=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show4==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show4=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                             visible: show4==true
                                              ? true
                                              : false,
                                            child: Container(
                                              width: 1000,
                                              height: 50,
                                              child:Text("As percompany policy, a shipment can't be opened before delivery, but you can accept the shipment "
                                                  "and get in touch with us later in case you have any concerns.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Do I need to verify my mobile number or email address every time I log in?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show5==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show5=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show5==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show5=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: show5==true
                                                ? true
                                                : false,
                                            child: Container(
                                              width: 1000,
                                              height: 40,
                                              child:Text("As the verification step is a onetime process, you won't have to do it again once your account is verified.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("I want to change the address for delivery of my order. Is it possible now?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show6==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show6=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show6==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show6=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: show6==true
                                                ? true
                                                : false,
                                            child: Container(
                                              width: 1000,
                                              height: 100,
                                              child:Text("You can't change the delivery address after placing the order.Kindly check the delivery address before placing the order.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Can I get my order delivered faster?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show7==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show7=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show7==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show7=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: show7==true
                                                ? true
                                                : false,
                                            child: Container(
                                              width: 1000,
                                              height: 100,
                                              child:Text("No, the delivery date you see after the order confirmation is provided is based on factors like your address, the seller's address and the time needed by couriers to process and ship your order. Due to these factors, they do not have the option to change the delivery date and have it reach you earlier.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("How do I return my order on KK Bazar?",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                              Stack(children: [
                                                Visibility(
                                                  visible: show8==false
                                                      ? true
                                                      : false,
                                                  child: IconButton(onPressed: (){
                                                    setState(() {
                                                      show8=true;
                                                    });
                                                  }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xffEF8F21),)),
                    
                                                ),
                                                Visibility(
                                                    visible: show8==true
                                                        ? true
                                                        : false,
                                                    child: IconButton(onPressed: (){
                                                      setState(() {
                                                        show8=false;
                                                      });
                                                    }, icon: Icon(Icons.keyboard_arrow_up_outlined,color: Color(0xffEF8F21),))
                                                )],)
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: show8==true
                                              ? true
                                              : false,
                                            child: Container(
                                              width: 1000,
                                              height: 100,
                                              child:Text("How do I return my order on KK Bazar? Place a return request in the Orders page. You will get an option to choose refund/replace/exchange as per our return policy.",style: TextStyle(fontSize: 16.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
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
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                                },
                                child: Text("About us",
                                    style:
                                    TextStyle(fontSize: 18, color: Colors.white)),
                              ),
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
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>privacyPolicyPage()));
                                },
                                child: Text("Privacy Policy",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                              ),
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
                              Text("phone: 9876543212",
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("Email: kkbazar@gmail.com",
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
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("Need Help?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  )),
                              SizedBox(
                                height: 20.0,
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>faqPage()));
                                },
                                child: Text("FAQ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("Contact Us",
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
                            style:
                            TextStyle(fontSize: 16, color: Colors.black)),
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

              // Other widgets after the scrollable content
            ],
          ),
        ),

      ),
    );
  }

  int _crossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 6; // Show 4 items in a row for larger screens
    } else if (screenWidth > 800) {
      return 4; // Show 4 items in a row for larger screens
    } else if (screenWidth > 600) {
      return 3; // Show 4 items in a row for larger screens
    } else {
      return 2; // Show 2 items in a row for smaller screens
    }
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

// void showToast() {
//   Fluttertoast.showToast(
//     msg: Message,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.TOP,
//     webBgColor: '#FF8911',
//     timeInSecForIosWeb: 3,
//     // backgroundColor: Color(0x2bef8f21),
//     textColor: Colors.white,
//     fontSize: 20.0,
//
//   );
// }
}
