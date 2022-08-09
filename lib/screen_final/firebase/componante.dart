import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

void navigatePush(BuildContext context, Widget widget) =>
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>widget
    ));

void snackBar(BuildContext context,String text,Color color){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text,style: TextStyle(fontSize: 16),),
    backgroundColor: color,

  ));
}



// firebase
Future<Map<String, String>> getProfileData(String url,String username)async {
  Map<String,String> profile ={};
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    //print(json.decode(res.body));
    extractedData.forEach((key, value){
      if(username == value["username"]) {
        profile = {
        'username' : value["username"],
        'password' : value["password"],
        'name' : value["name"],
        'phone' : value["phone"],
      };
      }
      // print(value["username"]);
    }
    );
  }catch(error){
    throw error;
  }
  return profile;
}

Future<void> addData(String url,String name, String email, String password) async {
  http.post(Uri.parse(url),
      body: json.encode({
        "name": name,
        "email": email,
        "password": password,
      }));
}

Future<bool> fetchData(String url,String v,String type)async {
  bool x = false;
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    // print(json.decode(res.body));
    extractedData.forEach((key, value){

      if(value[type] == v){
        x = true;
        // print (value);
      }
    });
  }catch(error){
    throw error;
  }
  return x;
}

Future<bool> updateData(String url,String phone,String newPhone)async {
  bool x = false;
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    // print(json.decode(res.body));
    extractedData.forEach((key, value){

      if(value["phone"] == phone){

        FirebaseDatabase.instance.ref("Vendor")
            .child(key)
            .update({
          "phone":newPhone
        });
        x = true;
        // print (value);
      }
    });
  }catch(error){
    rethrow;
  }
  return x;
}

Future<bool> fetchDataLogin(String url,String email,String password)async {
  bool x = false;
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    // print(json.decode(res.body));
    extractedData.forEach((key, value){

      if(value["email"] == email && value["password"] == password){
        x = true;
        // print (value);
      }
    });
  }catch(error){
    throw error;
  }
  return x;
}

Future<void> addServiceData(
    {
      required String url,
      required String name,
      required String price,
      required String capacity,
      required String image,
      required String location,
      required String phoneVendor,
      required String nameVendor,
      required String category,
      required String city,
      required String vendor,
    }) async {
  http.post(Uri.parse(url),
      body: json.encode({
        'name': name,
        'price': price,
        'capacity': capacity,
        'image': image,
        'location': location,
        'phoneVendor': phoneVendor,
        'nameVendor': nameVendor,
        'category': category,
        'city': city,
        'vendor': vendor,
      }));
}

Future<List<Map<String,String>>> getServiceData(
    String url,
    String category,
    String city)async {
  List<Map<String,String>> service =[];
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
     //print("fff $extractedData");
    extractedData.forEach((key, value){
      if(value["category"] == category && value["city"] == city){
        service += [
          {
             'name': value["name"],
             'price': value["price"],
             'capacity': value["capacity"],
             'image': value["image"],
             'location': value["location"],
             'phoneVendor': value["phoneVendor"],
             'nameVendor': value["nameVendor"],
             'category': value["category"],
             'city': value["city"],
             'vendor': value["vendor"],
          }
        ];
      }
    }
    );
    // final ref = FirebaseDatabase.instance.ref();
    // DataSnapshot snapshot = await ref.child('/Services/').get();
    // print("ddd ${snapshot.value}");
  }catch(error){
    service;
  }
  return service;
}

Future<List<Map<String,String>>> getVendorServiceData(
    String url,
    String vendor)async {
  List<Map<String,String>> service =[];
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    //print("fff $extractedData");
    extractedData.forEach((key, value){
      if(value["vendor"] == vendor){
        service += [
          {
            'name': value["name"],
            'price': value["price"],
            'capacity': value["capacity"],
            'image': value["image"],
            'location': value["location"],
            'phoneVendor': value["phoneVendor"],
            'nameVendor': value["nameVendor"],
            'category': value["category"],
            'city': value["city"],
          }
        ];
      }
    }
    );
  }catch(error){
    service;
  }
  return service;
}


Future<void> addReservation({
  required String url,
  required String image,
  required String name,
  required String price,
  required String location,
  required String capacity,
  required String date,
  required String otherService,
  required String phone,
  required String email,
  required String category,
  required String city,
  required String nameUser,
  required String usernameVendor,
}) async {
  http.post(Uri.parse(url),
      body: json.encode({
        "name": name,
        "image": image,
        "price": price,
        "location": location,
        "capacity": capacity,
        "date": date,
        "otherService": otherService,
        "phone": phone,
        "email": email,
        'category': category,
        'city': city,
        'nameUser': nameUser,
        'vendor': usernameVendor,
      }));
}

Future<List<Map<String,String>>> getReservationsData(String url,String username)async {
  List<Map<String,String>> service =[];
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    //print("fff $extractedData");

    extractedData.forEach((key, value){
      if(value["vendor"] == username){
        service += [
          {
            'name': value["name"],
            'price': value["price"],
            'capacity': value["capacity"],
            'image': value["image"],
            'location': value["location"],
            'date': value["date"],
            'phone': value["phone"],
            'category': value["category"],
            'city': value["city"],
            'otherService': value["otherService"],
            'nameUser': value["nameUser"],
          }
        ];
      }
     // return value;
     //  print(key);
     //  print(value);
    }
    );
    // final ref = FirebaseDatabase.instance.ref();
    // DataSnapshot snapshot = await ref.child('/Services/').get();
    // print("ddd ${snapshot.value}");
  }catch(error){
    service;
  }
  return service;
}


Future<void> removeReservationsData(String url,String name,String phone)async {
  List<Map<String,String>> service =[];
  try{
    http.Response res = await http.get(Uri.parse(url));
    final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
    //print("fff $extractedData");

    extractedData.forEach((key, value){
      //print(key);

      // print(phone);

      if(value["name"] == name && value["phone"] == phone){
        print(name);
        FirebaseDatabase.instance.ref("Reservation")
            .child(key)
            .remove();
        // extractedData.remove(key);
      }
      // return value;
      //  print(key);
      //  print(value);
    }
    );
    // final ref = FirebaseDatabase.instance.ref();
    // DataSnapshot snapshot = await ref.child('/Services/').get();
    // print("ddd ${snapshot.value}");
  }catch(error){
    rethrow;
  }
}

Future<void> addVendor(
    {
      required String url,
      required String name,
      required String phone,
      required String username,
      required String password
    }) async {
  http.post(Uri.parse(url),
      body: json.encode({
        "name": name,
        "phone": phone,
        "username": username,
        "password": password,
      }));
}
