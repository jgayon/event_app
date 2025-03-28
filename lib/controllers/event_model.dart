import 'package:hive/hive.dart';

part 'event_model.g.dart'; // Este archivo se generará automáticamente

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String location;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final int maxParticipants;

  @HiveField(6)
  final int currentParticipants;

  @HiveField(7)
  final bool subscribed;

  @HiveField(8)
  final List<Review> reviews;

  Event({
    required this.id,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.description,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.subscribed,
    this.reviews = const [],
  });

  bool get hasPassed => dateTime.isBefore(DateTime.now());

  Event copyWith({
    String? id,
    String? title,
    String? location,
    DateTime? dateTime,
    String? description,
    int? maxParticipants,
    int? currentParticipants,
    bool? subscribed,
    List<Review>? reviews,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      subscribed: subscribed ?? this.subscribed,
      reviews: reviews ?? this.reviews,
    );
  }
}

@HiveType(typeId: 1)
class Review extends HiveObject {
  @HiveField(0)
  final String comment;

  @HiveField(1)
  final int rating;

  Review({
    required this.comment,
    required this.rating,
  });
}
