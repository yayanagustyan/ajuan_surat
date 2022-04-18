import 'package:dps/base/routes.dart';
import 'package:dps/bottom_navbar.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/ui/account/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getLoginStatus() async {
    var session = await openSession();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      if (session.containsKey("login_status")) {
        if (session.get("login_status")) {
          gotoPageRemove(context, const BottomNavBar());
        } else {
          gotoPageRemove(context, const LoginPage(message: "auto"));
        }
      } else {
        gotoPageRemove(context, const LoginPage(message: "auto"));
      }
    });
  }

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png"),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
