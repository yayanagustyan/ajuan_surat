import 'package:dps/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'base/bottomNavigationBar/curved_navigation_bar.dart';
import 'common/assets_util.dart';
import 'common/global_widgets.dart';
import 'common/my_colors.dart';
import 'ui/account/profile_page.dart';
import 'ui/more/more_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 1;
  final GlobalKey _bottomNavigationKey = GlobalKey();
  bool hasNotif = false;

  final List<Widget> _children = [
    const ProfilePage(),
    const HomePage(),
    // const NotificationPage(),
    const MorePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _tabs() {
    List<Widget> ele = [];
    ele.add(Tab(child: _tabItem("Profil", AssetIcons.profile, 0)));
    ele.add(Tab(child: _tabItem("Beranda", AssetIcons.home, 1)));
    // ele.add(Tab(child: _tabItem("Notif", AssetIcons.notification, 2)));
    ele.add(Tab(child: _tabItem("More", AssetIcons.filter, 2)));
    return ele;
  }

  Widget _tabItem(String label, String icon, int index) {
    return Column(
      mainAxisAlignment:
          _page == index ? MainAxisAlignment.center : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Padding(
              padding: _page == index
                  ? const EdgeInsets.all(5.0)
                  : const EdgeInsets.all(0),
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.cover,
                height: _page == index ? 25 : 25,
                color: _page == index ? colorWhite : colorText,
              ),
            ),
            if (index == 2)
              Positioned(
                right: _page == index ? 5 : 0,
                top: _page == index ? 5 : 0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: hasNotif ? colorYellow : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
          ],
        ),
        if (_page != index)
          Text(
            label,
            style: const TextStyle(
              color: colorText,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: _tabs(),
          color: colorWhite,
          buttonBackgroundColor: colorPrimary,
          backgroundColor: colorWhiteBg,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
              if (index == 2) {}
            });
          },
        ),
        body: _children[_page],
      ),
      onWillPop: _onBackPressed,
    );
  }

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    CurvedNavigationBarState navBarState =
        _bottomNavigationKey.currentState as CurvedNavigationBarState;
    if (_page != 1) {
      navBarState.setPage(1);
      return Future.value(false);
    } else {
      if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        showToast(message: "Please click back again to exit", context: context);
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}
