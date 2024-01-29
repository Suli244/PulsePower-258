// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'train_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainHiveModelAdapter extends TypeAdapter<TrainHiveModel> {
  @override
  final int typeId = 1;

  @override
  TrainHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainHiveModel(
      calory: fields[0] as int,
      date: fields[1] as String,
      title: fields[2] as String,
      index: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TrainHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.calory)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
