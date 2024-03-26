import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/main/main_screen.dart';
import 'package:pulsepower_258/screen/settings/s_screen.dart';
import 'package:pulsepower_258/screen/training/presentation/cubit/training_cubit.dart';
import 'package:pulsepower_258/screen/training/presentation/pages/training_page.dart';
import 'package:pulsepower_258/style/app_colors.dart';
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
    return BlocProvider(
      create: (context) => TrainingCubit(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                      TabBar(
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: AppColorsPulsePower.colorBCBCBC,
                        labelColor: AppColorsPulsePower.colorD479FF,
                        tabs: [
                          Column(
                            children: [
                              const ImageIcon(
                                AssetImage(
                                  AppImages.mainIcon,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              const Text(
                                'main',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'BaiJamjuree-Regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const ImageIcon(
                                AssetImage(
                                  AppImages.trainingIcon,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              const Text(
                                'Training',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'BaiJamjuree-Regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const ImageIcon(
                                AssetImage(
                                  AppImages.settingsIcon,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              const Text(
                                'Settings',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'BaiJamjuree-Regular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity.w,
                        height: 1,
                        decoration:
                            const BoxDecoration(color: Color(0xFF090909)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: pages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> pages = [
  const MainScreen(),
  const TrainingScreen(),
  const SettingsScreen()
];
