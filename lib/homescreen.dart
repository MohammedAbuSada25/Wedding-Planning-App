import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/cityscreen/cityscren.dart';
import 'package:weddingappusers/styles/colorsscreen.dart';

import 'widgetcompount/widgetcompount.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
           appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "الرئيسيية",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: WeddingColoer.textcolor,
                  fontSize: 25,
                ),),
                centerTitle: true,

            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: WeddingColoer.textcolor,
                  size: 30.0,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8857F),
                  ),
                  child: Text('محمد الشاعر'),
                ),
                ListTile(
                  title: const Text('الملف الشخصي'),

                  onTap: () {
                    Navigator.pop(context);
                  },


                ),

                ListTile(
                  title: const Text('تسجيل الخروج'),

                  onTap: () {
                    Navigator.pop(context);
                  },


                ),


              ],
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(20),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3/3,mainAxisSpacing: 20,crossAxisSpacing: 20),
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/venue.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, const CityScreen());
                           },
                        ),
                        const Text("قاعات",
                          style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent
                        ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/haircutting.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),

                        Text("كوافير",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                          ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/flowers.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),
                        Text("زهور",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                          ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/weddingdress.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),
                        Text("فستان",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                          ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/weddinginvitation2.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),
                        Text("بطاقات العرس",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                          ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/camera1.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),
                        Text("تصوير",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                          ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/justmarried.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),
                        Text("سيارة الزفة",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent
                        ),),
                      ],
                    )),
                Container(

                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/weddingsuit.png',color: Colors.amber,),
                          iconSize: 100,
                          onPressed: () {
                            navigateTo(context, CityScreen());
                          },
                        ),
                        Text("بدلة",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                          ),),
                      ],
                    )),



                      ],

            ),
          ),
        ));
  }
}
