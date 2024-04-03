import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/UserAddress.dart';
import 'addresstype.dart';
import 'constants.dart';

class AddressManager extends ChangeNotifier {
  List<UserAddress> _homeAddresses = [];
  List<UserAddress> _workAddresses = [];
  AddressType _selectedAddressType = AddressType.home;

  // AddressManager() : _selectedAddressType = null;

  AddressType get selectedAddressType => _selectedAddressType;

  set selectedAddressType(AddressType value) {
    _selectedAddressType = value;
    notifyListeners();
  }

  List<UserAddress> get addresses {
    return _selectedAddressType == AddressType.home
        ? _homeAddresses
        : _workAddresses;
  }

  late List<dynamic> responseAddress = [];

  List<String> userStAdd = [];
  List<String> userCity = [];
  List<String> userState = [];
  List<String> userCountry = [];
  List<String> userAddType = [];
  List<dynamic> userPostCode = [];
  List<dynamic> userAddressId = [];

  Future<void> updateAddresses() async {
    String? apiEndpoint;
    int? userId = await getUserId();

    if (_selectedAddressType == AddressType.home) {
      apiEndpoint = Constants.ipBaseUrl + 'userWithAddress/$userId/Home';
    } else if (_selectedAddressType == AddressType.work) {
      apiEndpoint = Constants.ipBaseUrl + 'userWithAddress/$userId/Work';
    }

    if (apiEndpoint != null) {
      try {
        final response = await http.get(Uri.parse(apiEndpoint));
        if (response.statusCode == 200) {
          processApiResponse(response.body);
          notifyListeners();
          ValuesInSharedPreferences();
        } else {
          print('API Call failed with status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error during API call: $error');
      }
    }
  }

  void processApiResponse(String responseBody) {
    responseAddress = jsonDecode(responseBody);
    print('Address for User ID: $responseAddress');

    if (responseAddress.isNotEmpty) {
      List<String> streetAddressValue = [];
      List<String> cityValue = [];
      List<String> stateValue = [];
      List<String> countryValue = [];
      List<String> addTypeValue = [];
      List<dynamic> postalCodeValue = [];
      List<dynamic> addressIdValue = [];

      for (var address in responseAddress) {
        String streetAddress = address['streetAddress'] ?? '';
        String city = address['city'] ?? '';
        String state = address['state'] ?? '';
        String country = address['country'] ?? '';
        String addressType = address['addressType'] ?? '';
        var postalCode = address['postalCode'].toString() ?? '';
        print("postalCode: $postalCode");
        final addressId = address['userAddressId'];
        print("AddressId: $addressId");

        streetAddressValue.add(streetAddress);
        cityValue.add(city);
        stateValue.add(state);
        countryValue.add(country);
        addTypeValue.add(addressType);
        postalCodeValue.add(postalCode);
        addressIdValue.add(addressId);
      }

      userStAdd = streetAddressValue;
      print("userStAdd: $userStAdd");

      userCity = cityValue;
      print("userCity: $userCity");

      userState = stateValue;
      print("userState: $userState");

      userCountry = countryValue;
      print("userCountry: $userCountry");

      userAddType = addTypeValue;
      print("userAddType: $userAddType");

      userPostCode = postalCodeValue;
      print("userPostCode: $userPostCode");
      userAddressId = addressIdValue;
      print("userAddressId: $userAddressId");
    }
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  void ValuesInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save streetAddressValue
    prefs.setStringList('userStAdd', userStAdd);

    // Save cityValue
    prefs.setStringList('userCity', userCity);

    // Save stateValue
    prefs.setStringList('userState', userState);

    // Save countryValue
    prefs.setStringList('userCountry', userCountry);

    prefs.setStringList('userAddType', userAddType);

    // Save postalCodeValue
    prefs.setStringList(
        'userPostCode', userPostCode.map((value) => value.toString()).toList());

    // Save addressIdValue
    prefs.setStringList('userAddressId',
        userAddressId.map((value) => value.toString()).toList());

    print('Values saved in SharedPreferences:$userAddType');
  }
}
