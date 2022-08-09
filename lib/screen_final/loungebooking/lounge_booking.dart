import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:weddingappusers/widgetcompount/custom_button.dart';
import 'package:weddingappusers/widgetcompount/custom_formfield.dart';
import '../../widgetcompount/widgetcompount.dart';
import '../homescreen/Home.dart';

class LoungeBooking extends StatefulWidget {

  @override
  State<LoungeBooking> createState() => _LoungeBookingState();
}

class _LoungeBookingState extends State<LoungeBooking> {

  static const url =
      "https://wedding-planning-58319-default-rtdb.firebaseio.com/Reservation.json";
  var dateController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var phone_error;
  bool sound = false;
  bool kosha = false;
  bool buffet = false;
  bool candies = false;

  String email = SharedPrefController().getStringData(key: "email");

  late Map<String,String> map ;
  int price = 0;
  Map<String,bool> otherservice = {
    "sound":false,
    "kosha":false,
    "buffet":false,
    "candies":false
  };

  @override
  void initState() {
    List<String> list = SharedPrefController().getListStringData(key: "itemSelect");
    map = {
      "image": list[0],
      "name": list[1],
      "price": list[2],
      "location": list[3],
      "nameVendor": list[4],
      "phoneVendor": list[5],
      "capacity": list[6],
      "category": list[7],
      "city": list[8],
      "vendor": list[9],
    };

    price = int.parse(map["price"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    "${map["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${map['name']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 170,),
                          Text(
                            "$price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            "شيكل",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                            ),
                          )
                         ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${map['location']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                            children: [
                              const Text(
                                "ادارة:",
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${map['nameVendor']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                      Row(
                        children: [
                          const Text(
                            "هاتف رقم:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${map['phoneVendor']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200,
                                height: 1.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.people,size: 35,),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            "سعة القاعة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${map['capacity']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            " شخص",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const[
                          Icon(Icons.date_range,size: 35,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "تاريخ الحجز",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 30,
                          child: defaultFormField(
                            isClickable:true,
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: () {

                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:DateTime(2090),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'date must not be empty';
                              }

                              return null;
                            },
                            label: 'dd/mm/yyyy',
                            prefix: Icons.calendar_today,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/other.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "الخدمات",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: sound,
                                  onChanged: (value) {
                                    //print(price);
                                    setState(() {
                                      sound = value!;
                                      if(value){
                                      price += 200;
                                      otherservice["sound"] =true;
                                      }else {
                                        price -=200;
                                        otherservice["sound"] =false;
                                      }
                                    });
                                  },

                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'جهاز الصوت  ',
                                  style: TextStyle(fontSize: 17.0),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Checkbox(
                                  value: kosha,
                                  onChanged: (value) {
                                    // print(price);
                                    setState(() {
                                      kosha = value!;
                                      if(value){
                                        price += 100;
                                        otherservice["kosha"] =true;
                                      }else {
                                        price -=100;
                                        otherservice["kosha"] =false;
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'الكوشة ',
                                  style: const TextStyle(fontSize: 17.0),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: buffet,
                                    onChanged: (value) {
                                      // print(price);
                                      setState(() {
                                        buffet = value!;
                                        if(value){
                                          price += 400;
                                          otherservice["buffet"] =true;
                                        }else {
                                          price -=400;
                                          otherservice["buffet"] =false;
                                        }
                                      });
                                    },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'البوفيه            ',
                                  style: const TextStyle(fontSize: 17.0),
                                ),
                                Checkbox(
                                  value: candies,
                                  onChanged: (value) {
                                    // print(price);
                                    setState(() {
                                      candies = value!;
                                      if(value){
                                        price += 200;
                                        otherservice["candies"] =true;
                                      }else {
                                        price -=200;
                                        otherservice["candies"] =false;
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'الحلويات  ',
                                  style: const TextStyle(fontSize: 17.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          AuthButton(
                            onTap: () {
                              String other = "";
                              if(otherservice["sound"] == true){
                                other = "جهاز الصوت";
                              }
                              if(otherservice["kosha"] == true){
                                other+=", الكوشة";
                              }
                              if(otherservice["buffet"] == true){
                                other+=", البوفيه";
                              }
                              if(otherservice["candies"] == true){
                                other+=", الحلويات";
                              }

                              if(dateController.text.isEmpty){
                                snackBar(context, "الرجاء ادخال تاريخ الحجز",
                                    Colors.redAccent);
                              }else{
                                _showMyDialog(other);
                              }
                            },
                            text: 'الحجز',
                          ),
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }

  Future<void> _showMyDialog(String other) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            title: const Text('تأكيد الحجز'),
            content: SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  const Text('لتأكيد الحجز ادخل البيانات'),
                  const SizedBox(height: 10,),

                  TextFormField(
                    controller:nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء ادخال اسمك";
                      }
                      return null;

                    },
                    decoration: InputDecoration(
                      errorText: phone_error,
                      labelText: "اسم المستخدم",
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          borderSide: const BorderSide(
                              color: Color(0xFF5C3A00), width: 3)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء ادخال رقم الهاتف";
                      }
                      return null;

                    },
                    decoration: InputDecoration(
                      errorText: phone_error,
                      labelText: "رقم الهاتف",
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          borderSide: const BorderSide(
                              color: Color(0xFF5C3A00), width: 3)),
                    ),
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('نعم'),
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    addReservation(
                        url: url,
                        image: map["image"].toString(),
                        name: map["name"].toString(),
                        price: price.toString(),
                        location: map["location"].toString(),
                        capacity: map["capacity"].toString(),
                        date: dateController.text,
                        otherService: other,
                        phone: phoneController.text,
                        email: email,
                        category: map["category"].toString(),
                        city: map["city"].toString(),
                        nameUser: nameController.text,
                        usernameVendor: map['vendor'].toString())
                        .then((value) {
                      snackBar(context, "تم الحجز بنجاح", Colors.green);
                      navigateReplacement(context, Hommme());
                    });
                  }else{
                    snackBar(context, "الرجاء ادخل رقم الهاتف", Colors.redAccent);
                  }
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
          ),
        );
      },
    );
  }
}
