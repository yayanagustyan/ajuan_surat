import 'package:dps/base/routes.dart';
import 'package:dps/common/assets_util.dart';
import 'package:dps/common/global_widgets.dart';
import 'package:dps/common/helper.dart';
import 'package:dps/common/my_behavior.dart';
import 'package:dps/common/my_colors.dart';
import 'package:dps/provider/auth/auth.dart';
import 'package:dps/ui/account/pages/ubah_sandi.dart';
import 'package:flutter/material.dart';

import 'pages/ubah_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nim = "",
      nama = "",
      jurusan = "",
      smester = "",
      tahun = "",
      ttl = "",
      phone = "",
      address = "";

  bool isProfile = true;

  getSession() async {
    var s = await openSession();
    setState(() {
      nim = s.get("login_code");
      nama = s.get("login_name");
      jurusan = s.get("login_jurusan");
      smester = s.get("login_smester");
      tahun = s.get("login_year");
      ttl = s.get("login_ttl");
      phone = s.get("login_phone");
      address = s.get("login_address");
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
      appBar: customAppBar(context, "Profil", leading: false),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => setState(() {
                              isProfile = !isProfile;
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Profil Saya",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          isProfile ? colorPrimary : colorText,
                                    ),
                                  ),
                                ),
                                isProfile
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: colorPrimary,
                                      )
                                    : const Icon(
                                        Icons.chevron_right,
                                        color: colorText,
                                      ),
                              ],
                            ),
                          ),
                          if (isProfile)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "NIM",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorText,
                                    ),
                                  ),
                                  Text(
                                    nim,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Nama",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorText,
                                    ),
                                  ),
                                  Text(
                                    nama,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "No. Telepon",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorText,
                                    ),
                                  ),
                                  Text(
                                    phone,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Tempat / Tanggal Lahir",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorText,
                                    ),
                                  ),
                                  Text(
                                    ttl,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Jurusan/Smester",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: colorText,
                                              ),
                                            ),
                                            Text(
                                              jurusan + "/" + smester,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Tahun",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: colorText,
                                              ),
                                            ),
                                            Text(
                                              tahun,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Alamat",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorText,
                                    ),
                                  ),
                                  Text(
                                    address,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          InkWell(
                            onTap: () => gotoPage(context, const UbahProfile())
                                .then((value) async {
                              wLogs(value);
                              getSession();
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Ubah Profil",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: colorText,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: colorText),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => gotoPage(context, const UbahSandi())
                                .then((value) async {
                              wLogs(value);
                              getSession();
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Ubah Sandi",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: colorText,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: colorText),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => Auth.instance.doLogout(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Keluar",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: colorText,
                                    ),
                                  ),
                                ),
                                Icon(Icons.logout, size: 20, color: colorText)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
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
