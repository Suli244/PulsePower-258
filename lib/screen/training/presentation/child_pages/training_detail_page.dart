import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/settings/widget/s_iitem_widget.dart';
import 'package:pulsepower_258/screen/training/presentation/child_pages/training_start_page.dart';
import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_model.dart';
import 'package:pulsepower_258/style/app_colors.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingDetailPage extends StatelessWidget {
  const TrainingDetailPage({super.key, required this.model});
  final TrainingModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrainingDetailPage'),
        backgroundColor: AppColorsPulsePower.color1C1C1C,
        elevation: 10,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
                      text: ' ${model.title}',
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
      body: ListView.separated(
        itemCount: model.trainingPlans.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          return DetailItem(
            trainModel: model.trainingPlans[index],
            index: index + 1,
            model: model,
          );
        },
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({
    super.key,
    required this.trainModel,
    required this.index,
    required this.model,
  });

  final TrainingPlan trainModel;
  final TrainingModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 10),
          DetailBodyWidget(
            trainModel: trainModel,
            model: model,
            index: index,
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
                      trainModel: trainModel,
                      model: model,
                      index: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StartTrainModel {
  final TrainingPlan trainModel;
  final TrainingModel model;
  final int index;

  StartTrainModel(
      {required this.trainModel, required this.model, required this.index});
}

class DetailBodyWidget extends StatefulWidget {
  const DetailBodyWidget({
    super.key,
    required this.trainModel,
    required this.model,
    required this.index,
  });

  final TrainingPlan trainModel;
  final TrainingModel model;
  final int index;

  @override
  State<DetailBodyWidget> createState() => _DetailBodyWidgetState();
}

class _DetailBodyWidgetState extends State<DetailBodyWidget> {
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
                      // border: Border.all(
                      //   width: 1.5,
                      //   color: Colors.white,
                      // ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.model.mainImage,
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
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

class ContainerIntoShadowWidget extends StatelessWidget {
  const ContainerIntoShadowWidget({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.rectangle,
            ),
          ),
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



// Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const PremiumScreen(),
//                     ),
//                   );