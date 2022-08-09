import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/homescreen/Home.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:weddingappusers/vendor/home_screen_vendoe.dart';

 import '../../styles/app_colors.dart';
import '../welcomescreen/welcomescreen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  startTime() async{
    var duration=Duration(seconds: 5);
    return new Timer(duration, LoginRout);
  }

  LoginRout(){
    String email = SharedPrefController().getStringData(key: "email");
    String username = SharedPrefController().getStringData(key: "username");
    print(email);
    if(email.isEmpty || email == " " || username.isEmpty || username == " ") {
      navigateReplacement(context, WelcomeScreen());
    }else{
      if(email.isEmpty || email == " "){
        navigateReplacement(context, HomeVendor());
      }else {
        navigateReplacement(context, Hommme());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/Logo1.png",color:  AppColors.blue,),

            ],
          ),
        )),
    );  }
}
