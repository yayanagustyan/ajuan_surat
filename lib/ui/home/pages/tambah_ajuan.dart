import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/button_style.dart';
import 'package:dps/common/constant.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/models/inbox_model.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:dps/ui/home/pages/preview_ajuan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TambahAjuan extends StatefulWidget {
  const TambahAjuan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TambahAjuanState();
}

class _TambahAjuanState extends State<TambahAjuan> {
  final _cnim = TextEditingController();
  final _cnama = TextEditingController();
  final _cjurus = TextEditingController();
  final _csmester = TextEditingController();
  final _cdosen = TextEditingController();
  final _creason = TextEditingController();
  final _cemail = TextEditingController();
  final _cphone = TextEditingController();
  final _ctahun = TextEditingController();

  String _jenis = "Pilih Jenis";
  String tahun = "",
      nim = "",
      nama = "",
      jurusan = "",
      smester = "",
      phone = "",
      email = "";

  getSession() async {
    var s = await openSession();
    setState(() {
      tahun = s.get("login_year").toString();
      nim = s.get("login_code").toString();
      nama = s.get("login_name").toString();
      jurusan = s.get("login_jurusan").toString();
      smester = s.get("login_smester").toString();
      phone = s.get("login_phone").toString();
      email = s.get("login_email").toString();
    });
    _cnim.text = nim;
    _cnama.text = nama;
    _cjurus.text = jurusan;
    _csmester.text = smester;
    _cphone.text = phone;
    _cemail.text = email;
    _ctahun.text = tahun;
  }

  simpanData() async {
    removeFocus(context);
    var data = {
      "aju_jenis": _jenis,
      "aju_nim": _cnim.text,
      "aju_nama": _cnama.text,
      "aju_jurusan": _cjurus.text,
      "aju_smester": _csmester.text,
      "aju_tahun": _ctahun.text,
      "aju_dosen": _cdosen.text,
      "aju_alasan": _creason.text,
      "aju_phone": _cphone.text,
      "aju_email": _cemail.text,
      "aju_tipe": "ajuan",
      "aju_datetime": getCurrentDateTime(),
      "aju_status": "pending",
    };
    if (_jenis == "Pilih Jenis") {
      showToast(message: "Lengkapi data", context: context);
    } else {
      showPDialog(context);
      Provider.of<LoginProvider>(context, listen: false)
          .saveSurat(jsonEncode(data))
          .then((value) {
        hidePDialog();
        wLogs(jsonEncode(value));
        if (value['code'] == 200) {
          InboxModel ajuan = InboxModel.fromJson(value['data'][0]);
          gotoPageReplace(context, PreviewAjuan(model: ajuan));
        }
      });
    }
  }

  @override
  void initState() {
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Buat Surat Pengajuan"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                roundedDropDownField(
                  title: "Jenis Pengajuan",
                  value: _jenis,
                  items: [
                    const DropdownMenuItem(
                      value: "Pilih Jenis",
                      child:
                          Text("Pilih Jenis", style: TextStyle(fontSize: 14)),
                    ),
                    const DropdownMenuItem(
                      value: "Cuti Kuliah",
                      child:
                          Text("Cuti Kuliah", style: TextStyle(fontSize: 14)),
                    ),
                    const DropdownMenuItem(
                      value: "Pindah Kampus",
                      child:
                          Text("Pindah Kampus", style: TextStyle(fontSize: 14)),
                    ),
                    const DropdownMenuItem(
                      value: "Survey Lapangan",
                      child: Text("Survey Lapangan",
                          style: TextStyle(fontSize: 14)),
                    ),
                    const DropdownMenuItem(
                      value: "Aktif Kuliah",
                      child:
                          Text("Aktif Kuliah", style: TextStyle(fontSize: 14)),
                    ),
                  ],
                  onChanged: (v) {
                    wLogs(v);
                    setState(() {
                      _jenis = v!;
                    });
                  },
                ),
                divider(),
                roundedTextField(
                  title: "NIM",
                  controller: _cnim,
                  capital: InputCaps.char,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Nama",
                  controller: _cnama,
                  capital: InputCaps.words,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Jurusan",
                  controller: _cjurus,
                  capital: InputCaps.char,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Smester",
                  controller: _csmester,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Tahun Akademik",
                  controller: _ctahun,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "No HP",
                  controller: _cphone,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Email",
                  controller: _cemail,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Dosen PA",
                  controller: _cdosen,
                  capital: InputCaps.words,
                  unfocus: true,
                ),
                roundedTextField(
                  title: "Alasan",
                  hint: "Contoh : Alasan Cuti",
                  controller: _creason,
                  inputType: InputType.multiline,
                  unfocus: true,
                ),
                divider(bottom: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: buttonSubmit(
                        text: "Batal",
                        onPressed: () => backStep(context),
                        backgroundColor: colorRed100,
                        sideColor: colorRed100,
                        bradius: 5,
                        bheight: 35,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: buttonSubmit(
                        text: "Submit",
                        onPressed: () => simpanData(),
                        bradius: 5,
                        bheight: 35,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
