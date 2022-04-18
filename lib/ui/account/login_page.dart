import 'package:dps/base/routes.dart';
import 'package:dps/common/config.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bottom_navbar.dart';
import '../../common/assets_util.dart';
import '../../common/button_style.dart';
import '../../common/global_widgets.dart';
import '../../common/helper.dart';
import '../../common/my_colors.dart';
import '../../provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  final String? message;
  const LoginPage({Key? key, this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _cEmail = TextEditingController();
  final _cPass = TextEditingController();

  final _fEmail = FocusNode();
  final _fPass = FocusNode();

  String response = "";
  String code = "";

  @override
  void initState() {
    super.initState();

    if (getEnvy() == "dev") {
      _cEmail.text = "M050402654";
      _cPass.text = "ahmad";
    }

    wLogs(widget.message);

    if (widget.message.toString() == "null") {
      Future.delayed(Duration.zero).then(
        (value) {
          showToast(
            message: "Sesi Anda berakhir, silahkan login kembali",
            context: context,
            alignment: TextAlign.center,
          );
        },
      );
    }
  }

  _doLogin() async {
    var email = _cEmail.text;
    var pass = _cPass.text;
    removeFocus(context);

    if (email.isEmpty || pass.isEmpty) {
      showSnackBar(context: context, message: "Data belum lengkap");
    } else {
      showPDialog(context);
      Provider.of<LoginProvider>(context, listen: false)
          .getDataUser(email, pass)
          .then((value) async {
        hidePDialog();
        var session = await openSession();

        setState(() {
          // response = value.toString();
          // code = value['code'].toString();
          if (value['code'] == 200) {
            if (value['data'].isEmpty) {
              showSnackBar(context: context, message: "Akun tidak ditemukan");
            } else {
              var data = value['data'][0];

              session.put("login_code", data['sw_nim'].toString());
              session.put("login_name", data['sw_name']);
              session.put("login_pass", data['sw_password']);
              session.put("login_jurusan", data['sw_jurusan']);
              session.put("login_smester", data['sw_smester'].toString());
              session.put("login_year", data['sw_year']);
              session.put("login_ttl", data['sw_ttl']);
              session.put("login_phone", data['sw_phone']);
              session.put("login_email", data['sw_email']);
              session.put("login_address", data['sw_address']);

              session.put("login_status", true);

              gotoPageRemove(context, const BottomNavBar());
            }
            wLogs(value.toString());
          } else {
            showToast(message: value['message'], context: context);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetImages.logo, height: 200),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: colorText),
                        children: [
                          TextSpan(text: "Silahkan masuk dengan akun "),
                          TextSpan(
                            text: "",
                            style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "Anda"),
                        ],
                      ),
                    ),
                  ),
                  roundedTextField(
                    prefixIcon:
                        const Icon(Icons.person_outline, color: colorText),
                    title: "NIM",
                    controller: _cEmail,
                    context: context,
                    focusNode: _fEmail,
                    nextFocus: _fPass,
                    inputType: TextInputType.text,
                  ),
                  roundedTextField(
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: colorText),
                    title: "Password",
                    controller: _cPass,
                    context: context,
                    focusNode: _fPass,
                    inputType: TextInputType.visiblePassword,
                    textAction: TextInputAction.done,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: buttonSubmit(
                        onPressed: () => _doLogin(), text: 'Masuk'),
                  ),
                  Text(response),
                  if (code == "200")
                    buttonSubmit(
                      text: "Lanjut",
                      onPressed: () {
                        gotoPage(context, const BottomNavBar());
                      },
                      bwidth: double.infinity,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
