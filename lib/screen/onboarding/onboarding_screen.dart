import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/appbar_bottom_navigator/appbar_bottom_navigator_screen.dart';
import 'package:pulsepower_258/screen/settings/widget/settings_iitem_widget.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/style/app_text_styles.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:pulsepower_258/utils/premium/first_open.dart';
import 'package:pulsepower_258/utils/premium/premium.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currantPage = 0;

  List<String> imageIndex = [
    AppImages.onboardingOne,
    AppImages.onboardingTwo,
    AppImages.onboardingThree,
  ];

  List<String> titleIndex = [
    'Welcome to the workout app. Work\nout, lose weight and get better!',
    'You can train the whole body at\nonce or choose any section you are \ninterested in',
    'Premium will open access to all the\nfunctions of the application - more\nworkouts, more pounds lost',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => Container(
          height: 330,
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
                SizedBox(height: 5.h),
                const Divider(
                  thickness: 1,
                  color: AppColorsPulsePower.color696969,
                ),
                SizedBox(height: 10.h),
                FittedBox(
                  child: Text(
                    titleIndex[currantPage],
                    style: AppTextStylesPulsePower.s21W300(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: SlideEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withOpacity(0.30),
                    dotHeight: 9.h,
                    dotWidth: 9.w,
                  ),
                ),
                SizedBox(height: 23.h),
                SettingsIitemWidget(
                  title:
                      currantPage == 2 ? 'Buy Premium for 0.99\$' : 'Continue',
                  onTap: () async {
                    if (currantPage == 2) {
                      await FirstOpenPulsePower.setFirstOpen();
                      await PremiumWebPulsePower.setPremium();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AppbarBottomNavigatorScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
                currantPage == 2
                    ? TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AppbarBottomNavigatorScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Think about it later',
                          style: AppTextStylesPulsePower.s21W300(
                              color: Colors.white),
                        ),
                      )
                    : Opacity(
                        opacity: 0,
                        child: IgnorePointer(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AppbarBottomNavigatorScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              'Think about it later',
                              style: AppTextStylesPulsePower.s21W300(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 19.h),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                currantPage = value;
              });
            },
            children: [
              Image.asset(
                imageIndex[0],
                alignment: Alignment.topCenter,
                width: double.infinity.w,
                height: double.infinity.h,
                fit: BoxFit.cover,
              ),
              Image.asset(
                imageIndex[1],
                alignment: Alignment.bottomCenter,
                width: double.infinity.w,
                height: double.infinity.h,
                fit: BoxFit.cover,
              ),
              Image.asset(
                imageIndex[2],
                alignment: Alignment.bottomCenter,
                width: double.infinity.w,
                height: double.infinity.h,
                fit: BoxFit.cover,
              ),
            ],
          ),
          0 < currantPage
              ? Positioned(
                  top: 65,
                  left: 33,
                  child: InkWell(
                    onTap: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 23,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
