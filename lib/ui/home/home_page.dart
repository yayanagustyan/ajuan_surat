import 'package:dps/base/routes.dart';
import 'package:dps/common/assets_util.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/ui/home/pages/list_ajuan_all.dart';
import 'package:dps/ui/home/pages/list_ajuan_batal.dart';
import 'package:dps/ui/home/pages/tambah_ajuan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String loginCode = "", loginName = "";

  late Box<dynamic> session;
  _getSession() async {
    session = await openSession();
    setState(() {
      loginCode = session.get("login_code");
      loginName = session.get("login_name");
    });
  }

  @override
  void initState() {
    _getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: colorWhiteBg,
          body: Stack(
            children: [
              Container(
                height: 150,
                color: colorPrimary,
              ),
              Container(
                height: 170,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 0),
                decoration: const BoxDecoration(
                  color: colorPrimary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Selamat Datang!",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      getFirstSecondName(loginName),
                      style: const TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, 100, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, 210, 0),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 90,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () => gotoPage(
                                context,
                                const TambahAjuan(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 10,
                                        right: 50,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Buat Surat Pengajuan",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Membuat surat pengajuan cuti kuliah",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                        ),
                                        child: Container(
                                          height: 75,
                                          width: 90,
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                            top: 20,
                                            bottom: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorPrimary20,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(100),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            AssetIcons.message,
                                            color: colorPrimary,
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 90,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () =>
                                  gotoPage(context, const ListBatalAjuan()),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 10,
                                        right: 50,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Pembatalan Pengajuan",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "batalkan surat pengajuan cuti kuliah",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                        ),
                                        child: Container(
                                          height: 75,
                                          width: 90,
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                            top: 30,
                                            bottom: 10,
                                            right: 0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorBlue20,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(100),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            AssetIcons.master,
                                            color: colorBlue,
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 90,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () =>
                                  gotoPage(context, const ListAllAjuan()),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 10,
                                        right: 50,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Status Surat",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Melihat status pengajuan surat Anda",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                        ),
                                        child: Container(
                                          height: 75,
                                          width: 90,
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                            top: 20,
                                            bottom: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorYellow20,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(100),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            AssetIcons.search,
                                            color: colorYellow,
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 400),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
