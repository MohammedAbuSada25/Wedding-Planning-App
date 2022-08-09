import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import '../../styles/app_colors.dart';
import '../../vendor/login_vendor.dart';
import '../../widgetcompount/custom_button.dart';
import '../../widgetcompount/custom_header.dart';
import '../../widgetcompount/widgetcompount.dart';
import '../loginscreen/signin.dart';
import '../sginupscreen/signup.dart';

class WelcomeScreen extends StatelessWidget {
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),fixedSize: Size(300, 50), shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColors.blue,
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteshade,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 600,
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.10),
                            child: Image.asset("assets/images/Logo1.png",color:  AppColors.blue,),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          AuthButton(
                            onTap: () {
                              navigatePush(context, const Signin());
                            },
                            text: 'الدخول كمستخدم',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          AuthButton(
                            onTap: () {
                              navigateReplacement(context, LoginVendor());
                            },
                            text: 'الدخول كمزود ',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}