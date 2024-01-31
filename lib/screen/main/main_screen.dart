import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/main/cubit/main_cubit_cubit.dart';
import 'package:pulsepower_258/screen/settings/widget/settings_iitem_widget.dart';
import 'package:pulsepower_258/screen/training/presentation/child_pages/training_detail_page.dart';
import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_model.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../training/presentation/child_pages/training_start_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController scrollController;
  bool isPrem = true;
  bool viewTraining = false;
  isPremis() async {
    final prefs = await SharedPreferences.getInstance();
    isPrem = prefs.getBool('ISBUY') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    isPremis();
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      height: double.infinity.h,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AppImages.bo,
          ),
        ),
      ),
      child: BlocProvider(
        create: (context) => MainCubitCubit()..getListPlans(),
        child: BlocBuilder<MainCubitCubit, MainCubitState>(
          builder: (context, state) => state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (model, trainingData, show) => SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const Text("Welcome!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xffFFFFFF).withOpacity(0.5),
                              const Color(0xffFFFFFF).withOpacity(0)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                            color: const Color(0xff000000).withOpacity(0.5),
                          )
                        ]),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xff444444),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 54,
                            // height: 56,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color:
                                    const Color(0xff1D1D1D).withOpacity(0.63),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 4),
                                    color: const Color(0xff000000)
                                        .withOpacity(0.25),
                                  )
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("0",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                                Text("Calories burned",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.6))),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: MediaQuery.of(context).size.width - 54,
                            // height: 56,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color:
                                    const Color(0xff1D1D1D).withOpacity(0.63),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 4),
                                    color: const Color(0xff000000)
                                        .withOpacity(0.25),
                                  )
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("0",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                                Text("Calories burned",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.6))),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (trainingData == null || trainingData.isEmpty)
                    const SizedBox(height: 8),
                  if (trainingData == null || trainingData.isEmpty)
                    const Text("Start your first training!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  if (trainingData == null || trainingData.isEmpty)
                    const SizedBox(height: 8),
                  if (trainingData == null || trainingData.isEmpty)
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingStartPage(
                            detailModel: StartTrainModel(
                              trainModel: model[0].trainingPlans[0],
                              model: model[0],
                              index: 1,
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                          width: double.infinity,
                          height: 121,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(model.first.mainImage),
                            ),
                            // image: s
                          ),
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 11,
                            right: 11,
                          ),
                          child: const Text(
                            'Beginner',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Bai Jamjuree',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.33,
                            ),
                          )),
                    ),
                  const SizedBox(height: 11),
                  const Text("Training of the day",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  const SizedBox(height: 11),
                  const Divider(
                    height: 1,
                    color: Color(0xff696969),
                  ),
                  const SizedBox(height: 16),
                  TrainingPlane(
                    trainModel: model[0].trainingPlans[0],
                    model: model[0],
                    index: 1,
                  ),
                  const SizedBox(height: 12),
                  SettingsIitemWidget(
                    title: 'View',
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingStartPage(
                            detailModel: StartTrainModel(
                              trainModel: model[0].trainingPlans[0],
                              model: model[0],
                              index: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (trainingData == null || trainingData.isEmpty)
                    const SizedBox(height: 50),
                  if (trainingData != null && trainingData.isNotEmpty)
                    const Text("You've been doing it before...",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  if (trainingData != null && trainingData.isNotEmpty)
                    const SizedBox(height: 11),
                  if (trainingData != null && trainingData.isNotEmpty)
                    const Divider(
                      height: 1,
                      color: Color(0xff696969),
                    ),
                  if (trainingData != null && trainingData.isNotEmpty)
                    const SizedBox(height: 11),
                  if (trainingData != null && trainingData.isNotEmpty)
                    Row(
                      children: [
                        GestureDetector(
                          // onTap: () => pushToDetailPage(model),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(
                                  model[2].mainImage,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 11,
                              right: 11,
                            ),
                            width: (MediaQuery.of(context).size.width - 52) / 2,
                            height:
                                (MediaQuery.of(context).size.width - 52) / 2,
                            child: Text(
                              model[2].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.33,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          // onTap: () => pushToDetailPage(model),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(
                                  model[3].mainImage,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 11,
                              right: 11,
                            ),
                            width: (MediaQuery.of(context).size.width - 52) / 2,
                            height:
                                (MediaQuery.of(context).size.width - 52) / 2,
                            child: Text(
                              model[3].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.33,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (trainingData != null && trainingData.isNotEmpty)
                    const SizedBox(
                      height: 14,
                    ),
                  if (trainingData != null && trainingData.isNotEmpty && isPrem)
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: trainingData.length < 3
                          ? trainingData.length
                          : show
                              ? trainingData.length
                              : 3,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width - 36,
                          height: 89,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xff444444)),
                          child: Row(
                            children: [
                              Container(
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
                                      trainingData[index].image,
                                    ),
                                  ),
                                ),
                                height:
                                    (MediaQuery.of(context).size.width - 60) /
                                        2,
                                width: 75,
                                alignment: Alignment.center,
                                child: FittedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        trainingData[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Bai Jamjuree',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.33,
                                        ),
                                      ),
                                      Text(
                                        trainingData[index].index.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Bai Jamjuree',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.33,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const VerticalDivider(
                                width: 1,
                                color: Color(0xff696969),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: 'Training plane ',
                                              ),
                                              TextSpan(
                                                  text:
                                                      trainingData[index].title,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Text(
                                            trainingData[index].date ??
                                                '07.10.2023 20:05',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  if (trainingData != null && trainingData.isNotEmpty && isPrem)
                    const SizedBox(height: 16),
                  if (trainingData != null && trainingData.isNotEmpty && isPrem)
                    SettingsIitemWidget(
                      title: show ? 'Page up' : 'View more',
                      onTap: () async {
                        if (show) {
                          scrollController.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                        context.read<MainCubitCubit>().viewTraining(!show);
                      },
                    ),
                  if (trainingData != null && trainingData.isNotEmpty && isPrem)
                    const SizedBox(height: 40)
                ],
              ),
            ),
            error: (error) => Text(error),
          ),
        ),
      ),
    );
  }
}

