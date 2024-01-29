import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/premium/premium_screen.dart';
import 'package:pulsepower_258/screen/settings/widget/settings_iitem_widget.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:pulsepower_258/utils/urls.dart';
import 'package:pulsepower_258/widgets/web_view_news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool premium = true;

  getPremium() async {
    final prefs = await SharedPreferences.getInstance();
    premium = prefs.getBool('ISBUY') ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getPremium();
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
            if (!premium)
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
            if (!premium) SizedBox(height: 17.h),
            if (!premium)
              SettingsIitemWidget(
                  title: 'View premium',
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumScreen(),
                      ),
                    );
                    setState(() {});
                  }),
            if (!premium) const Spacer(),
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
