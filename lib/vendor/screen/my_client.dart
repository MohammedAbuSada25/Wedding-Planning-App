import 'package:flutter/material.dart';
import '../../screen_final/firebase/componante.dart';
import '../../screen_final/shared_pref/shared_pref_componants.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyClient extends StatefulWidget {
  @override
  State<MyClient> createState() => _MyClientState();
}

class _MyClientState extends State<MyClient> {

  static const url =
      "https://wedding-planning-58319-default-rtdb.firebaseio.com/Reservation.json";

  String username = SharedPrefController().getStringData(key: "username");
  List<Map<String,String>> myClients =[];
  bool condition = false;

  @override
  void initState() {
    getMyClients();

   // print(username);
  }

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
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "عملائي",
              style: KTextStyle.headerTextStyle,
            ),
            centerTitle: true,
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
                  builder: (context) => myClients.isEmpty ? noData() : isData(),
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
        itemCount: myClients.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 8/5,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => buildItem(context, myClients[index])
    ),
  );

  Widget noData() => const Center(
    child: Text(
      "There are no Data",
      style: TextStyle(
        fontSize: 24,
        color: AppColors.blue,
      ),),);

  Widget buildItem(context,Map model)=> Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff827397),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(right: 10, top: 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const Text("اسم العميل",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          const SizedBox(width: 10,),
                          Text(model['nameUser'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("رقم العميل",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          SizedBox(width: 10,),
                          Text(model['phone'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("اسم الخدمة",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(model['name'],
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        ],),
                      Row(
                        children: [
                          const Text("موعد الحجز",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(model['date'],
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        ],),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ));

  Future<void> getMyClients() async {
    bool x = false;
    await getReservationsData(url, username).then((value) {
      myClients = value;

      //print(value);
      //  print(category);
      //  print(city);

      x = true;
    });
    //print(service);
    setState(() {
      condition = x ;
    });

  }


}
