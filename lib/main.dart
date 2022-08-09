import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weddingappusers/admin/admin_screen.dart';
import 'package:weddingappusers/homescreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:weddingappusers/screen_final/splashscreen/splashscreen.dart';
import 'package:weddingappusers/vendor/screen/details_screen.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SharedPrefController().initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: DetailsScreen(),
    );
  }
}


