import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/assets_util.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/models/inbox_model.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'print_preview.dart';

class ListAllAjuan extends StatefulWidget {
  const ListAllAjuan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListAllAjuanState();
}

class _ListAllAjuanState extends State<ListAllAjuan> {
  List<InboxModel> surats = [];

  getData() async {
    var s = await openSession();
    var data = {"aju_nim": s.get("login_code")};
    showPDialog(context);
    Provider.of<LoginProvider>(context, listen: false)
        .getSurat(jsonEncode(data))
        .then((value) async {
      hidePDialog();
      wLogs(value);
      setState(() {
        surats = InboxModel.fromJsonList(value['data']);
      });
    });
  }

  saveToPdf(InboxModel mm) async {
    if (mm.ajuStatus == "acc") {
      PDFDocument doc = await PDFDocument.fromURL(mm.ajuFile);
      gotoPage(context, PrintPreview(document: doc, path: mm.ajuFile));
    } else {
      createPdf(mm);
    }
  }

  createPdf(InboxModel mm) {
    var data = {"aju_code": mm.ajuCode};
    Provider.of<LoginProvider>(context, listen: false)
        .printSurat(jsonEncode(data))
        .then((value) async {
      wLogs(value);
      PDFDocument doc =
          await PDFDocument.fromURL(value['data'][0]['file_path']);
      gotoPage(context,
          PrintPreview(document: doc, path: value['data'][0]['file_path']));
    });
  }

  Widget notFoundWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetIcons.iMessageG),
          const Text(
            "Belum ada data",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  _childrens() {
    List<Widget> ele = [];

    if (surats.isEmpty) {
      ele.add(Center(child: notFoundWidget()));
    }

    for (var item in surats) {
      ele.add(
        Card(
          elevation: 5,
          child: InkWell(
            onTap: () => saveToPdf(item),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateTimeFormat(item.ajuDatetime, "dd MMM y, HH:mm"),
                        style: const TextStyle(
                          fontSize: 12,
                          color: colorPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: item.ajuStatus == "acc"
                                ? colorPrimary
                                : item.ajuStatus == "reject"
                                    ? colorRed100
                                    : colorYellow,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item.ajuStatus == "acc"
                              ? "Disetujui"
                              : item.ajuStatus == "reject"
                                  ? "Ditolak"
                                  : item.ajuStatus,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 11,
                            color: (item.ajuStatus == "acc" ||
                                    item.ajuStatus == "batal")
                                ? colorPrimary
                                : item.ajuStatus == "reject"
                                    ? colorRed100
                                    : colorYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item.ajuTipe == "ajuan"
                        ? "Pengajuan " + item.ajuJenis
                        : "Pembatalan Ajuan",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.ajuAlasan,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: colorText,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Klik untuk melihat dokumen",
                      style: TextStyle(
                        fontSize: 10,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return ele;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Daftar Surat Pengajuan"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _childrens()),
          ),
        ),
      ),
    );
  }
}
