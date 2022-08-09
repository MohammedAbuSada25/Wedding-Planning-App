import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgetcompount/widgetcompount.dart';
import '../../screen_final/loungebooking/lounge_booking.dart';
import '../shared_pref/shared_pref_componants.dart';


class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

  @override
  void initState() {
    getService();

    String city = SharedPrefController().getStringData(key: "city");

    if(city == "gaza"){
      city1 ='غزة';
    }else if (city == 'khan'){
      city1 ='خانيونس';
    }else if (city == 'rafah'){
      city1 ='رفح';
    }else{
      city1 ='دير البلح';
    }

  }

  String city1 = '';
  static const url =
      "https://wedding-planning-58319-default-rtdb.firebaseio.com/Services.json";
  String city = SharedPrefController().getStringData(key: "city");
  String category = SharedPrefController().getStringData(key: "category");
  List<Map<String, String>> service = [];

  bool condition = false;

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
            title: Text(
              " مدينة$city1",
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
            childAspectRatio: 8 / 5,
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

  Widget buildItem(context,Map model)=> Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff827397),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(right: 10, top: 8),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: GestureDetector(
                          onTap: () {
                            List<String> list;
                            list = [
                              model["image"],
                              model["name"],
                              model["price"],
                              model["location"],
                              model["nameVendor"],
                              model["phoneVendor"],
                              model["capacity"],
                              model["category"],
                              model["city"],
                              model["vendor"]
                            ];
                            SharedPrefController().setListStringData(key: "itemSelect", value: list);
                            //print(list[1]);

                            navigateTo(
                                context, LoungeBooking());
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
                    children: const[
                      Text(
                       'الاسم:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "السعة:",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "السعر:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),


                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        model['name'],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            model['capacity'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "شخص",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            model['price'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "شيكل",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ));



  Future<void> getService() async {
    bool x = false;
    await getServiceData(url, category, city).then((value) {
      service = value;

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

  // String uuu ='https://firebasestorage.googleapis.com/v0/b/wedding-planning-58319.appspot.com/o/1.jpeg?alt=media&token=c39d914d-43d2-403d-af9d-42c19839ed5d';
  // void loadImage() async {
  //   var imageId = await ImageDownloader.downloadImage(uuu);
  //   var path = await ImageDownloader.findPath(imageId!);
  //   File image = File(path!);
  //   // setState(() {
  //   //   _image = image;
  //   // });
  // }


  // List List2 = [
  //   Salat("صالة الجنة", "200-400", "assets/images/gazacity.jpg", "600"),
  //   Salat("صالة هاي سسستر", "300-500", "assets/images/gazacity.jpg", "600"),
  //   Salat("صالة الافراح", "600-750", "assets/images/gazacity.jpg", "600"),
  //   Salat("صالة الاغا", "800-850", "assets/images/gazacity.jpg", "600"),
  // ];
}
