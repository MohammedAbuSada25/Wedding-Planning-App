import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:weddingappusers/vendor/screen/add_service.dart';
import 'package:weddingappusers/vendor/screen/my_client.dart';
import 'package:weddingappusers/vendor/screen/profile_vendor.dart';
import 'package:weddingappusers/vendor/screen/services_vendor.dart';

import '../styles/app_colors.dart';


class HomeVendor extends StatefulWidget {

  @override
  State<HomeVendor> createState() => _HomeVendorState();
}

class _HomeVendorState extends State<HomeVendor> {
  int currentIndex = 1;
  List<Widget> screen = [
    ProfileVendor(),
    ServicesVendor(),
    AddService(),
    MyClient(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ConditionalBuilder(
        condition: true,
        builder: (context)=> screen[currentIndex],
        fallback: (context)=>const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "الملف الشخص"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.room_service,
              ),
              label: "خدماتي"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
              ),
              label: "اضافة خدمة"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              label: "عملائي"),
        ],
         fixedColor: AppColors.whiteshade,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 150,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        backgroundColor: AppColors.blue,
      ),
    );
  }


}
