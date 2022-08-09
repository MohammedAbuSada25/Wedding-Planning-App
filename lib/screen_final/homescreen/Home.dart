import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/cityscreen/cityscren.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/welcomescreen/welcomescreen.dart';

import '../../flutter_advanced_drawer.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgetcompount/widgetcompount.dart';
import '../reservations/reservations_screen.dart';
import '../shared_pref/shared_pref_componants.dart';

class Hommme extends StatefulWidget {
  @override
  State<Hommme> createState() => _HommmeState();
}

class _HommmeState extends State<Hommme> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: const Color(0xff827397),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,

      // openScale: 1.0,
      disabledGestures: false,
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/Logo1.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    navigatePush(context, Hommme());
                  },
                  leading: Icon(Icons.home),
                  title: Text('الرئيسية'),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProfileScreen()));
                  },
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('الملف الشخصي'),
                ),
                ListTile(
                  onTap: () {
                    navigateTo(context, const ReservationsScreen());
                  },
                  leading: Icon(Icons.edit_calendar_outlined ),
                  title: Text('الحجوزات'),
                ),
                ListTile(
                  onTap: () {
                    SharedPrefController().removeData("email");
                    navigateReplacement(context, WelcomeScreen());
                  },
                  leading: Icon(Icons.logout ),
                  title: Text('تسجيل الخروج'),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,

        body: SafeArea(
            child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue,
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // leading: Builder(builder: (BuildContext context) {
              //   return IconButton(
              //     icon: Icon(
              //       Icons.menu,
              //       color: WeddingColoer.textcolor,
              //       size: 30.0,
              //     ),
              //     onPressed: () => Scaffold.of(context).openDrawer(),
              //   );
              // }),
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              title: const Text(
                "الرئيسية",
                style: KTextStyle.headerTextStyle,
              ),
              centerTitle: true,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.07,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.whiteshade,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    children: [
                      widget_icon(
                          icon_name: "قاعات",
                          image: 'assets/images/venue.png',
                          sharedpref_value: "halls"),
                      widget_icon(
                          icon_name: "كوافير",
                          image: 'assets/images/haircutting.png',
                          sharedpref_value: 'hairdresser'),
                      widget_icon(
                          icon_name: "زهور وهدايا",
                          image: 'assets/images/flowers.png',
                          sharedpref_value: 'flowers'),
                      widget_icon(
                          icon_name: "فساتين",
                          image: 'assets/images/weddingdress.png',
                          sharedpref_value: 'dresses'),
                      widget_icon(
                          icon_name: "كروت أفراح",
                          image: 'assets/images/weddinginvitation2.png',
                          sharedpref_value: 'cards'),
                      widget_icon(
                          icon_name: "تصوير",
                          image: 'assets/images/camera1.png',
                          sharedpref_value: 'photos'),
                      widget_icon(
                          icon_name: "سيارة الزفة",
                          image: 'assets/images/justmarried.png',
                          sharedpref_value: 'cars'),
                      widget_icon(
                          icon_name: "بدلات",
                          image: 'assets/images/weddingsuit.png',
                          sharedpref_value: 'suits'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget widget_icon(
          {required String icon_name,
          required String image,
          required String sharedpref_value}) =>
      Container(
          decoration: BoxDecoration(
            color: const Color(0xff827397),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset(
                  image,
                  color: Colors.white,
                ),
                iconSize: 70,
                onPressed: () {
                  SharedPrefController()
                      .setStringData(key: "category", value: sharedpref_value);
                  navigateTo(context, const CityScreen());
                },
              ),
              Text(
                icon_name,
                style: KTextStyle.headerTextStyle1,
              ),
            ],
          ));

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
