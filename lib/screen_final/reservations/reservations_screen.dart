import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

 import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgetcompount/widgetcompount.dart';
import '../loungebooking/lounge_booking.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {

  static const url =
      "https://wedding-planning-58319-default-rtdb.firebaseio.com/Reservation.json";
  List<Map<String, String>> reservations = [];
  String email = SharedPrefController().getStringData(key: "email");
  bool condition = false;


  @override
  void initState() {
    getReservations();
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
                title: Text("حجوزاتي", style: KTextStyle.headerTextStyle,),
                centerTitle: true,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.07,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              builder: (context) => reservations.isEmpty ? noData() : isData(),
                              fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget isData() => Container(
    margin: EdgeInsets.all(15),
    child: GridView.builder(

        itemCount: reservations.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 8/5,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => buildItem(context, reservations[index])
          ),
  );
  Widget noData() => const Center(
    child: Text(
      "لا يوجد أي حجوزات",
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
      padding: const EdgeInsets.only(right: 10,top: 8),
      child: Row(
        children: [

          ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: GestureDetector(
                  onTap: () {
                    navigateTo(context, LoungeBooking());
                  },
                  child: Image.network(
                    model['image'],
                    height: 220,
                    width: 140,
                  )
              )
          )
          ,const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model["name"],
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text("الموقع",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    model["location"],
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("موعد الحجز",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    model["date"],
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ],),
              Padding(
                padding: const EdgeInsets.only(
                    right: 170,
                    top: 50),
                child:  Row(
                  children:
                  [
                    InkWell(
                      child:const Icon(Icons.delete,color: Colors.white,),
                      onTap: () {
                        _showMyDialog(model["name"], model["phone"]);
                        },
                    )
                  ],
                ),
              ),


            ],)],),
    )
      ],

    ),
   )
  );

  Future<void> _showMyDialog(String name,String phone) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text(' الهل تريد بالتأكيد حذف الحجز')
            ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('نعم'),
              onPressed: () {

                removeReservationsData(url,name, phone)
                    .then((value) {
                  setState(() {
                    navigateReplacement(context, const ReservationsScreen());
                    snackBar(context, "تم الحذف بنجاح", Colors.green);
                  });
                });

                Navigator.of(context).pop();
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


  Future<void> getReservations() async {
    bool x = false;
    await getReservationsData(url, email).then((value) {
      reservations = value;

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

  // List List2=[
  //   Reservatins("صالة هاي سسستر", "غزة", "assets/images/gazacity.jpg","22/07/2022"),
  //   Reservatins("صالة هاي سسستر", "رفح", "assets/images/gazacity.jpg","22/07/2022"),
  //   Reservatins("صالة هاي سسستر", "خان يونس", "assets/images/gazacity.jpg","22/07/2022"),
  //   Reservatins("صالة هاي سسستر", "دير البلح", "assets/images/gazacity.jpg","22/07/2022"),
  //   Reservatins("صالة هاي سسستر", "غزة", "assets/images/gazacity.jpg","22/07/2022"),
  //
  //
  // ];


}
