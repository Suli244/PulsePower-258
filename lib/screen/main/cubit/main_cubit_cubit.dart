import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulsepower_258/screen/training_detail_screen/hive_model/train_hive_model.dart';
import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_model.dart';

part 'main_cubit_cubit.freezed.dart';
part 'main_cubit_state.dart';

class MainCubitCubit extends Cubit<MainCubitState> {
  MainCubitCubit() : super(const MainCubitState.loading());

  final dio = Dio();
  bool showTraining = false;
  List<TrainingModel> model = [];
  List<dynamic>? trainList = [];
  int kkal = 0;

  Future<void> getListPlans() async {
    try {
      emit(const MainCubitState.loading());
      final trainResult = await dio.get(
          'https://pulsepower-258-default-rtdb.firebaseio.com/trainings.json?auth=AIzaSyD24P-ebB1eOd-43qHV04I0ZPb_8CPXJQE');

      model = trainResult.data.map<TrainingModel>(
        (e) {
          return TrainingModel.fromJson(e);
        },
      ).toList();

      // final data = await getLastData(key: 'tain');
      // var trainbox = Hive.box<TrainHiveModel>('tain');
      Box? trainbox;
      if (Hive.isBoxOpen('tain')) {
        trainbox = Hive.box<TrainHiveModel>('tain');
      } else {
        trainbox = await Hive.openBox<TrainHiveModel>('tain');
      }

      trainList = trainbox.values.toList();
      // if (trainbox.isOpen) {
      //   await trainbox.close();
      // }
      if (trainList != null && trainList is List<TrainHiveModel>) {
        for (final e in trainList!) {
          kkal = kkal + e.calory as int;
        }
      }
      emit(MainCubitState.loaded(
          model: model,
          trainignData: trainList,
          showTraining: showTraining,
          kkal: kkal));
    } catch (e) {
      emit(MainCubitState.error(e.toString()));
    }
  }

  viewTraining(bool show) {
    showTraining = show;
    emit(MainCubitState.loaded(
        model: model, trainignData: trainList, showTraining: show, kkal: kkal));
  }
}
