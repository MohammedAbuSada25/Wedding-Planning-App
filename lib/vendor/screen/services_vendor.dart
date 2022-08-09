import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:weddingappusers/screen_final/welcomescreen/welcomescreen.dart';
import 'package:weddingappusers/vendor/screen/my_client.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgetcompount/widgetcompount.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'details_screen.dart';

class ServicesVendor extends StatefulWidget {

  @override
  State<ServicesVendor> createState() => _ServicesVendorState();
}

class _ServicesVendorState extends State<ServicesVendor> {



  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Services.json";
  late List list;
  List<Map<String,String>> service =[];
  bool condition = false;

  @override
  void initState() {
    getService();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                title: const Text("خدماتي", style: KTextStyle.headerTextStyle,),
                centerTitle: true,
                leading: IconButton(onPressed: (){
                  _showMyDialog();
                }, icon: const Icon(Icons.exit_to_app)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.07,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: AppColors.whiteshade,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: ConditionalBuilder(
                      condition: condition,
                      builder: (context) => service.isEmpty ? noData() : isData(),
                      fallback: (context)=>const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget isData() => Container(
    margin: const EdgeInsets.all(15),
    child: GridView.builder(
        itemCount: service.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 8/5,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => buildItem(context, service[index])
    ),
  );
  Widget noData() => const Center(
    child: Text(
      "There are no Data",
      style: TextStyle(
        fontSize: 24,
        color: AppColors.blue,
      ),),);

  Widget buildItem(context,Map model)=> Center(child:
  Container(
    decoration: BoxDecoration(
      color: const Color(0xff827397),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: 10,
              top: 8
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: GestureDetector(
                      onTap: () {
                        navigateTo(context,DetailsScreen());
                        },
                      child: Image.network(
                        model['image'],
                        height: 220,
                        width: 140,
                      )
                  )
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("  اسم الخدمة",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
                  const SizedBox(
                height: 15,
              ),
                  Text(model['name'],
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ],
          )
            ],
          ),
        )
      ],
    ),
  )
  );

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الخروج'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  const <Widget>[
                Text('هل تريد بالتأكيد تسجيل الخروج'),


              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('نعم'),
              onPressed: () {
              //  navigateReplacement(context, WelcomeScreen());
                SharedPrefController().removeData("username");
                snackBar(context, "تم تسجيل الخروج، شكرا لاستخدامك التطبيق", Colors.grey);
                navigateTo(context,WelcomeScreen());

              },
            ),
            TextButton(
              child: const Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String username = SharedPrefController().getStringData(key: "username");
  Future<void> getService() async {
    bool x = false;
    await getVendorServiceData(url, username).then((value) {
      service = value;
      x = true;
    });
    //print(service);
    setState(() {
      condition = x ;
    });

  }

}



