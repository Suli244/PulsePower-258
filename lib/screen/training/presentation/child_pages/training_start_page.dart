import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/premium/premium_screen.dart';
import 'package:pulsepower_258/screen/training/presentation/child_pages/training_detail_page.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrainingStartPage extends StatefulWidget {
  const TrainingStartPage({super.key, required this.detailModel});
  final StartTrainModel detailModel;

  @override
  State<TrainingStartPage> createState() => _TrainingStartPageState();
}

class _TrainingStartPageState extends State<TrainingStartPage> {
  PageController controller = PageController();
  int currentIndex = 0;
  ValueNotifier customValue = ValueNotifier<String>('Start Training');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColorsPulsePower.color1C1C1C,
        elevation: 10,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          Flexible(
            child: FittedBox(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Training plane',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Bai Jamjuree',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.33,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' ${widget.detailModel.model.title} ${widget.detailModel.index}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Bai Jamjuree',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.33,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            DetailBodyWidget(
              trainModel: widget.detailModel.trainModel,
              model: widget.detailModel.model,
              index: widget.detailModel.index,
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          height: 400.h,
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
          child: Column(
            children: [
              SizedBox(height: 11.h),
              FittedBox(
                child: Text(
                  'The composition of the plan:',
                  style: TextStyle(
                    fontFamily: 'Bai Jamjuree',
                    fontSize: 20.h,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textScaleFactor: FontSizer.textScaleFactor(context),
                ),
              ),
              SizedBox(height: 8.h),
              const Divider(
                color: Color(0xff696969),
                thickness: 2,
              ),
              SizedBox(height: 10.h),
              FittedBox(
                child: Text(
                  'Press',
                  style: TextStyle(
                    fontFamily: 'Bai Jamjuree',
                    fontSize: 20.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textScaleFactor: FontSizer.textScaleFactor(context),
                ),
              ),
              SizedBox(height: 11.h),
              Expanded(
                child: PageView.builder(
                  physics: widget.detailModel.trainModel.isPremium
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: (value) {
                    currentIndex = value;
                    getTitle(value);
                  },
                  itemCount: widget.detailModel.trainModel.exerciseCount,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.detailModel.trainModel
                                    .exerciseList[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 108.w,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Expanded(
                        child: Text(
                          widget.detailModel.trainModel.exerciseList[index]
                              .description,
                          style: TextStyle(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 20.h,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: widget.detailModel.trainModel.exerciseCount,
                effect: SlideEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white.withOpacity(0.30),
                  dotHeight: 9.h,
                  dotWidth: 9.w,
                ),
              ),
              SizedBox(height: 22.h),
              GestureDetector(
                onTap: () {
                  if (widget.detailModel.trainModel.isPremium) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PremiumScreen()),
                    );
                  } else {
                    log('data: controller.page: ${controller.page} ');
                    log('data: widget.detailModel.trainModel.exerciseCount.toDouble(): ${widget.detailModel.trainModel.exerciseList.length.toDouble()} ');
                    if (controller.page! !=
                        (widget.detailModel.trainModel.exerciseCount - 1.0)
                            .toDouble()) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xff8A58F4),
                        Color(0xffCB58FF),
                      ],
                    ),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: customValue,
                    builder: (_, __, child) {
                      return Text(
                        widget.detailModel.trainModel.isPremium
                            ? 'Go to premium'
                            : customValue.value,
                        style: TextStyle(
                          fontFamily: 'Bai Jamjuree',
                          fontSize: 22.h,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  getTitle(int index) {
    if (index + 1 == 1) {
      customValue.value = 'Start training';
    } else if (index + 1 == widget.detailModel.trainModel.exerciseCount) {
      customValue.value = 'End train';
    } else {
      customValue.value = 'Next';
    }
  }
}

final class FontSizer {
  static double textScaleFactor(
    BuildContext context, {
    double maxTextScaleFactor = 2,
  }) {
    double val =
        (MediaQuery.of(context).size.width / 1400) * maxTextScaleFactor;
    return math.max(1, math.min(val, maxTextScaleFactor));
  }
}
