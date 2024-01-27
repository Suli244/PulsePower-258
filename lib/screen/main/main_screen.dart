import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_data.dart';
import 'package:pulsepower_258/screen/training_detail_screen/training_detail_screen.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
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
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => TrainingDetailScreen(
                  model: trainData.trainingPlans.first,
                  title: 'Beginner 4',
                ),
              ),
            );
          },
          child: const Text(
            'Treining',
          ),
        ),
      ),
    );
  }
}
