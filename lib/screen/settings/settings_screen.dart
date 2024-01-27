import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/premium/premium_screen.dart';
import 'package:pulsepower_258/screen/settings/widget/settings_iitem_widget.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:pulsepower_258/utils/urls.dart';
import 'package:pulsepower_258/widgets/web_view_news.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
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
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 19.w, right: 19.w),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                alignment: Alignment.topCenter,
                AppImages.premiumImage,
                width: 352,
                height: 235.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 17.h),
            SettingsIitemWidget(
                title: 'View premium',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PremiumScreen(),
                    ),
                  );
                }),
            const Spacer(),
            SettingsIitemWidget(
              title: 'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebPulsePower(
                      title: 'Privacy policy',
                      url: DocFFPulsePower.pP,
                    ),
                  ),
                );
              },
            ),
            SettingsIitemWidget(
              title: 'Terms of use',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebPulsePower(
                      title: 'Terms of use',
                      url: DocFFPulsePower.tUse,
                    ),
                  ),
                );
              },
              top: 20.h,
            ),
            SettingsIitemWidget(title: 'Support', onTap: () {}, top: 20.h),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
