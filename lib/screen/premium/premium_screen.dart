import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/appbar_bottom_navigator/appbar_bottom_navigator_screen.dart';
import 'package:pulsepower_258/screen/settings/widget/s_iitem_widget.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool isLoading = false;
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
                const Text(
                  'FlowOn workout',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree-Regular',
                  ),
                ),
                SizedBox(height: 8.h),
                const Divider(
                  thickness: 1,
                  color: AppColorsPulsePower.color696969,
                ),
                SizedBox(height: 10.h),
                const FittedBox(
                  child: Text(
                    'Premium will open access to all the\nfunctions of the application - more\nworkouts, more pounds lost',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree-Regular',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SettingsIitemWidget(
                  isLoading: isLoading,
                  title: 'Buy Premium for 0.99\$',
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final apphudPaywalls = await Apphud.paywalls();
                    print(apphudPaywalls);

                    await Apphud.purchase(
                      product: apphudPaywalls?.paywalls.first.products?.first,
                    ).whenComplete(
                      () async {
                        if (await Apphud.hasPremiumAccess() ||
                            await Apphud.hasActiveSubscription()) {
                          final hasPremiumAccess =
                              await Apphud.hasPremiumAccess();
                          final hasActiveSubscription =
                              await Apphud.hasActiveSubscription();
                          if (hasPremiumAccess || hasActiveSubscription) {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('ISBUY', true);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: const Text('Success!'),
                                content: const Text(
                                    'Your purchase has been restored!'),
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
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: const Text('Restore purchase'),
                                content: const Text(
                                    'Your purchase is not found. Write to support: https://docs.google.com/forms/d/e/1FAIpQLSe2dY5sixywVpTYU9K34aEqYi67rDquTx9XMeDZWeU2de_rag/viewform?usp=sf_link'),
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () =>
                                        {Navigator.of(context).pop()},
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                          }
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const AppbarBottomNavigatorScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                    );
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                SizedBox(height: 9.h),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Think about it later',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree-Regular',
                    ),
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
                const FittedBox(
                  child: Text(
                    'PREMIUM ACCOUNT',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: AppColorsPulsePower.colorD479FF,
                      fontFamily: 'BaiJamjuree-Regular',
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
              child: const Column(
                children: [
                  FittedBox(
                    child: Text(
                      'Saving your training history for up to a month',
                      style: TextStyle(
                        fontSize: 14.7,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'BaiJamjuree-Regular',
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColorsPulsePower.color696969,
                  ),
                  FittedBox(
                    child: Text(
                      'All content that includes more effective workouts',
                      style: TextStyle(
                        fontSize: 14.7,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'BaiJamjuree-Regular',
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColorsPulsePower.color696969,
                  ),
                  FittedBox(
                    child: Text(
                      'No advertising at all',
                      style: TextStyle(
                        fontSize: 14.7,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'BaiJamjuree-Regular',
                      ),
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
