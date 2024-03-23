import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/appbar_bottom_navigator/appbar_bottom_navigator_screen.dart';
import 'package:pulsepower_258/screen/premium/premium_screen.dart';
import 'package:pulsepower_258/screen/settings/widget/s_iitem_widget.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AppImages.bo,
          ),
        ),
      ),
      child: SingleChildScrollView(
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
            if (!premium) SizedBox(height: 17.h),
            if (!premium)
              SettingsIitemWidget(
                title: 'Restore',
                onTap: () async {
                  final hasPremiumAccess = await Apphud.hasPremiumAccess();
                  final hasActiveSubscription =
                      await Apphud.hasActiveSubscription();
                  if (hasPremiumAccess || hasActiveSubscription) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('ISBUY', true);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Success!'),
                        content: const Text('Your purchase has been restored!'),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AppbarBottomNavigatorScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Restore purchase'),
                        content: const Text(
                            'Your purchase is not found. Write to support: https://forms.gle/ncosJHVoEoZpHyXg8'),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () => {Navigator.of(context).pop()},
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            if (!premium) SizedBox(height: 17.h),
            // if (!premium) const Spacer(),
            SettingsIitemWidget(
              title: 'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebPulsePower(
                      url:
                          'https://docs.google.com/document/d/1wJhYMuzMsdypR3qB8WK3--8hocAtkUm7tH07sWyOWXs/edit?usp=sharing',
                      title: 'Privacy policy',
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
                      url:
                          'https://docs.google.com/document/d/1jFiBEmElZo3adgIeNXbBenNGPYCpYX3OSqxhYGe9Q0o/edit?usp=sharing',
                      title: 'Terms of use',
                    ),
                  ),
                );
              },
              top: 20.h,
            ),
            SettingsIitemWidget(
              title: 'Support',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebPulsePower(
                      title: 'Terms of use',
                      url: 'https://forms.gle/ncosJHVoEoZpHyXg8',
                    ),
                  ),
                );
              },
              top: 20.h,
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
