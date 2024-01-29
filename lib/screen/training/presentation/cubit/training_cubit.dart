
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_model.dart';

part 'training_cubit.freezed.dart';
part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit() : super(const TrainingState.initial());

  final dio = Dio();

  Future<void> getListPlans() async {
    try {
      emit(const TrainingState.loading());
      final result = await dio.get(
          'https://pulsepower-258-default-rtdb.firebaseio.com/trainings.json?auth=AIzaSyD24P-ebB1eOd-43qHV04I0ZPb_8CPXJQE');

      final listModel = result.data.map<TrainingModel>(
        (e) {
          return TrainingModel.fromJson(e);
        },
      ).toList();
      emit(TrainingState.success(listModel));
    } catch (e) {
      emit(TrainingState.error(e));
    }
  }
}
