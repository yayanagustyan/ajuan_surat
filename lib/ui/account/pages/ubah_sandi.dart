import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/constant.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/button_style.dart';

class UbahSandi extends StatefulWidget {
  const UbahSandi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UbahSandiState();
}

class _UbahSandiState extends State<UbahSandi> {
  String nim = "", oldPass = "";

  final _pass0 = TextEditingController();
  final _pass1 = TextEditingController();
  final _pass2 = TextEditingController();

  late Box<dynamic> s;
  getSession() async {
    s = await openSession();
    setState(() {
      nim = s.get("login_code");
      oldPass = s.get("login_pass");
    });
  }

  @override
  void initState() {
    getSession();
    super.initState();
  }

  updateUser() {
    removeFocus(context);
    showPDialog(context);

    if (_pass0.text.isEmpty || _pass1.text.isEmpty || _pass2.text.isEmpty) {
      showToast(message: "Data belum lengkap", context: context);
    } else {
      if (_pass0.text != oldPass) {
        hidePDialog();
        showToast(message: "Sandi Lama Anda tidak cocok", context: context);
      } else {
        if (_pass1.text != _pass2.text) {
          hidePDialog();
          showToast(
              message: "Knfirmasi Sandi Anda tidak cocok", context: context);
        } else {
          var data = {
            "sw_nim": nim,
            "sw_password": _pass2.text,
          };
          Provider.of<LoginProvider>(context, listen: false)
              .updateUser(jsonEncode(data))
              .then((value) {
            hidePDialog();
            wLogs(jsonEncode(value));
            if (value['code'] != 400) {
              s.put("login_pass", _pass2.text);
              showSuccessFailedDialog("ok", "Sandi Anda berhasil diperbaharui");
            } else {
              showSuccessFailedDialog("fail", value['message']);
            }
          });
        }
      }
    }
  }

  showSuccessFailedDialog(String type, String message) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(15),
            titlePadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(10),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type == "ok" ? "Berhasil!" : "Maaf!",
                      style: TextStyle(
                        fontSize: 16,
                        color: type == "ok" ? colorBlack100 : colorRed100,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        backStep(context);
                        backStep(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                divider(),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                type == "ok"
                    ? const Icon(
                        Icons.check_circle_outline,
                        size: 100,
                        color: colorPrimary,
                      )
                    : const Icon(
                        Icons.warning_amber,
                        size: 100,
                        color: colorYellow,
                      ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 15,
                      color: type == "ok" ? colorBlack100 : colorRed100,
                    ),
                  ),
                ),
                buttonSubmit(
                  text: "OK",
                  onPressed: () {
                    backStep(context);
                    backStep(context);
                  },
                  bheight: 35,
                  bwidth: double.infinity,
                  bradius: 5,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Ubah Sandi"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Silahkan Perbaharui Sandi Anda!"),
            roundedTextField(
                title: "Sandi Lama",
                controller: _pass0,
                inputType: InputType.password),
            roundedTextField(
                title: "Sandi Baru",
                controller: _pass1,
                inputType: InputType.password),
            roundedTextField(
                title: "Konfirmasi Sandi Baru",
                controller: _pass2,
                inputType: InputType.password),
            const SizedBox(height: 15),
            buttonSubmit(
              text: "Update",
              onPressed: () => updateUser(),
              bwidth: double.infinity,
              bradius: 5,
            ),
          ],
        ),
      ),
    );
  }
}
