import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weddingappusers/styles/app_colors.dart';
import '../../screen_final/shared_pref/shared_pref_componants.dart';
import '../../styles/text_styles.dart';
import '../../widgetcompount/custom_button.dart';
import '../../widgetcompount/custom_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:path/path.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Vendor.json";

  final _nameVendor = TextEditingController();
  final _phoneVendor = TextEditingController();
  final _passwordVendor = TextEditingController();
  final _usernameVendor = TextEditingController();

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
                title: const Text("اضافة مقدم خدمة", style: KTextStyle.headerTextStyle,),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 90),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomFormField(
                              headingText: "اسم مقدم الخدمة",
                              hintText: "اسم مقدم الخدمة",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _nameVendor,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "رقم مقدم الخدمة",
                              hintText: "رقم مقدم الخدمة",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _phoneVendor,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.phone,
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "اسم المستخدم",
                              hintText: "اليوزر",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _usernameVendor,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "كلمة السر",
                              hintText: "كلمة السر",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _passwordVendor,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10,),

                            const SizedBox(height: 15,),
                            AuthButton(
                              onTap: () async{
                                 if(
                                _nameVendor.text.isEmpty ||_phoneVendor.text.isEmpty ||
                                _passwordVendor.text.isEmpty || _usernameVendor.text.isEmpty)
                                 {
                                  snackBar(context, "الرجاء ادخل جميع الحقول", Colors.redAccent);
                                 }
                                 else
                                   {
                                     fetchData(url, _usernameVendor.text, "username")
                                         .then((value) {
                                           if(value == false){
                                             addVendor(url: url,
                                                 name: _nameVendor.text,
                                                 phone: _phoneVendor.text,
                                                 username: _usernameVendor.text,
                                                 password: _passwordVendor.text);
                                           }else{
                                             snackBar(context, "هذا الحساب موجود من قبل",
                                                 Colors.redAccent);
                                           }
                                     });
                                   }
                              },
                              text: 'اضافة مقدم خدمة',
                            )
                          ],
                        ),
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
