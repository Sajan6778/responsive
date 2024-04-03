// import 'dart:html';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:responsive/pages/privacypolicy.dart';
import 'package:responsive/pages/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Aboutus.dart';
import 'Addressmanager.dart';
import 'addresstype.dart';
import 'constants.dart';
import 'dashboardpage.dart';
import 'deleteAccountPage.dart';
import 'editaddress.dart';
import 'editprofilepage.dart';
import 'faqpage.dart';
import 'newaddress_dialogbox.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';


class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 77.0),
      //   child: AppBar(
      //     automaticallyImplyLeading: false,
      //     backgroundColor: Colors.black,
      //     title: Padding(
      //       padding: const EdgeInsets.only(left: 50.0, top: 20.0),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Text("Order Tracking : ",
      //               style: TextStyle(fontSize: 20.0, color: Colors.white)),
      //           // ShaderMask(
      //           //   shaderCallback: (bounds) =>
      //           //       LinearGradient(colors: [Colors.white, Color(0xffD8D8D8)])
      //           //           .createShader(bounds),
      //           //   child:
      //           Text(
      //               "Take advantage of our time to save event | Satisfaction guaranteed * ",
      //               style: TextStyle(fontSize: 14.0, color: Colors.white)),
      //           // )
      //         ],
      //       ),
      //     ),
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 50.0, top: 20.0),
      //         child: IntrinsicHeight(
      //           child: Row(
      //             children: [
      //               TextButton(
      //                 onPressed: () {},
      //                 child: Text("Language",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 20,
      //                     )),
      //               ),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               Container(
      //                   height: 30,
      //                   color: Colors.white,
      //                   child: VerticalDivider(width: 2, color: Colors.white)),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               IconButton(
      //                   icon: const Icon(
      //                     Icons.location_on_outlined,
      //                     color: Colors.white,
      //                   ),
      //                   // tooltip: 'Show Snackbar',
      //                   onPressed: () {}),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               Container(
      //                   height: 30,
      //                   color: Colors.white,
      //                   child: VerticalDivider(width: 2, color: Colors.white)),
      //               SizedBox(
      //                 width: 14.0,
      //               ),
      //               TextButton(
      //                 onPressed: () {},
      //                 child: Text("Account",
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 20,
      //                     )),
      //               ),
      //               IconButton(
      //                   icon: const Icon(
      //                     Icons.person_outline,
      //                     color: Colors.white,
      //                   ),
      //                   // tooltip: 'Show Snackbar',
      //                   onPressed: () {}),
      //               SizedBox(
      //                 width: 50.0,
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: MyScrollableColumn(), // Assuming RegisterPage contains the widget
    );
  }
}

class MyScrollableColumn extends StatefulWidget {
  @override
  _MyScrollableColumnState createState() => _MyScrollableColumnState();
}

class _MyScrollableColumnState extends State<MyScrollableColumn> {
  Uint8List? imageFile;
  bool imageAvailable = false;

