import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/button_style.dart';
import 'package:dps/common/constant.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class UbahProfile extends StatefulWidget {
  const UbahProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UbahProfileState();
}

class _UbahProfileState extends State<UbahProfile> {
  String nim = "", nama = "", phone = "", address = "";

  final _nim = TextEditingController();
  final _nama = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  late Box<dynamic> s;
  getSession() async {
    s = await openSession();
    setState(() {
      nim = s.get("login_code");
      nama = s.get("login_name");
      phone = s.get("login_phone");
      address = s.get("login_address");

      _nim.text = nim;
      _nama.text = nama;
      _phone.text = phone;
      _address.text = address;
    });
  }

  updateUser() {
    removeFocus(context);
    showPDialog(context);
    var data = {
      "sw_nim": nim,
      "sw_phone": _phone.text,
      "sw_address": _address.text
    };
    Provider.of<LoginProvider>(context, listen: false)
        .updateUser(jsonEncode(data))
        .then((value) {
      hidePDialog();
      wLogs(jsonEncode(value));
      if (value['code'] != 400) {
        s.put("login_phone", _phone.text);
        s.put("login_address", _address.text);
        showSuccessFailedDialog("ok", "Data Anda berhasil diperbaharui");
      } else {
        showSuccessFailedDialog("fail", value['message']);
      }
    });
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
  void initState() {
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Ubah Profil"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Silahkan Perbaharui data Anda!"),
            roundedTextField(title: "NIM", controller: _nim, readOnly: true),
            roundedTextField(title: "Nama", controller: _nama, readOnly: true),
            roundedTextField(
              title: "No. Telepon",
              controller: _phone,
              textAction: InputAction.done,
              inputType: InputType.nums,
              numformat: false,
            ),
            roundedTextField(
              title: "Alamat",
              controller: _address,
              textAction: InputAction.done,
              inputType: InputType.multiline,
            ),
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
