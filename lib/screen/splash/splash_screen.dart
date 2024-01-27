import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pulsepower_258/screen/appbar_bottom_navigator/appbar_bottom_navigator_screen.dart';
import 'package:pulsepower_258/screen/onboarding/onboarding_screen.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:pulsepower_258/utils/premium/first_open.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    toGoOnBoar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: AppColorsPulsePower.colorSp,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppImages.splashLogo,
                width: 223.w,
                height: 171.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  toGoOnBoar() async {
    await Future.delayed(const Duration(milliseconds: 1450));
    final isFirst = await FirstOpenPulsePower.getFirstOpen();
    if (!isFirst) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
      await Future.delayed(const Duration(seconds: 8));
      try {
        final InAppReview inAppReview = InAppReview.instance;
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppbarBottomNavigatorScreen(),
        ),
      );
    }
  }
}
