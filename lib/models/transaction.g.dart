// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction()
      ..name = fields[0] as String
      ..adverseReaction = fields[1] as String
      ..overdossage = fields[2] as String
      ..description = fields[3] as String
      ..medId = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.adverseReaction)
      ..writeByte(2)
      ..write(obj.overdossage)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.medId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
