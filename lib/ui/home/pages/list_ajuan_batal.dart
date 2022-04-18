import 'dart:convert';

import 'package:dps/base/routes.dart';
import 'package:dps/common/assets_util.dart';
import 'package:dps/common/button_style.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/models/inbox_model.dart';
import 'package:dps/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ListBatalAjuan extends StatefulWidget {
  const ListBatalAjuan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListBatalAjuanState();
}

class _ListBatalAjuanState extends State<ListBatalAjuan> {
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

  showMenu(InboxModel item) {
    showModalBottomSheet(
      context: context,
      builder: (c) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Batalkan Ajuan Ini?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => backStep(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: buttonSubmit(
                      text: "Tidak",
                      onPressed: () => backStep(context),
                      bheight: 35,
                      bradius: 5,
                      backgroundColor: colorRed100,
                      sideColor: colorRed100,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: buttonSubmit(
                      text: "Ya",
                      onPressed: () => updateSurat(item),
                      bheight: 35,
                      bradius: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  updateSurat(InboxModel item) {
    backStep(context);
    var data = {
      "aju_id": item.ajuId,
      "aju_code": item.ajuCode,
      "aju_tipe": "batal",
      "aju_status": "pending"
    };
    Provider.of<LoginProvider>(context, listen: false)
        .updateSurat(jsonEncode(data))
        .then(
      (value) {
        wLogs(value);
        getData();
        showToast(
            message: "Ajuan sedang ditinjau untuk di setujui",
            context: context);
      },
    );
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
    } else {
      ele.add(const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          "Pilih surat yang ingin dibatalkan!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));

      for (var item in surats) {
        if (item.ajuStatus == "pending" && item.ajuTipe != "batal") {
          ele.add(
            Card(
              elevation: 5,
              child: InkWell(
                onTap: () => showMenu(item),
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
            ),
          );
        }
      }
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
      appBar: customAppBar(context, "Pembatalan Surat Pengajuan"),
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
