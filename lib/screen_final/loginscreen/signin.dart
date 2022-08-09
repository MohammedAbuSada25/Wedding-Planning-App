import 'package:flutter/material.dart';
import 'package:weddingappusers/screen_final/shared_pref/shared_pref_componants.dart';
import '../../styles/app_colors.dart';
import '../../widgetcompount/custom_button.dart';
import '../../widgetcompount/custom_formfield.dart';
import '../../widgetcompount/custom_header.dart';
import '../../widgetcompount/custom_richtext.dart';
import '../firebase/componante.dart';
import '../homescreen/Home.dart';
import '../sginupscreen/signup.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  static const url = "https://wedding-planning-58319-default-rtdb.firebaseio.com/Users.json";
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
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
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
                    headingText: "البريد الإلكتروني",
                    hintText: "البريد الإلكتروني",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: _emailController,
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
                    controller: _passwordController,
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
                      if(email.isNotEmpty && password.isNotEmpty){
                        bool e = await fetchDataLogin(url,email,password);
                        if(e){
                          SharedPrefController().setStringData(key: "email", value: email);
                          snackBar(context, "أهلا بك في تطبيق فرحتنا ",Colors.green);
                          navigateReplacement(context, Hommme());
                        }else{
                          snackBar(context, "الرجاء ادخل البريد الالكتروني وكلمة المرور الصحيحين", Colors.red);
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
                      text: "إانشاء حساب",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()
                            )
                        );
                      },
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