class TrainingPlane extends StatefulWidget {
  const TrainingPlane({
    super.key,
    required this.trainModel,
    required this.model,
    required this.index,
  });

  final TrainingPlan trainModel;
  final TrainingModel model;
  final int index;

  @override
  State<TrainingPlane> createState() => _TrainingPlaneState();
}

class _TrainingPlaneState extends State<TrainingPlane> {
  bool isPrem = true;
  isPremis() async {
    final prefs = await SharedPreferences.getInstance();
    isPrem = prefs.getBool('ISBUY') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    isPremis();
    super.initState();
  }

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
                      text: 'Training plane',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Bai Jamjuree',
                        letterSpacing: -0.33,
                      ),
                    ),
                    TextSpan(
                      text: ' ${widget.model.title} ${widget.index}',
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            // height: (MediaQuery.of(context).size.width - 44) / 2,
            child: Stack(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TrainingPlaneItemWIdget(
                          title: widget.trainModel.totalTime.toString(),
                          desc: 'Min',
                        ),
                        const SizedBox(height: 6),
                        TrainingPlaneItemWIdget(
                          title: widget.trainModel.kkall.toString(),
                          desc: 'Kcal',
                        ),
                        const SizedBox(height: 6),
                        TrainingPlaneItemWIdget(
                          title: widget.trainModel.exerciseCount.toString(),
                          desc: 'Exercises',
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.red,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          widget.model.mainImage,
                        ),
                      ),
                    ),
                    // height: (MediaQuery.of(context).size.width - 60) / 2,
                    width: (MediaQuery.of(context).size.width - 60) / 2,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.trainModel.isPremium && !isPrem
                              ? Image.asset(
                                  AppImages.lockIcon,
                                  scale: 4,
                                )
                              : Text(
                                  widget.model.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.33,
                                  ),
                                ),
                          Text(
                            widget.trainModel.isPremium && !isPrem
                                ? 'Premium'
                                : widget.index.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.trainModel.isPremium && !isPrem
                                  ? 20
                                  : 50,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TrainingPlaneItemWIdget extends StatelessWidget {
  const TrainingPlaneItemWIdget({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        decoration: BoxDecoration(
          color: const Color(0xff1D1D1D).withOpacity(0.63),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 4),
              color: const Color(0xff000000).withOpacity(0.25),
            )
          ],
        ),
        padding: const EdgeInsets.only(top: 5, bottom: 2),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Bai Jamjuree',
                fontWeight: FontWeight.w400,
              ),
            ),
            Opacity(
              opacity: 0.60,
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Bai Jamjuree',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ));
  }
}
