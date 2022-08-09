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

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Services.json";
  static const urlStorage = "gs://wedding-planning-58319.appspot.com";
  String usernameVendor = SharedPrefController().getStringData(key: "username");
  final _nameVendor = TextEditingController();
  final _phoneVendor = TextEditingController();
  final city=['غزة','خانيونس','رفح','دير البلح'];
  final cityEnglish=['gaza','khan','rafah','dair'];
  String? valueCity ;
  final _location = TextEditingController();
  final service=['قاعات','كوافير','زهور وهدايا','فساتين','كروت أفراح','تصوير','سيارة الزفة','بدلات'];
  final serviceEnglish=['halls','hairdresser','flowers','dresses','cards','photos','cars','suits'];
  String? valueCategory ;
  final _nameService = TextEditingController();
  final _capacity = TextEditingController();
  final _price = TextEditingController();


  PickedFile? imageFile ;

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
                title: const Text("اضافة خدمة", style: KTextStyle.headerTextStyle,),
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
                              headingText: "اسم صاحب الخدمة",
                              hintText: "اسم صاحب الخدمة",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _nameVendor,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "رقم صاحب الخدمة",
                              hintText: "رقم صاحب الخدمة",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _phoneVendor,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.phone,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton<String>(
                                hint: const Text('الموقع'),
                                value: valueCity,
                                iconSize:30,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                isExpanded: true,
                                items: city.map(buildMenuItem).toList(),
                                onChanged:(value)
                                {


                                  print("object");


                                  setState(() {
                                    if (value == "زهور وهدايا") {
                                      print("object");
                                    }

                                    valueCity = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "العنوان",
                              hintText: "أضف العنوان بالتحديد",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _location,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                                bottom: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton<String>(
                                hint: const Text('نوع الخدمة'),
                                value: valueCategory,
                                iconSize:30,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,),
                                isExpanded: true,
                                items: service.map(buildMenuItem).toList(),
                                onChanged:(value1)=> setState(() {
                                  valueCategory = value1!;
                                }),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "اسم الخدمة",
                              hintText: "اسم الخدمة",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _nameService,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "سعة المكان",
                              hintText: "سعة المكان",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _capacity,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10,),
                            CustomFormField(
                              headingText: "السعر",
                              hintText: "السعر",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _price,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.number,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 150,
                                width: 150,
                                child: DottedBorder(
                                  customPath: (size) {
                                    return Path()
                                      ..moveTo(10, 0)
                                      ..lineTo(size.width - 15, 0)
                                      ..arcToPoint(Offset(size.width, 15), radius: const Radius.circular(15))
                                      ..lineTo(size.width, size.height - 15)
                                      ..arcToPoint(Offset(size.width - 15, size.height), radius: const Radius.circular(15))
                                      ..lineTo(10, size.height)
                                      ..arcToPoint(Offset(0, size.height - 15), radius: const Radius.circular(15))
                                      ..lineTo(0, 15)
                                      ..arcToPoint(
                                        const Offset(15, 0),
                                        radius: const Radius.circular(15),
                                      );
                                  },
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                  dashPattern: const [10, 5],
                                  child: (imageFile == null) ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _showChoiceDialog(context);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                            size: 40,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MaterialButton(
                                          textColor: Colors.white,

                                          onPressed: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: const Text("ارفع صورة العرض", style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),),
                                        )
                                      ],
                                    ),
                                  ) : Center(
                                    child: Image.file(
                                      File(imageFile!.path),
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            AuthButton(
                              onTap: () async{
                                String urlImage;
                                if(imageFile == null ){
                                  snackBar(context, "الرجاء ادخل صورة للخدمة", Colors.redAccent);
                                }
                                else if(
                                _nameVendor.text.isEmpty ||_phoneVendor.text.isEmpty ||
                                    valueCity!.isEmpty ||_location.text.isEmpty ||
                                    valueCategory!.isEmpty ||_nameService.text.isEmpty ||
                                    _price.text.isEmpty){
                                  snackBar(context, "الرجاء ادخل جميع الحقول", Colors.redAccent);
                                }
                                else {
                                  await uploadPic(File(imageFile!.path));
                                  //print(urlImage);
                                  // addServiceData(
                                  // url: url,
                                  // name: _nameService.text,
                                  // price: _price.text,
                                  // capacity: _capacity.text,
                                  // image: urlImage,
                                  // location: _location.text,
                                  // phoneVendor: _phoneVendor.text,
                                  // nameVendor: _nameVendor.text,
                                  // category: valueCategory!,
                                  // city: valueCity!,
                                  // vendor: usernameVendor).then((value) => null);
                            }
                          },
                              text: 'اضافة الخدمة',
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

  Future<String> uploadPic(File _image1) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url ="";
    print("****************$url");
    final fileName = basename(_image1.path);
    final destination = 'files/$fileName';
    Reference reference = storage.ref(destination);
    await reference.putFile(_image1);
    url = await reference.getDownloadURL();
    print("****************$url");
    return url;
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  DropdownMenuItem<String> buildMenuItem(String item)=> DropdownMenuItem(
    value:item,
    child: Text(
      item,
      style: const TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 14),
    ),
  );

}
