part of 'event_model.dart';

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 0;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = Map<int, dynamic>.fromIterable(
      List.generate(numOfFields, (_) => reader.readByte()),
      key: (k) => k,
      value: (_) => reader.read(),
    );

    return Event(
      id: fields[0] as String,
      title: fields[1] as String,
      location: fields[2] as String,
      dateTime: fields[3] as DateTime,
      description: fields[4] as String,
      maxParticipants: fields[5] as int,
      currentParticipants: fields[6] as int,
      subscribed: fields[7] as bool,
      reviews: (fields[8] as List).cast<Review>(),
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.maxParticipants)
      ..writeByte(6)
      ..write(obj.currentParticipants)
      ..writeByte(7)
      ..write(obj.subscribed)
      ..writeByte(8)
      ..write(obj.reviews);
  }
}

class ReviewAdapter extends TypeAdapter<Review> {
  @override
  final int typeId = 1;

  @override
  Review read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = Map<int, dynamic>.fromIterable(
      List.generate(numOfFields, (_) => reader.readByte()),
      key: (k) => k,
      value: (_) => reader.read(),
    );

    return Review(
      comment: fields[0] as String,
      rating: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Review obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.comment)
      ..writeByte(1)
      ..write(obj.rating);
  }
}