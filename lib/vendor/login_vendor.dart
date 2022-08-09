
import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:weddingappusers/vendor/home_screen_vendoe.dart';

import '../styles/app_colors.dart';
import '../widgetcompount/custom_button.dart';
import '../widgetcompount/custom_formfield.dart';
import '../widgetcompount/custom_header.dart';
import '../widgetcompount/custom_richtext.dart';


class LoginVendor extends StatefulWidget {

  @override
  State<LoginVendor> createState() => _LoginVendorState();
}

class _LoginVendorState extends State<LoginVendor> {

  var username = TextEditingController();
  var password = TextEditingController();

  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Vendor.json";
  IconData icon = Icons.remove_red_eye;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColors.blue,
              ),
              CustomHeader(
                text: 'تسجيل الدخول',
                onTap: () {},
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteshade,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.10),
                        child: Image.asset("assets/images/Logo1.png",color:  AppColors.blue,),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomFormField(
                        headingText: "اسم المستخدم",
                        hintText: "اسم المستخدم",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        controller: username,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,

                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        headingText: "كلمة المرور",
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        hintText: "أقل شي 8 احرف",
                        obsecureText: visible,
                        suffixIcon: IconButton(
                            icon:  Icon(icon), onPressed: () {
                          setState(() {
                            visible = !visible;
                            if(visible){
                              icon = Icons.visibility;
                            }
                            else {
                              icon = Icons.visibility_off;
                            }
                          });
                        }),
                        controller: password,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: InkWell(
                              onTap: () {

                              },
                              child: Text(
                                "نسيت كلمة المرور؟",
                                style: TextStyle(
                                    color: AppColors.blue.withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AuthButton(
                        onTap: () async{

                          if (username.text.isNotEmpty && password.text.isNotEmpty) {
                              bool e = await fetchData(url,username.text, "username");
                              bool p = await fetchData(url,password.text, "password");

                            print(e);
                            print(p);
                            if (e && p) {
                              SharedPrefController().setStringData(key: "username", value: username.text);
                              navigateReplacement(context, HomeVendor());
                            }
                            else {
                                if(!e){
                                  snackBar(context, "الرجاء ادخل اسم المستخدم الصحيح", Colors.red);
                                }if(!p){
                                  snackBar(context, "الرجاء ادخل كلمة المرور الصحيحة", Colors.red);
                                }
                            }
                          }else{
                            snackBar(context, "الرجاء التأكد من ملىء جميع الحقول", Colors.red);
                          }
                        },
                        text: 'تسجيل الدخول',
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: CustomRichText(
                          discription: "لا تملك حساب؟ ",
                          text: "يمكنك الحصول على حساب تواصل على الرقم: 0592198974",
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),

    );

  }

}
