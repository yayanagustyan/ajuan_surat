import 'package:dps/ui/account/login_page.dart';
import 'package:flutter/material.dart';

import '../../common/config.dart';
import '../../common/helper.dart';

class Auth {
  static Auth instance = Auth();

  getToken() async {
    var login = await openSession();
    String token = login.get("login_token", defaultValue: "");
    return token;
  }

  getHeaders() async {
    var login = await openSession();
    String basicAuth = getBasicAuth();
    String token = login.get("login_token", defaultValue: "").toString();

    return {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
      'login_token': token,
      'Connection': 'keep-alive',
    };
  }

  doLogout(BuildContext context, {String? messages}) async {
    var login = await openSession();
    login.put("login_status", false);

    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage(message: messages)),
          (route) => false);
    });
  }
}
