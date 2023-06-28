import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginInformation {
  Future readLoginInformation() async {
    var LoginInformation;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginInformation = prefs.getString("LoginInformation");

    if (LoginInformation != null) {
      return jsonDecode(LoginInformation);
    } else {
      return null;
    }
  }

  Future SetLoginInformation(LoginInformation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('LoginInformation', jsonEncode(LoginInformation));
  }

  Future HapusLoginInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.remove('LoginInformation');
    // await prefs.clear('LoginInformation');
  }
}
