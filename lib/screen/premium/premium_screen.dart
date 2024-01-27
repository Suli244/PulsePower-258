import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/settings/widget/settings_iitem_widget.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/style/app_text_styles.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///// Bottom Sheet /////
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => Container(
          height: 350.h,
          width: double.infinity.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
            ),
            color: AppColorsPulsePower.color272727,
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.50),
              ),
              left: BorderSide(
                color: Colors.white.withOpacity(0.50),
              ),
              right: BorderSide(
                color: Colors.white.withOpacity(0.50),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 11.h),
            child: Column(
              children: [
                Text(
                  'FlowOn workout',
                  style: AppTextStylesPulsePower.s19W300(color: Colors.white),
                ),
                SizedBox(height: 8.h),
                const Divider(
                  thickness: 1,
                  color: AppColorsPulsePower.color696969,
                ),
                SizedBox(height: 10.h),
                FittedBox(
                  child: Text(
                    'Premium will open access to all the\nfunctions of the application - more\nworkouts, more pounds lost',
                    style: AppTextStylesPulsePower.s20W300(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SettingsIitemWidget(
                  title: 'Buy Premium for 0.99\$',
                  onTap: () {},
                ),
                SizedBox(height: 9.h),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Think about it later',
                    style: AppTextStylesPulsePower.s21W300(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
      ///// body /////
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [
              const Color.fromARGB(255, 77, 1, 255).withOpacity(0.10),
              const Color.fromARGB(255, 60, 20, 148).withOpacity(0.10),
              const Color.fromARGB(0, 132, 73, 250),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 75.h),
            Image.asset(
              AppImages.premiumLogoIcon,
              width: 131.w,
              height: 131.h,
            ),
            SizedBox(height: 13.h),
            Row(
              children: [
                const Spacer(),
                Image.asset(
                  AppImages.premiumIcon,
                  width: 33.w,
                  height: 33.h,
                ),
                const SizedBox(width: 5),
                FittedBox(
                  child: Text(
                    'PREMIUM ACCOUNT',
                    style: AppTextStylesPulsePower.s22W300(
                      color: AppColorsPulsePower.colorD479FF,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  AppImages.premiumIcon,
                  width: 33.w,
                  height: 33.h,
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 44.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  FittedBox(
                    child: Text(
                      'Saving your training history for up to a month',
                      style:
                          AppTextStylesPulsePower.s145W400(color: Colors.white),
                    ),
                  ),
                  const Divider(
                    color: AppColorsPulsePower.color696969,
                  ),
                  FittedBox(
                    child: Text(
                      'All content that includes more effective workouts',
                      style:
                          AppTextStylesPulsePower.s145W400(color: Colors.white),
                    ),
                  ),
                  const Divider(
                    color: AppColorsPulsePower.color696969,
                  ),
                  FittedBox(
                    child: Text(
                      'No advertising at all',
                      style:
                          AppTextStylesPulsePower.s145W400(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
