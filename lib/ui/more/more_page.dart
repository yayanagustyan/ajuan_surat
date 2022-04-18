import 'package:dps/common/assets_util.dart';
import 'package:dps/common/config.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String baseUrl = "";
  getData() {
    setState(() {
      baseUrl = getBaseUrl();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "More", leading: false),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 30),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    AssetImages.logo,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                "Sistem Aplikasi Pengajuan Surat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
