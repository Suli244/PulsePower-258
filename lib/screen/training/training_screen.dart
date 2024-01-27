import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      height: double.infinity.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AppImages.bo,
          ),
        ),
      ),
    );
  }
}
