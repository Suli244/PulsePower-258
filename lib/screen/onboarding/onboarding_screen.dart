import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/appbar_bottom_navigator/appbar_bottom_navigator_screen.dart';
import 'package:pulsepower_258/screen/settings/widget/s_iitem_widget.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Image oneImage;
  late Image twoImage;
  late Image threeImage;

  @override
  void initState() {
    super.initState();
    oneImage = Image.asset(
      AppImages.onboardingOne,
      alignment: Alignment.topCenter,
      width: double.infinity.w,
      height: double.infinity.h,
      fit: BoxFit.cover,
    );
    twoImage = Image.asset(
      AppImages.onboardingTwo,
      alignment: Alignment.bottomCenter,
      width: double.infinity.w,
      height: double.infinity.h,
      fit: BoxFit.cover,
    );
    threeImage = Image.asset(
      AppImages.onboardingThree,
      alignment: Alignment.bottomCenter,
      width: double.infinity.w,
      height: double.infinity.h,
      fit: BoxFit.cover,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(oneImage.image, context);
    precacheImage(twoImage.image, context);
    precacheImage(threeImage.image, context);
  }

  final PageController controller = PageController();
  int currantPage = 0;

  List<String> imageIndex = [
    AppImages.onboardingOne,
    AppImages.onboardingTwo,
    AppImages.onboardingThree,
  ];

  List<String> titleIndex = [
    'Welcome to the workout app. Work\nout, lose weight and get better!',
    'You can training the whole body at\nonce or choose any section you are \ninterested in',
    'Premium will open access to all the\nfunctions of the application - more\nworkouts, more pounds lost',
  ];

  bool isLoading = false;

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
                const Text(
                  'FlowOn workout',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree-Regular',
                  ),
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
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree-Regular',
                    ),
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
                  isLoading: isLoading,
                  title:
                      currantPage == 2 ? 'Buy Premium for 0.99\$' : 'Continue',
                  onTap: () async {
                    if (currantPage == 2) {
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
                              final prefs =
                                  await SharedPreferences.getInstance();
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
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AppbarBottomNavigatorScreen(),
                            ),
                            (route) => false,
                          );
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
              oneImage,
              twoImage,
              threeImage,
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
