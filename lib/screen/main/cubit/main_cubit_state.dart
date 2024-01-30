part of 'main_cubit_cubit.dart';

@freezed
class MainCubitState with _$MainCubitState {
  const factory MainCubitState.loading() = _Loading;
  const factory MainCubitState.loaded(
      {required List<TrainingModel> model,
      List? trainignData,
      required bool showTraining}) = _Loaded;
  const factory MainCubitState.error(String message) = _Error;
}
