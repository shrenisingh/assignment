import 'dart:async';
import 'package:assignment/controller/login_controller.dart';
import 'package:assignment/model/user.dart';
import 'package:assignment/utils/helpers/style.dart';
import 'package:assignment/view/ProfileScreen/profile_screen.dart';

import 'package:assignment/view/AuthScreen/registration_screen.dart';
import 'package:assignment/widgets/custom_textform_field.dart';
import 'package:assignment/widgets/rectangle_expandable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _state = Get.put(LoginController());

  /// These Global Key's for form validation
  final GlobalKey<FormState> emailState = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordState = GlobalKey<FormState>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ///  STEP: 1 - Verify credentials to login
  void loginUser() async {
    if (emailState.currentState!.validate() && passwordState.currentState!.validate()) {
      _state.email.value = emailController.text;
      _state.password.value = passwordController.text;
     final Map<String,dynamic>   _result = await _state.login();
      if (_result['status'] == true) {
        print(_result);
        Get.to(() => ProfileScreen(_result['user']['user_details']));
     } else {
        print("shreni"+_result['status'].toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: paddingLTRB(20, 0, 20, 0),
            child: Column(
              children: <Widget>[
                const _LogoCard(),
                gapTop(30),
                const FittedBox(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                gapTop(10),
                Form(
                  key: emailState,
                  child:
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomTextFormField(
                          controller: emailController,
                          maxWidth: double.infinity,
                          validator: (val) {
                            if (val!.isEmpty ) {
                              return "Please Enter Email";
                            }
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hintText: "Enter Email",
                        ),
                      ),
                      
                ),
                Form(
                  key: passwordState,
                  child:  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomTextFormField(
                          controller: passwordController,
                          maxWidth: double.infinity,
                          validator: (val) {
                            if (val!.isEmpty ) {
                              return "Please Enter Password";
                            }
                          },
                          keyBoardType: TextInputType.visiblePassword,
                          hintText: "Enter Password",
                        ),
                      ),
                  ),
                gapTop(20),
                RectangleExpandableButton(
                  onTap: () => loginUser(),
                  label: "Login",
                  borderRadius: 100,
                  width: 250,
                ),
                gapTop(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account! "),
                    GestureDetector(
                     onTap: () =>    Get.offAll(() => const RegistrationScreen()),
                  
                      child: const Text(
                        "sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Avenir-Next",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoCard extends StatelessWidget {
  const _LogoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        gapTop(50),
        
        Container(
          height: 250,
          width: 400,
          padding: paddingAll(20),
          margin: paddingLTRB(0, 20, 0, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: defaultBoxShadow,
          ),
          child: Column(
            children: <Widget>[
              Lottie.asset("assets/splash.json"),
              
              
            ],
          ),
        ),
      ],
    );
  }
}
