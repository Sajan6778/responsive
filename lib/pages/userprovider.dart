import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
    bool oneValue = false;

    Future<void> login() async {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);

        oneValue = true;
    }

    Future<void> logout() async {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', false);


        oneValue = false;
    }


    Future<bool> isAuthenticated() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isLogin = prefs.getBool('isLogin') ?? false;
        return isLogin;
    }
}
