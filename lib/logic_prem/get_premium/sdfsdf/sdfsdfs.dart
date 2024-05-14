import 'package:hive/hive.dart';

part 'sdfsdfs.g.dart';

@HiveType(typeId: 5)
class ADfsdfs extends HiveObject {
  @HiveField(0)
  String secondUrl;

  @HiveField(1)
  bool isOpen;
  ADfsdfs({
    required this.secondUrl,
    required this.isOpen,
  });
}
