// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdfsdfs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewPosterModelAdapter extends TypeAdapter<ADfsdfs> {
  @override
  final int typeId = 5;

  @override
  ADfsdfs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ADfsdfs(
      secondUrl: fields[0] as String,
      isOpen: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ADfsdfs obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.secondUrl)
      ..writeByte(1)
      ..write(obj.isOpen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewPosterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
