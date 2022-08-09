
import 'package:flutter/material.dart';
import 'package:weddingappusers/homescreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:weddingappusers/screen_final/loginscreen/signin.dart';
import '../../styles/app_colors.dart';
import '../../widgetcompount/custom_button.dart';
import '../../widgetcompount/custom_formfield.dart';
import '../../widgetcompount/custom_header.dart';
import '../../widgetcompount/custom_richtext.dart';
import '../firebase/componante.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get userName => _userName.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Users.json";
  IconData icon = Icons.remove_red_eye;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue,
            ),
            CustomHeader(
                text: 'إنشاء حساب',
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Signin()));
                }),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.whiteshade,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.10),
                        child: Image.asset("assets/images/Logo1.png",color: AppColors.blue,),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        headingText: "اسم المستخدم",
                        hintText: "اسم المستخدم",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        controller: _userName,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        headingText: "البريد الالكتروني",
                        hintText: "البريد الإلكتروني",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        controller: _passwordController,
                        headingText: "كلمة المرور",
                        hintText: "أقل شي 8 أحرف",
                        obsecureText: true,
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AuthButton(
                        onTap: () {
                          if(userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                            if (!EmailValidator.validate(email)) {
                              snackBar(context, "تأكد من كتابة البريد الالكتروني بشكل صحيح", Colors.redAccent);
                            }else {
                              fetchData(url, email, "email").then((value) {
                                if (value == false) {
                                  addData(url, userName, email, password).then((
                                      value) {
                                    snackBar(context, "تم التسجيل بنجاح",
                                        Colors.green);
                                    navigateReplacement(context, Signin());
                                  });
                                } else {
                                  snackBar(context, "هذا الحساب موجود من قبل",
                                      Colors.redAccent);
                                }
                              });
                            }
                          }else{
                            snackBar(context,"الرجاء التأكد من ملىء جميع الحقول",Colors.redAccent);
                          }

                        },
                        text: 'إنشاء حساب',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: CustomRichText(
                          discription: 'أتملك حساب؟ ',
                          text: 'سجل دخولك من هنا',
                          onTap: () {
                            navigateReplacement(context, const Signin());

                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }



}
