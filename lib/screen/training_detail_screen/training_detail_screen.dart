import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pulsepower_258/screen/training/presentation/child_pages/training_detail_page.dart';
import 'package:pulsepower_258/screen/training_detail_screen/hive_model/train_hive_model.dart';
import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_model.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrainingDetailScreen extends StatefulWidget {
  const TrainingDetailScreen({
    super.key,
    required this.model,
    required this.title,
    required this.index,
    required this.mainImage,
  });
  final TrainingPlan model;
  final String title;
  final int index;
  final String mainImage;

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  final PageController controller = PageController();

  int _currentPhase = 0; // 0 - готовность, 1 - тренировка, 2 - отдых
  int _secondsRemaining = 5; // начальное время для готовности
  int _totalTrainingTime = 0;
  bool _isPaused = false;
  bool _isFinished = false;

  late int allExerciseIndex = 0;
  late int krug = 1;
  late int trainSeconds = widget.model.seconds;
  late int restSeconds = 60 - widget.model.seconds;
  // late int trainSeconds = 1;
  // late int restSeconds = 1;
  late Timer timer;
  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!_isPaused) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
            if (_currentPhase == 1) {
              _totalTrainingTime++;
            } else if (_currentPhase == 2) {
              _totalTrainingTime++;
            }
          } else {
            _handlePhaseTransition();
          }
        });
      }
    });
  }

  void _handlePhaseTransition() {
    switch (_currentPhase) {
      case 0: // готовность -> тренировка
        setState(() {
          _currentPhase = 1;
          _secondsRemaining = trainSeconds;
        });
        break;
      case 1: // тренировка -> отдых
        setState(
          () {
            _currentPhase = 2;
            _secondsRemaining = restSeconds;
          },
        );
        break;
      case 2: // отдых -> тренировка (и так далее)
        setState(() {
          _currentPhase = 1;
          _secondsRemaining = trainSeconds;
          if (krug < widget.model.approaches + 1) {
            allExerciseIndex++;
            if (allExerciseIndex < widget.model.exerciseCount) {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            } else {
              krug++;
              allExerciseIndex = 0;
              controller.jumpTo(
                allExerciseIndex.toDouble(),
              );
            }
          }
          if (krug == widget.model.approaches + 1 &&
              allExerciseIndex == 0 &&
              _totalTrainingTime == (widget.model.totalTime * 60)) {
            _isFinished = true;
            timer.cancel();
          }
        });
        break;
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  String formatMinutes(int minutes) {
    int remainingMinutes = minutes % 60;

    String formattedMinutes = remainingMinutes.toString().padLeft(2, '0');

    return '$formattedMinutes:00';
  }

  String formatSeconds(int seconds) {
    if (seconds < 0) {
      throw ArgumentError(
          'Invalid value for seconds. Must be greater than or equal to 0.');
    }

    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }

  double procent(int mush, int total) {
    if (total != 0) {
      if ((total * 100 / mush) / 100 > 1) {
        return 1;
      } else {
        return (total * 100 / mush) / 100;
      }
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    String phaseText = '';
    switch (_currentPhase) {
      case 0:
        phaseText = 'READY?';
        break;
      case 1:
        phaseText = 'TRAINING!';
        break;
      case 2:
        phaseText = 'REST';
        break;
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  if (!_isFinished)
                    GestureDetector(
                      onTap: _togglePause,
                      child: Image.asset(
                        _isPaused ? AppImages.resumeIcon : AppImages.beginIcon,
                        height: 20.h,
                      ),
                    ),
                  const Spacer(),
                  const Text(
                    'Training plane ',
                    style: TextStyle(
                      fontFamily: 'Bai Jamjuree',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Bai Jamjuree',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 19.h),
            LinearPercentIndicator(
              backgroundColor: const Color(0xff6D6D6D),
              percent: procent(
                (widget.model.totalTime * 60),
                _totalTrainingTime,
              ),
              padding: EdgeInsets.zero,
              linearGradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff8A58F4),
                  Color(0xffCB58FF),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
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
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatSeconds(_totalTrainingTime),
                              style: TextStyle(
                                fontFamily: 'Bai Jamjuree',
                                fontSize: 22.h,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              formatMinutes(widget.model.totalTime),
                              style: TextStyle(
                                fontFamily: 'Bai Jamjuree',
                                fontSize: 22.h,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      _isPaused
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: _togglePause,
                                  child: Image.asset(
                                    AppImages.beginIcon,
                                    height: 68.h,
                                  ),
                                ),
                                SizedBox(height: 9.h),
                                Text(
                                  'Paused',
                                  style: TextStyle(
                                    fontFamily: 'Bai Jamjuree',
                                    fontSize: 20.h,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : _isFinished
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: SuccessBodyWidget(
                                    trainModel: widget.model,
                                    title: widget.title,
                                    index: widget.index,
                                    mainImage: widget.mainImage,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      phaseText,
                                      style: TextStyle(
                                        fontFamily: 'Bai Jamjuree',
                                        fontSize: 30.h,
                                        fontWeight: FontWeight.w400,
                                        color: phaseText == 'TRAINING!'
                                            ? const Color(0xffD479FF)
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 19.h),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 52.h,
                                      width: 162.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0x9E1D1D1D),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: phaseText == 'TRAINING!'
                                              ? const Color(0xffD479FF)
                                              : Colors.white.withOpacity(0.52),
                                        ),
                                      ),
                                      child: Text(
                                        _secondsRemaining.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Bai Jamjuree',
                                          fontSize: 30.h,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _isFinished
          ? BottomSheet(
              enableDrag: false,
              onClosing: () {},
              builder: (context) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                height: 250.h,
                width: double.infinity.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                  ),
                  color: AppColorsPulsePower.color272727,
                  // border: Border(
                  //   top: BorderSide(
                  //     color: Colors.white.withOpacity(0.50),
                  //   ),
                  //   left: BorderSide(
                  //     color: Colors.white.withOpacity(0.50),
                  //   ),
                  //   right: BorderSide(
                  //     color: Colors.white.withOpacity(0.50),
                  //   ),
                  // ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 31.h),
                    Text(
                      'CONGRATULATION',
                      style: TextStyle(
                        fontFamily: 'Bai Jamjuree',
                        fontSize: 32.h,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Training complite',
                      style: TextStyle(
                        fontFamily: 'Bai Jamjuree',
                        fontSize: 20.h,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffD479FF),
                      ),
                    ),
                    SizedBox(height: 49.h),
                    GestureDetector(
                      onTap: () async {
                        var trainbox =
                            await Hive.openBox<TrainHiveModel>('tain');
                        final dateNow = DateTime.now();
                        final date =
                            DateFormat('dd.MM.yyyy HH:mm').format(dateNow);
                        trainbox.add(
                          TrainHiveModel(
                            calory: widget.model.kkall,
                            date: date,
                            title: widget.title,
                            index: widget.index,
                            image: widget.mainImage,
                          ),
                        );
                        Navigator.pop(context);
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
                              Color(0xffCB58FF),
                              Color(0xff8A58F4),
                            ],
                          ),
                        ),
                        child: Text(
                          'End training',
                          style: TextStyle(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 22.h,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            )
          : BottomSheet(
              enableDrag: false,
              onClosing: () {},
              builder: (context) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                height: 480.h,
                width: double.infinity.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                  ),
                  color: AppColorsPulsePower.color272727,
                  // border: Border(
                  //   top: BorderSide(
                  //     color: Colors.white.withOpacity(0.50),
                  //   ),
                  //   left: BorderSide(
                  //     color: Colors.white.withOpacity(0.50),
                  //   ),
                  //   right: BorderSide(
                  //     color: Colors.white.withOpacity(0.50),
                  //   ),
                  // ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 11.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Round ',
                          style: TextStyle(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 20.h,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$krug/${widget.model.approaches}',
                          style: TextStyle(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 20.h,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    const Divider(
                      color: Color(0xff696969),
                      thickness: 2,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Press',
                      style: TextStyle(
                        fontFamily: 'Bai Jamjuree',
                        fontSize: 20.h,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        itemCount: 4,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.model.exerciseList[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 118.h,
                              width: 108.w,
                            ),
                            SizedBox(height: 18.h),
                            Flexible(
                              child: Text(
                                widget.model.exerciseList[index].description,
                                maxLines: 3,
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
                      count: widget.model.exerciseList.length,
                      effect: SlideEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.white.withOpacity(0.30),
                        dotHeight: 9.h,
                        dotWidth: 9.w,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    GestureDetector(
                      onTap: () async {
                        var trainbox =
                            await Hive.openBox<TrainHiveModel>('tain');
                        final dateNow = DateTime.now();
                        final date =
                            DateFormat('dd.MM.yyyy HH:mm').format(dateNow);
                        trainbox.add(
                          TrainHiveModel(
                            calory: widget.model.kkall,
                            date: date,
                            title: widget.title,
                            index: widget.index,
                            image: widget.mainImage,
                          ),
                        );
                        Navigator.pop(context);
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
                              Color(0xffA3053E),
                              Color(0xffB72323),
                            ],
                          ),
                        ),
                        child: Text(
                          'End training',
                          style: TextStyle(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 22.h,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class SuccessBodyWidget extends StatefulWidget {
  const SuccessBodyWidget({
    super.key,
    required this.trainModel,
    required this.title,
    required this.index,
    required this.mainImage,
  });

  final TrainingPlan trainModel;
  final String title;
  final int index;
  final String mainImage;

  @override
  State<SuccessBodyWidget> createState() => _SuccessBodyWidgetState();
}

class _SuccessBodyWidgetState extends State<SuccessBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      // height: 227,
      decoration: ShapeDecoration(
        color: const Color(0xFF444444),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x7F000000),
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity.w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(6),
                topLeft: Radius.circular(6),
              ),
              color: Color(0xff535353),
              boxShadow: [
                BoxShadow(
                  color: Color(0x7F000000),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            alignment: Alignment.center,
            height: 41,
            child: FittedBox(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Training plane ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Bai Jamjuree',
                        letterSpacing: -0.33,
                      ),
                    ),
                    TextSpan(
                      text: widget.title,
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
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.red,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.mainImage,
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Bai Jamjuree',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.33,
                            ),
                          ),
                          Text(
                            widget.index.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontFamily: 'Bai Jamjuree',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.33,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      ContainerIntoShadowWidget(
                        title: widget.trainModel.totalTime.toString(),
                        desc: 'Min',
                      ),
                      ContainerIntoShadowWidget(
                        title: widget.trainModel.kkall.toString(),
                        desc: 'Kcal',
                      ),
                      ContainerIntoShadowWidget(
                        title: widget.trainModel.exerciseCount.toString(),
                        desc: 'Exercises',
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
