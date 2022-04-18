import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/button_style.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/models/inbox_model.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'print_preview.dart';

class PreviewAjuan extends StatefulWidget {
  final InboxModel model;
  const PreviewAjuan({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PreviewAjuanState();
}

class _PreviewAjuanState extends State<PreviewAjuan> {
  _rowItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(title),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              ": $content",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    InboxModel mm = widget.model;
    return Scaffold(
      appBar: customAppBar(context, "Rincian Surat Pengajuan"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rowItem("Jeni Surat", mm.ajuJenis),
                divider(),
                _rowItem("NIM", mm.ajuNim),
                _rowItem("Nama", mm.ajuNama),
                _rowItem("No HP", mm.ajuPhone),
                _rowItem("Email", mm.ajuEmail),
                _rowItem(
                    "Jurusan/Smester", mm.ajuJurusan + "/" + mm.ajuSmester),
                _rowItem("Tahun Akademik", mm.ajuTahun),
                _rowItem("Tanggal Pengajuan",
                    dateTimeFormat(mm.ajuDatetime, "dd-MM-yyyy")),
                _rowItem("Dosen PA", mm.ajuDosen),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text("Alasan"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    mm.ajuAlasan,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                divider(bottom: 10),
                buttonSubmit(
                  text: " Print",
                  onPressed: () => createPdf(mm),
                  bradius: 5,
                  bheight: 35,
                  fontSize: 14,
                  bwidth: double.infinity,
                  icon: const Icon(
                    Icons.print,
                    color: colorWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
