import 'package:flutter/material.dart';
import 'package:weddingappusers/vendor/screen/profile_vendor.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:weddingappusers/screen_final/firebase/componante.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import '../../widgetcompount/custom_button.dart';
import '../../widgetcompount/custom_formfield.dart';

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Services.json";
  late List list;
  //List<Map<String,String>> service = [];
  late Map<String, String> service = {};
  bool condition =true;
  //TextFormField
  var edit_name = TextEditingController();
  var edit_capacity = TextEditingController();
  var edit_price = TextEditingController();
  var edit_phoneVendor = TextEditingController();
  bool visible = false;
  bool visible1 = false;
  bool visible2= false;
  bool visible3= false;


  @override
  void initState() {
    //getProfile();
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
              "التفاصيل",
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
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: ConditionalBuilder(
                    condition: condition,
                    builder: (context) => body(),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
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
        padding: const EdgeInsets.only(top: 100, right: 5, left: 5),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "اسم الخدمة:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          width: 100,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "صالة روتانا",
                          style:
                          TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                        )
                      ],
                    ),
                    Visibility(
                      visible: visible,
                      child: Column(
                        children: [
                          CustomFormField(
                            headingText: "تغيير اسم الخدمة",
                            hintText: "اسم الخدمة",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: edit_name,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            onTap: () async {
                              if (edit_name.text.isNotEmpty) {
                                await updateData(
                                  url,
                                  service["name"].toString(),
                                  edit_name.text,
                                ).then((value) {
                                  if (value) {
                                    setState(() {
                                      navigateReplacement(
                                          context, ProfileVendor());
                                      snackBar(context, "تم تغيير اسم الخدمة",
                                          Colors.green);
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
                    const SizedBox(
                      height: 5,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "رقم  صاحب الخدمة:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          width: 100,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "0592198974",
                          style:
                          const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              visible1 = !visible1;
                            });
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                        )
                      ],
                    ),
                    Visibility(
                      visible: visible1,
                      child: Column(
                        children: [
                          CustomFormField(
                            headingText: "تغيير رقم  صاحب الخدمة",
                            hintText: "رقم  صاحب الخدمة",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: edit_phoneVendor,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            onTap: () async {
                              if (edit_phoneVendor.text.isNotEmpty) {
                                await updateData(
                                  url,
                                  service["phoneVendor"].toString(),
                                  edit_phoneVendor.text,
                                ).then((value) {
                                  if (value) {
                                    setState(() {
                                      navigateReplacement(
                                          context, ProfileVendor());
                                      snackBar(context, "تم تغيير رقم  صاحب الخدمة",
                                          Colors.green);
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "سعة المكان:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          width: 100,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "500",
                          style:
                          const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              visible2 = !visible2;
                            });
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                        )
                      ],
                    ),
                    Visibility(
                      visible: visible2,
                      child: Column(
                        children: [
                          CustomFormField(
                            headingText: "تغيير سعة المكان",
                            hintText: "سعة المكان",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: edit_capacity,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            onTap: () async {
                              if (edit_capacity.text.isNotEmpty) {
                                await updateData(
                                  url,
                                  service["capacity"].toString(),
                                  edit_capacity.text,
                                ).then((value) {
                                  if (value) {
                                    setState(() {
                                      navigateReplacement(
                                          context, ProfileVendor());
                                      snackBar(context, "تم تغيير سعة المكان",
                                          Colors.green);
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "السعر:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          width: 100,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "2000", //service["price"].toString(),
                          style:
                          const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              visible3 = !visible3;
                            });
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                        )
                      ],
                    ),
                    Visibility(
                      visible: visible3,
                      child: Column(
                        children: [
                          CustomFormField(
                            headingText: "تغيير السعر",
                            hintText: "السعر",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: edit_price,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            onTap: () async {
                              if (edit_price.text.isNotEmpty) {
                                await updateData(
                                  url,
                                  service["price"].toString(),
                                  edit_price.text,
                                ).then((value) {
                                  if (value) {
                                    setState(() {
                                      navigateReplacement(
                                          context, ProfileVendor());
                                      snackBar(context, "تم تغيير السعر",
                                          Colors.green);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "المكان:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          width: 100,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "خانيونس - البلد - شارع جلال", //service["price"].toString(),
                          style:
                          const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              visible3 = !visible3;
                            });
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  String usernameVendor = SharedPrefController().getStringData(key: "username");

  Future<void> getProfile() async {
    bool x = false;
    await getProfileData(url, usernameVendor).then((value) {
      service = value;
      x = true;
      print(service);
    });
    setState(() {
      condition = x;
    });
  }
}