  final AddressManager addressManager = AddressManager();
  late bool _isobscured1 = true;
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    return Color(0x2bef8f21);
  }

  late List<dynamic> responseData = [];
  String user_name = '';
  String gender = '';
  String email_id = '';
  String date_of_birth = '';
  var number1 = '';
  var number2 = '';

  String user_names = '';
  int? userIdProfile;
  int? userProfileId;
  String userImageUrl = '';

  Future<void> getUserData() async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl + 'userDetailsById';

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
          responseData = jsonDecode(response.body);
          print('Data for User ID $userId: $responseData');

          for (var userData in responseData) {
            setState(() {
              user_name =
                  userData['userName'] ?? ''; // Use '' if 'userName' is null
              print("userName: $user_name");

              email_id =
                  userData['emailId'] ?? ''; // Use '' if 'emailId' is null
              print("emailId: $email_id");

              gender = userData['gender'] ?? ''; // Use '' if 'gender' is null
              print("gender: $gender");

              date_of_birth = userData['dateOfBirth'] ??
                  ''; // Use '' if 'dateOfBirth' is null
              print("dateOfBirth: $date_of_birth");

              number1 = userData['mobileNumber'].toString() ??
                  ''; // Use '' if 'mobileNumber' is null
              print("number1: $number1");

              number2 = userData['alternateMobileNumber'].toString() ??
                  ''; // Use '' if 'alternateMobileNumber' is null
              print("number2: $number2");
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

  late List<dynamic> responseAddress = [];
  late List<dynamic> responseProfile = [];
  // String user_name='';
  // String gender='';
  // String email_id='';
  // String date_of_birth='';
  // var number1;
  // var number2;

  List<String>? userStAdd = [];
  List<String>? userCity = [];
  List<String>? userState = [];
  List<String>? userCountry = [];
  List<dynamic>? userPostCode = [];
  List<dynamic>? userAddressId = [];

  Future<void> getUserAddress() async {
    int? userId = await getUserId();
    final String baseUrl = Constants.ipBaseUrl + 'userWithAddress';

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
          setState(() async {
            responseAddress = jsonDecode(response.body);
            print('Address for User ID $userId: $responseAddress');

            if (responseAddress.isNotEmpty) {
              List<String> streetAddressValue = [];
              List<String> cityValue = [];
              List<String> stateValue = [];
              List<String> countryValue = [];
              List<dynamic> postalCodeValue = [];
              List<dynamic> AddressIdValue = [];

              for (var Address in responseAddress) {
                String streetAddress = Address['streetAddress'] ?? '';
                String city = Address['city'] ?? '';
                String state = Address['state'] ?? '';
                String country = Address['country'] ?? '';
                var postalCode = Address['postalCode'].toString() ?? '';
                print("postalCode:$postalCode");
                final AddressId = Address['userAddressId'];
                print("AddressId:$AddressId");

                //
                // if (AddressId != null && (AddressId is int || AddressId is String)) {
                //
                //   final parsedAddressId = (AddressId is int) ? AddressId : int.tryParse(AddressId);
                //
                //   if (parsedAddressId != null) {
                //
                //     print('AddressId: $parsedAddressId');
                //
                //
                //     await saveAddressId(parsedAddressId);
                //
                //   }
                //   else {
                //     print('Invalid or missing Address ID in the response');
                //   }
                // } else {
                //   print('Invalid or missing Address ID in the response');
                // }

                streetAddressValue.add(streetAddress);
                cityValue.add(city);
                stateValue.add(state);
                countryValue.add(country);
                postalCodeValue.add(postalCode);
                AddressIdValue.add(AddressId);
              }
              setState(() {
                userStAdd = streetAddressValue;
                print("userStAdd: $userStAdd");
                userCity = cityValue;
                print("userCity: $userCity");
                userState = stateValue;
                print("userState: $userState");

                userCountry = countryValue;
                print("userCountry: $userCountry");

                userPostCode = postalCodeValue;
                print("userPostCode: $userPostCode");

                userAddressId = AddressIdValue;
                print("userAddressId: $userAddressId");
              });
            }
          });
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    _initData();
    getUserProfileDetails();
  }

  final AuthService authService = AuthService();

  Future<void> _initData() async {
    await addressManager.updateAddresses();

    retrieveValuesFromSharedPreferences();
  }

  // Future<void> uploadImageToBackend() async {
  //   // print("imageFile:$imageFile");
  //   try {
  //     String apiUrl = 'http://192.168.29.106:8081/userProfile/edit/1';
  //
  //     FormData formData = FormData.fromMap({
  //       'profile': await MultipartFile.fromBytes(
  //         imageFile,
  //       ),
  //     });
  //
  //     Dio dio = Dio();
  //
  //     Response response = await dio.put(apiUrl, data: formData);
  //
  //     if (response.statusCode == 200) {
  //       print('Image uploaded successfully');
  //       getUserProfileDetails();
  //     } else {
  //       print('Failed to upload image. Status code: ${response.statusCode}');
  //       print('Response data: ${response.data}');
  //     }
  //   } catch (error) {
  //     print('Error uploading image: $error');
  //   }
  // }

  // Future<void> upload(Uint8List img, VoidCallback onSuccess) async {
  //   print(img);
  //   var uri = Uri.parse(Constants.ipBaseUrl + 'userProfile/edit/1');
  //
  //   var request = http.MultipartRequest("PUT", uri);
  //   request.files.add(
  //     http.MultipartFile.fromBytes(
  //       "profile",
  //       img,
  //       filename: "image.jpeg",
  //       contentType: MediaType("image", "jpeg"),
  //     ),
  //   );
  //
  //   try {
  //     var response = await request.send();
  //     print(response.statusCode);
  //     response.stream.transform(utf8.decoder).listen((value) {
  //       print(value);
  //     });
  //
  //     // Invoke the callback on success
  //     onSuccess();
  //   } catch (error) {
  //     print('Error uploading image: $error');
  //   }
  // }

  Future<void> upload(Uint8List img, VoidCallback onSuccess) async {
    print(img);
    var uri =
        Uri.parse(Constants.ipBaseUrl + 'userProfile/edit/$userProfileId');

    var request = http.MultipartRequest("PUT", uri);
    request.files.add(
      http.MultipartFile.fromBytes(
        "profile",
        img,
        filename: "image.jpeg",
        contentType: MediaType("image", "jpeg"),
      ),
    );

    try {
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      if (response.statusCode == 200) {
        onSuccess();
        await getUserProfileDetails();
      } else {
        print('Image upload failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> getUserProfileDetails() async {
    int? userId = await getUserId();
    print("user Id:$userId");
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
              userImageUrl = userData['userProfileImageUrl'] ??
                  ''; // Use '' if 'userName' is null
              print("userImageUrl: $userImageUrl");

              userProfileId =
                  userData['userProfileId']; // Use '' if 'emailId' is null
              print("userProfileId: $userProfileId");

              user_names =
                  userData['userName'] ?? ''; // Use '' if 'emailId' is null
              print("user_names: $user_names");

              userIdProfile = userData['userId']; // Use '' if 'emailId' is null
              print("userIdProfile: $userIdProfile");
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
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Other widgets in the Column
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Widgets that might overflow and need scrolling
                Container(
                  width: screenSize.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 30.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardPage()),
                                );
                              },
                              child: Image.asset(
                                "images/image 46.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(
                              width: 1020.0,
                            ),
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
                            Text("profile",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black)),
                          ],
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        height: 220,
                        decoration: BoxDecoration(color: Color(0x0c9c271b)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              // _pickedImage == null
                              //     ? CircleAvatar(
                              //         radius: 130.37930297851562,
                              //         backgroundImage: AssetImage(
                              //           "images/profile.png",
                              //         ),
                              //       )
                              //     : Image.memory(webImage, fit: BoxFit.fill),

                              //     "images/profile.png",
                              //   ),
                              // webImage != null
                              //     ? Image.memory(
                              //         webImage!,
                              //         width: 200,
                              //         height: 200,
                              //         fit: BoxFit.cover,
                              //       )
                              //     : Text('No image selected'),
                              CircleAvatar(
                                radius: 130.37930297851562,
                                backgroundImage: NetworkImage(
                                    Constants.ipBaseUrl + userImageUrl),
                                child: (userImageUrl != null &&
                                        userImageUrl.isNotEmpty)
                                    ? null // No child if NetworkImage is available
                                    : Image.asset(
                                        'images/pic.png'), // Fallback AssetImage
                              ),

                              // CircleAvatar(
                              //   radius: 130.37930297851562,
                              //   backgroundImage: imageAvailable
                              //       ?  MemoryImage(imageFile!)
                              //       : NetworkImage(Constants.ipBaseUrl + userImageUrl),
                              // ),

                              SizedBox(width: 30.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user_names,
                                      style: TextStyle(
                                        fontSize: 28,
                                      )),
                                  SizedBox(height: 25.0),
                                  Row(
                                    children: [
                                      Text("user id : ",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                      Text(userIdProfile.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(height: 25.0),
                                  Container(
                                    width: 170,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(
                                            0xffEF8F21), // Background color
                                      ),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                        );

                                        if (result != null &&
                                            result.files.isNotEmpty) {
                                          Uint8List bytes =
                                              result.files.first.bytes!;
                                          print(
                                              'Image Bytes Length: ${bytes.length}'); // Add this line for debugging
                                          if (bytes.isNotEmpty) {
                                            await upload(bytes, () {
                                              setState(() {
                                                imageAvailable = true;
                                              });
                                            });
                                          } else {
                                            print('Selected file is empty');
                                          }
                                        } else {
                                          print('User did not pick an image');
                                        }
                                      },
                                      child: Text("Change Photo",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 420.0),
                              Image.asset(
                                "images/image 43.png",
                                width: 391,
                                height: 254.1904754638672,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 60.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Profile ",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  // SizedBox(width: 1080.0),
                                  // Container(
                                  //   width: 149,
                                  //   height: 56,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       primary: Color(
                                  //           0xffEF8F21), // Background color
                                  //     ),
                                  //     onPressed: () {
                                  //       // final postData = {
                                  //       //   'name': nameController.text.toString(),
                                  //       //   'email':
                                  //       //   emailController.text.toString(),
                                  //       //   'mobile_number':
                                  //       //   numberController.text.toString(),
                                  //       //   'password': _pass.text.toString()
                                  //       // };
                                  //       // apiController.postDataToApi(
                                  //       //     postData, context);
                                  //     },
                                  //     child: Text("edit profile",
                                  //         style: TextStyle(
                                  //           fontSize: 18,
                                  //         )),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Container(
                                width: screenSize.width,
                                height: 530,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0x2bef8f21)),
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("User Name",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),

                                          Text("Email Address",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text("Phone Number 1",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text("Phone Number 2",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text("Date of Birth",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text("Gender",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          // Text("Password",
                                          //     style: TextStyle(
                                          //       fontSize: 24,
                                          //       color: Colors.black,
                                          //     )),
                                        ],
                                      ),
                                      SizedBox(width: 170.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(":",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(":",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(":",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(":",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(":",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(":",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          // Text(":",
                                          //     style: TextStyle(
                                          //       fontSize: 24,
                                          //       color: Colors.black,
                                          //     )),
                                        ],
                                      ),
                                      SizedBox(width: 60.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(user_name,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(width: 500.0),
                                              Container(
                                                width: 230,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Color(
                                                        0xffEF8F21), // Background color
                                                  ),
                                                  onPressed: () {
                                                    showEditProfileDialog(
                                                        context);
                                                  },
                                                  child: Text("Edit Profile",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(email_id,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(number1,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(number2,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Text(date_of_birth,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                              )),
                                          Row(
                                            children: [
                                              Text(gender,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(width: 487.0),
                                              Container(
                                                width: 226,
                                                height: 33,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Color(
                                                        0xffEF8F21), // Background color
                                                  ),
                                                  onPressed: () {
                                                    showDeleteAccountDialog(
                                                        context);
                                                  },
                                                  child: Text("Delete account",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 60.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Address (Shipping and Billing) ",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  InkWell(
                                    onTap: () {
                                      showNewAddressDialog(context);
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text("Edit Address",
                                              style: TextStyle(
                                                fontSize: 24,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add_circle)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Container(
                                width: screenSize.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 50.0),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Zip/Postal Code",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.black)),
                                                  SizedBox(height: 20.0),
                                                  Container(
                                                    width: 356,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Color(0x2bef8f21)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 20.0),
                                                      child: Text(
                                                          userPostCode?.isNotEmpty ==
                                                                  true
                                                              ? userPostCode![0]
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 300.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Address",
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Container(
                                                    width: 356,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Color(0x2bef8f21)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 20.0),
                                                      child: Text(
                                                          userStAdd?.isNotEmpty ==
                                                                  true
                                                              ? userStAdd![0]
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 30.0),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Locality / Town*",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.black)),
                                                  SizedBox(height: 20.0),
                                                  Container(
                                                    width: 356,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Color(0x2bef8f21)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 20.0),
                                                      child: Text(
                                                          userCity?.isNotEmpty ==
                                                                  true
                                                              ? userCity![0]
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 300.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Country",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.black)),
                                                  SizedBox(height: 20.0),
                                                  Container(
                                                    width: 356,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Color(0x2bef8f21)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 20.0),
                                                      child: Text(
                                                          userCountry?.isNotEmpty ==
                                                                  true
                                                              ? userCountry![0]
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 30.0),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("State/Province",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.black)),
                                                  SizedBox(height: 20.0),
                                                  Container(
                                                    width: 356,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Color(0x2bef8f21)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 20.0),
                                                      child: Text(
                                                          userState?.isNotEmpty ==
                                                                  true
                                                              ? userState![0]
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 300.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Save address as",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.black)),
                                                  SizedBox(height: 20.0),

                                                  Row(
                                                    children: [
                                                      Consumer<AddressManager>(
                                                        builder: (context,
                                                            addressManager, _) {
                                                          return Radio(
                                                            value: AddressType
                                                                .home,
                                                            groupValue:
                                                                addressManager
                                                                    .selectedAddressType,
                                                            onChanged:
                                                                (AddressType?
                                                                    value) async {
                                                              addressManager
                                                                      .selectedAddressType =
                                                                  AddressType
                                                                      .home;

                                                              try {
                                                                await addressManager
                                                                    .updateAddresses();
                                                                retrieveValuesFromSharedPreferences();
                                                              } catch (error) {
                                                                print(
                                                                    'Error updating addresses: $error');
                                                              }
                                                            },
                                                            activeColor:
                                                                Colors.green,
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        "Home Address",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),

                                                  // Row(
                                                  //   children: [
                                                  //     Consumer<AddressManager>(
                                                  //       builder: (context, addressManager, _) {
                                                  //         return Radio(
                                                  //           value: AddressType.work,
                                                  //           groupValue: addressManager.selectedAddressType,
                                                  //           onChanged: (AddressType? value) async {
                                                  //             addressManager.selectedAddressType = AddressType.work;
                                                  //
                                                  //             try {
                                                  //               await addressManager.updateAddresses();
                                                  //               retrieveValuesFromSharedPreferences();
                                                  //             } catch (error) {
                                                  //               print('Error updating addresses: $error');
                                                  //             }
                                                  //           },
                                                  //           activeColor: Colors.green,
                                                  //         );
                                                  //       },
                                                  //     ),
                                                  //
                                                  //     SizedBox(width: 10.0),
                                                  //     Text(
                                                  //       "Work Address",
                                                  //       style: TextStyle(fontSize: 17,
                                                  //           color: Colors.black),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: 30.0),
                                          // Row(
                                          //   children: [
                                          //     Align(
                                          //       alignment: Alignment.topLeft,
                                          //       child: Checkbox(
                                          //         checkColor: Color(0xffEF8F21),
                                          //         fillColor:
                                          //         MaterialStateProperty.resolveWith(
                                          //             getColor),
                                          //         value: isChecked,
                                          //         onChanged: (bool? value) {
                                          //           setState(() {
                                          //             isChecked = value!;
                                          //           });
                                          //         },
                                          //       ),
                                          //     ),
                                          //     SizedBox(width: 10.0),
                                          //     Text("Make this my default address",
                                          //         style: TextStyle(
                                          //             fontSize: 17, color: Colors.black)),
                                          //   ],
                                          // ),
                                          // SizedBox(height: 50.0),
                                          // InkWell(
                                          //   onTap: () {},
                                          //   child: Center(
                                          //     child: Container(
                                          //       width: 170,
                                          //       height: 40,
                                          //       decoration: BoxDecoration(
                                          //         borderRadius: BorderRadius.circular(
                                          //             12),
                                          //       ),
                                          //       child: ElevatedButton(
                                          //         style: ElevatedButton.styleFrom(
                                          //           primary: Color(
                                          //               0xffEF8F21), // Background color
                                          //         ),
                                          //         onPressed: () {
                                          //
                                          //         },
                                          //         child: Text("CONTINUE",
                                          //             style: TextStyle(
                                          //                 fontSize: 24,
                                          //                 color: Colors.white)),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Center(
                              child: Container(
                                width: 226,
                                height: 33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(0xffEF8F21), // Background color
                                  ),
                                  onPressed: () {
                                    _showMyDialog();
                                    // final postData = {
                                    //   'name': nameController.text.toString(),
                                    //   'email':
                                    //   emailController.text.toString(),
                                    //   'mobile_number':
                                    //   numberController.text.toString(),
                                    //   'password': _pass.text.toString()
                                    // };
                                    // apiController.postDataToApi(
                                    //     postData, context);
                                  },
                                  child: Text("Log out",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AboutUsPage()));
                                    },
                                    child: Text("About us",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  privacyPolicyPage()));
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
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => faqPage()));
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Add more widgets as needed
              ],
            ),
          ),
        ),
        // Other widgets after the scrollable content
      ],
    ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout'),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
                await authService.logout();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 226,
              height: 33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffEF8F21), // Background color
                ),
                onPressed: () {
                  // _pickImage();

                  // final postData = {
                  //   'name': nameController.text.toString(),
                  //   'email':
                  //   emailController.text.toString(),
                  //   'mobile_number':
                  //   numberController.text.toString(),
                  //   'password': _pass.text.toString()
                  // };
                  // apiController.postDataToApi(
                  //     postData, context);
                },
                child: Text("Choose an image",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ),
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          //   TextButton.icon(
          //     icon: Icon(Icons.camera),
          //     onPressed: () {
          //       takePhoto(ImageSource.camera);
          //     },
          //     label: Text(
          //       "Camera",
          //       style: TextStyle(
          //         fontSize: 20.0,
          //       ),
          //     ),
          //   ),
          //   TextButton.icon(
          //     icon: Icon(Icons.image),
          //     onPressed: () {
          //       takePhoto(ImageSource.gallery);
          //     },
          //     label: Text(
          //       "Gallery",
          //       style: TextStyle(
          //         fontSize: 20.0,
          //       ),
          //     ),
          //   )
          // ])
        ],
      ),
    );
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  void retrieveValuesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Retrieve streetAddressValue
      userStAdd = prefs.getStringList('userStAdd')!;

      // Retrieve cityValue
      userCity = prefs.getStringList('userCity');

      // Retrieve stateValue
      userState = prefs.getStringList('userState');

      // Retrieve countryValue
      userCountry = prefs.getStringList('userCountry');

      // Retrieve postalCodeValue
      userPostCode = prefs.getStringList('userPostCode');

      // Retrieve addressIdValue
      userAddressId = prefs.getStringList('userAddressId');
      if (userStAdd != null) {
        print('userStAdd: $userStAdd');
      }

      if (userCity != null) {
        print('userCity___: $userCity');
      }

      if (userState != null) {
        print('userState___: $userState');
      }

      if (userCountry != null) {
        print('userCountry: $userCountry');
      }

      if (userPostCode != null) {
        print('userPostCode: $userPostCode');
      }

      if (userAddressId != null) {
        print('userAddressId: $userAddressId');
      }
    });
  }

  Future<void> saveAddressId(int AddressId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('AddressId', AddressId);
    print('saved AddressId: $AddressId');
  }

  // Future<File?> _pickImage() async {
  //   if (kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     File? selected;
  //     if (image != null && image.path != null) {
  //       selected = image.path as File?;
  //       setState(() {
  //         _pickedImage = selected;
  //       });
  //     }
  //   } else if (kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     File? selected;
  //     if (image != null && image.path != null) {
  //       var f = await image.readAsBytes();
  //       setState(() {
  //         webImage = f;
  //         print(webImage);
  //       });
  //     }
  //   } else {
  //     print("No image has been picked");
  //   }
  // }
}
