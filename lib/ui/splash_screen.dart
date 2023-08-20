import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/const/AppColors.dart';
import 'package:project/ui/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('E-Commerce',
            style: TextStyle(fontSize: 44.sp,fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 20.h,),
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: AppColors.deep_orange,
              strokeWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}
