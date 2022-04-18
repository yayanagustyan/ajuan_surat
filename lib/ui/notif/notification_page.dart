import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/assets_util.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/models/inbox_model.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../common/helper.dart';
import '../../common/my_colors.dart';
import '../home/pages/print_preview.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  String loginCode = "";

  List<InboxModel> inboxs = [];
  List<InboxModel> outboxs = [];

  late Box<dynamic> s;
  getInbox() async {
    s = await openSession();
    setState(() {
      loginCode = s.get("login_code");
    });
    showPDialog(context);
    Provider.of<LoginProvider>(context, listen: false)
        .getInbox(jsonEncode({"nim": loginCode}))
        .then((value) {
      hidePDialog();
      setState(() {
        inboxs = InboxModel.fromJsonList(value['data']);
      });
    });
  }

  getOutbox() {
    showPDialog(context);
    Provider.of<LoginProvider>(context, listen: false)
        .getOutbox(jsonEncode({"nim": loginCode}))
        .then((value) {
      hidePDialog();
      setState(() {
        wLogs(value);
        outboxs = InboxModel.fromJsonList(value['data']);
      });
    });
  }

  @override
  void initState() {
    // _controller = TabController(vsync: this, length: 2);
    // _controller.addListener(() {
    //   wLogs(_controller.index);
    //   if (_controller.index == 0) {
    //     getInbox();
    //   } else {
    //     getOutbox();
    //   }
    // });
    // getInbox();
    super.initState();
  }

  notFoundWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AssetIcons.iMessageG),
        const Text(
          "Belum ada notifikasi untuk Anda",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  saveToPdf(InboxModel mm) {
    var data = {"nomor": mm.ajuCode};
    if (mm.ajuStatus == "acc") {
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
  }

  _children(String code) {
    List<Widget> ele = [];

    if (code == "ib") {
      if (inboxs.isEmpty) {
        ele.add(notFoundWidget());
      } else {
        for (var item in inboxs) {
          ele.add(Card(
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
                  ],
                ),
              ),
            ),
          ));
        }
      }
    } else {
      if (outboxs.isEmpty) {
        ele.add(notFoundWidget());
      } else {
        for (var item in outboxs) {
          ele.add(Card(
            elevation: 5,
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
                ],
              ),
            ),
          ));
        }
      }
    }
    ele.add(const SizedBox(height: 100));
    return ele;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Notifikasi", leading: false),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(child: notFoundWidget()),
      ),
    );
  }
}
