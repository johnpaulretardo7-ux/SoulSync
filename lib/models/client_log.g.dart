// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientLogAdapter extends TypeAdapter<ClientLog> {
  @override
  final int typeId = 0;

  @override
  ClientLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientLog(
      name: fields[0] as String,
      moodScore: fields[1] as int,
      emotions: (fields[2] as List).cast<String>(),
      influences: (fields[3] as List).cast<String>(),
      physicalSensation: (fields[4] as List).cast<String>(),
      wellbeingActions: (fields[5] as List).cast<String>(),
      endOfDayNote: fields[6] as String,
      timestamp: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ClientLog obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.moodScore)
      ..writeByte(2)
      ..write(obj.emotions)
      ..writeByte(3)
      ..write(obj.influences)
      ..writeByte(4)
      ..write(obj.physicalSensation)
      ..writeByte(5)
      ..write(obj.wellbeingActions)
      ..writeByte(6)
      ..write(obj.endOfDayNote)
      ..writeByte(7)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
