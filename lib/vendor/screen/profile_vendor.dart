import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import 'package:weddingappusers/widgetcompount/widgetcompount.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgetcompount/custom_button.dart';
import '../../widgetcompount/custom_formfield.dart';

class ProfileVendor extends StatefulWidget {

  @override
  State<ProfileVendor> createState() => _ProfileVendorState();
}


class _ProfileVendorState extends State<ProfileVendor> {
  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Vendor.json";
  late Map<String,String> profile ={};
  bool condition = false;

  //TextFormField
  var edit_phone = TextEditingController();
  bool visible = false;

  @override
  void initState() {
     getProfile();
  }

  // late String username ="mohammed";
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
                title: const Text("الملف الشخصي", style: KTextStyle.headerTextStyle,),
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

                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: ConditionalBuilder(
                        condition: condition,
                        builder: (context)=> body(),
                        fallback: (context)=>const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget body() => Padding(
    padding: const EdgeInsets.only(top: 100,right: 5,left: 5),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text(
                      "اسم المستخدم:",
                      style: TextStyle(
                        fontSize: 18,

                      ),),
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    profile["username"].toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                    ),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "كلمة السر:",
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                    width: 100,
                  ),
                  const SizedBox(width: 30,),
                  const Text(
                    "******",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                    ),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 100,
                    child:  Text(
                      "الاسم:",
                      style: TextStyle(
                        fontSize: 18,

                      ),),
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    profile["name"].toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                    ),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "رقم الهاتف:",
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                    width: 100,
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    profile["phone"].toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                    ),),
                  IconButton(onPressed: (){
                    setState(() {
                      visible = !visible;
                    });
                  }, icon: Icon(Icons.edit),iconSize: 20,)
                ],
              ),
              Visibility(
                visible: visible,
                child: Column(
                  children: [
                    CustomFormField(
                      headingText: "تغيير رقم الهاتف",
                      hintText: "رقم الهاتف",
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: edit_phone,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10,),
                    AuthButton(
                      onTap: () async{
                        if(edit_phone.text.isNotEmpty){
                          await updateData(
                              url,
                              profile["phone"].toString(),
                              edit_phone.text,
                          ).then((value) {
                            if(value){
                              setState(() {
                                navigateReplacement(context, ProfileVendor());
                                snackBar(context, "تم تغيير الرقم", Colors.green);
                              });

                            }
                          });

                        }
                      },
                      text: 'حفظ',
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ],
    ),
  );

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  String username = SharedPrefController().getStringData(key: "username");
  Future<void> getProfile()async{
    bool x =false;
    await getProfileData(url,username).then((value) {
      profile = value;
      x = true;
      print(profile);
    });
    setState(() {
    condition = x ;
    });

  }
}
