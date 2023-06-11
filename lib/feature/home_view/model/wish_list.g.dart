// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistModelAdapter extends TypeAdapter<WishlistModel> {
  @override
  final int typeId = 1;

  @override
  WishlistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistModel(
      id: fields[0] as int,
      timestamp: fields[1] as DateTime?,
      open: fields[2] as double?,
      close: fields[5] as double?,
      high: fields[3] as double?,
      low: fields[4] as double?,
      volume: fields[6] as num?,
      whistListAdded: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.open)
      ..writeByte(3)
      ..write(obj.high)
      ..writeByte(4)
      ..write(obj.low)
      ..writeByte(5)
      ..write(obj.close)
      ..writeByte(6)
      ..write(obj.volume)
      ..writeByte(7)
      ..write(obj.whistListAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
