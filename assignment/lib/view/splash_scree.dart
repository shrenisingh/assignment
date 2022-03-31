

import 'package:assignment/view/AuthScreen/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
   String? token = GetStorage().read("token");
   @override
  AnimationController? _animationController;
  Animation<double>? _animation;
 Timer? _time;
  @override
  void initState() {
  
    
    _animationController = new AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );
    _animation = new CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    );

   
    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(_animationController!);
    _animationController!.forward();

    _time=Timer(const Duration(seconds: 2), (){
      Get.to(() =>const LoginScreen());
    });
    super.initState();
  }
 
 @override
 void dispose() {
   _animationController!.dispose();
   _time!.cancel();
   super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child:Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:500,width:500,child:Lottie.asset("assets/splash.json")),
              const SizedBox(height:20),
            ],)
      ),
    );
  }
}
