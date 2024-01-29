part of 'training_cubit.dart';

@freezed
class TrainingState with _$TrainingState {
  const factory TrainingState.initial() = _Initial;
  const factory TrainingState.success(List<TrainingModel> model) = _Success;
  const factory TrainingState.loading() = _Loading;
  const factory TrainingState.error(dynamic exception) = _Error;
}
