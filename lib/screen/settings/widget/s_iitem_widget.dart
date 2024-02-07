import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/style/app_colors.dart';

class SettingsIitemWidget extends StatelessWidget {
  const SettingsIitemWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.top,
  });
  final String title;
  final Function() onTap;
  final double? top;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top ?? 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColorsPulsePower.colorCB58FF,
                AppColorsPulsePower.color8A58F4,
                Colors.white.withOpacity(0.10),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : FittedBox(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree-Regular',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        ),
      ),
    );
  }
}
