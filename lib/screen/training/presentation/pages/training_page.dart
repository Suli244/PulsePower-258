import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulsepower_258/screen/training/data/models_data/train_model.dart';
import 'package:pulsepower_258/screen/training/presentation/child_pages/training_detail_page.dart';
import 'package:pulsepower_258/screen/training/presentation/cubit/training_cubit.dart';
import 'package:pulsepower_258/utils/image/app_images.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  List<String> testList = [
    'Begginer',
    'sdf',
    'sdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
    'asdfasdf',
  ];

  @override
  void initState() {
    super.initState();
    context.read<TrainingCubit>().getListPlans();
  }

  pushToDetailPage(TrainingModelV2 model) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingDetailPage(
          model: model,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: BlocBuilder<TrainingCubit, TrainingState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return const SizedBox.shrink();
            },
            success: (models) {
              log('data: models: ${models[1].isPremium} ');
              final filtered = List<TrainingModelV2>.from(models)..removeAt(0);
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 33,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => pushToDetailPage(models.first),
                      child: Container(
                          width: 356,
                          height: 121,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(models.first.mainImage),
                            ),
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
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: filtered.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final model = filtered[index];
                        return GestureDetector(
                          onTap: () => pushToDetailPage(model),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.red,
                              image: DecorationImage(
                                image: NetworkImage(
                                  model.mainImage,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 11,
                              right: 11,
                            ),
                            width: 170,
                            height: 170,
                            child: Text(
                              model.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.33,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
            loading: () {
              return const CircularProgressIndicator.adaptive();
            },
            error: (e) {
              return Center(child: Text(e.toString()));
            },
          );
        },
      ),
    );
  }
}
