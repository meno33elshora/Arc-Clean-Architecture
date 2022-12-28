import 'dart:async';
import 'package:arc/Core/Utils/color.dart';
import 'package:arc/Features/Posts/Persentation/Pages/posts_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PostsPage()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.ac_unit,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            CircularProgressIndicator(
              color: ColorManager.greenLight,
            ),
          ],
        ),
      ),
    );
  }
}
