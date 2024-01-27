import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/main/main_screen.dart';
import 'package:pulsepower_258/screen/settings/settings_screen.dart';
import 'package:pulsepower_258/screen/training/training_screen.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/style/app_text_styles.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';

class AppbarBottomNavigatorScreen extends StatefulWidget {
  const AppbarBottomNavigatorScreen({super.key});

  @override
  State<AppbarBottomNavigatorScreen> createState() =>
      _AppbarBottomNavigatorScreenState();
}

class _AppbarBottomNavigatorScreenState
    extends State<AppbarBottomNavigatorScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 100,
              color: AppColorsPulsePower.color1C1C1C,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                    child: Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 0;
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.mainIcon,
                                width: 22.w,
                                color: index == 0
                                    ? AppColorsPulsePower.colorD479FF
                                    : AppColorsPulsePower.colorBCBCBC,
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                'main',
                                style: AppTextStylesPulsePower.s15W400(
                                  color: index == 0
                                      ? AppColorsPulsePower.colorD479FF
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 55.w),
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.trainingIcon,
                                width: 11.50.w,
                                color: index == 1
                                    ? AppColorsPulsePower.colorD479FF
                                    : AppColorsPulsePower.colorBCBCBC,
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                'Training',
                                style: AppTextStylesPulsePower.s15W400(
                                  color: index == 1
                                      ? AppColorsPulsePower.colorD479FF
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 46.w),
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 2;
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.settingsIcon,
                                width: 22.w,
                                color: index == 2
                                    ? AppColorsPulsePower.colorD479FF
                                    : AppColorsPulsePower.colorBCBCBC,
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                'Settings',
                                style: AppTextStylesPulsePower.s15W400(
                                  color: index == 2
                                      ? AppColorsPulsePower.colorD479FF
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity.w,
                    height: 1,
                    decoration: const BoxDecoration(color: Color(0xFF090909)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: pages[index],
          ),
        ],
      ),
    );
  }
}

List<Widget> pages = [
  const MainScreen(),
  const TrainingScreen(),
  const SettingsScreen()
];

// Container(
//                 child: Row(
//                   children: [
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           index = 0;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             AppImages.mainIcon,
//                             width: 22.w,
//                             color: index == 0
//                                 ? AppColorsPulsePower.colorD479FF
//                                 : AppColorsPulsePower.colorBCBCBC,
//                           ),
//                           SizedBox(height: 3.h),
//                           Text(
//                             'main',
//                             style: AppTextStylesPulsePower.s15W400(
//                               color: index == 0
//                                   ? AppColorsPulsePower.colorD479FF
//                                   : Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 65.w),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           index = 1;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             AppImages.trainingIcon,
//                             width: 11.50.w,
//                             color: index == 1
//                                 ? AppColorsPulsePower.colorD479FF
//                                 : AppColorsPulsePower.colorBCBCBC,
//                           ),
//                           SizedBox(height: 3.h),
//                           Text(
//                             'Training',
//                             style: AppTextStylesPulsePower.s15W400(
//                               color: index == 1
//                                   ? AppColorsPulsePower.colorD479FF
//                                   : Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 55.w),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           index = 2;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             AppImages.settingsIcon,
//                             width: 22.w,
//                             color: index == 2
//                                 ? AppColorsPulsePower.colorD479FF
//                                 : AppColorsPulsePower.colorBCBCBC,
//                           ),
//                           SizedBox(height: 3.h),
//                           Text(
//                             'Settings',
//                             style: AppTextStylesPulsePower.s15W400(
//                               color: index == 2
//                                   ? AppColorsPulsePower.colorD479FF
//                                   : Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),








// Column(
//                     children: [
//                       Container(
//                         width: double.infinity.w,
//                         height: 1,
//                         decoration:
//                             const BoxDecoration(color: Color(0xFF090909)),
//                       ),
//                       Opacity(
//                         opacity: 0.50,
//                         child: Container(
//                           width: 390,
//                           height: 12,
//                           decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment(0.00, -1.00),
//                               end: Alignment(0, 1),
//                               colors: [Color(0x000A0A0A), Color(0xFF0F0F0F)],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),