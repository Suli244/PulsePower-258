import 'package:hive/hive.dart';

part 'train_hive_model.g.dart';

@HiveType(typeId: 1)
class TrainHiveModel extends HiveObject {
  @HiveField(0)
  int calory;

  @HiveField(1)
  String date;

  @HiveField(2)
  String title;

  @HiveField(3)
  int index;

  TrainHiveModel({
    required this.calory,
    required this.date,
    required this.title,
    required this.index,
  });

  @override
  String toString() {
    return date;
  }
}
