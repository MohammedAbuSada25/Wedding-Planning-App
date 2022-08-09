import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/services/Services.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';

import '../../widgetcompount/widgetcompount.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    String gaza ="https://pbs.twimg.com/media/DkwbiTDXcAM0Far.jpg";
    String khan ="https://upload.wikimedia.org/wikipedia/commons/b/b3/Khan_Yunis_panorama.jpg";
    String rafah ="https://modo3.com/thumbs/fit630x300/43045/1439457821/%D8%A3%D9%8A%D9%86_%D8%AA%D9%82%D8%B9_%D8%B1%D9%81%D8%AD.jpg";
    String dair ="https://palsawa.com/uploads/images/43e12f37ba1f0e47a415728e35359d3e.jpg";

    return Scaffold(

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
                title: Text("الموقع", style: KTextStyle.headerTextStyle,),
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height:200,
                              width: 400,
                              decoration: BoxDecoration(
                                color:Color(0xff827397),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // IconButton(
                                  //   icon: Image.network(gaza,fit: BoxFit.cover,height: 200,width: 400,),
                                  //   iconSize: 150,
                                  //   onPressed: () {
                                  //     SharedPrefController().setStringData(key: "city", value: "gaza");
                                  //     navigateTo(context, ServicesScreen());
                                  //   },
                                  // ),
                                    InkWell(
                                      child:   Image.network(gaza,fit: BoxFit.cover,height: 150,width: 350,),
                                      onTap: (){
                                        SharedPrefController().setStringData(key: "city", value: "gaza");
                                        navigateTo(context, ServicesScreen());
                                      },
                                    ),
                                  const Text("غزة",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height:200,
                              width: 400,
                              decoration: BoxDecoration(
                                color:Color(0xff827397),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                    InkWell(
                                      child:   Image.network(khan,fit: BoxFit.cover,height: 150,width: 350,),
                                      onTap: (){
                                        SharedPrefController().setStringData(key: "city", value: "khan");
                                        navigateTo(context, ServicesScreen());
                                      },
                                    ),
                                  const Text("خان يونس",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),),
                                ],
                              )),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height:200,
                              width: 400,
                              decoration: BoxDecoration(
                                color:Color(0xff827397),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  // IconButton(
                                  //   icon: Image.network(rafah,fit: BoxFit.cover,height: 200,width: 350,),
                                  //   iconSize: 150,
                                  //   onPressed: () {
                                  //     SharedPrefController().setStringData(key: "city", value: "rafah");
                                  //     navigateTo(context, ServicesScreen());
                                  //
                                  //   },
                                  // ),
                                  InkWell(
                                    child:   Image.network(rafah,fit: BoxFit.cover,height: 150,width: 350,),
                                    onTap: (){
                                      SharedPrefController().setStringData(key: "city", value: "rafah");
                                      navigateTo(context, ServicesScreen());
                                    },
                                  ),
                                  const Text("رفح",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height:200,
                              width: 400,
                              decoration: BoxDecoration(
                                color:Color(0xff827397),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // IconButton(
                                  //   icon: Image.network(dair,fit: BoxFit.cover,height: 200,width: 350,),
                                  //   iconSize: 150,
                                  //   onPressed: () {
                                  //     SharedPrefController().setStringData(key: "city", value: "dair");
                                  //     navigateTo(context, ServicesScreen());
                                  //   },
                                  // ),
                                  InkWell(
                                    child:   Image.network(dair,fit: BoxFit.cover,height: 150,width: 350,),
                                    onTap: (){
                                      SharedPrefController().setStringData(key: "city", value: "dair");
                                      navigateTo(context, ServicesScreen());
                                    },
                                  ),
                                  const Text("دير البلح",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),),
                                ],
                              )),
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

