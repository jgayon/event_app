import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'event_model.dart';

class EventController extends GetxController {
  late Box<Event> _eventsBox;

  var allEvents = <Event>[].obs;
  var subscribedEvents = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    _eventsBox = Hive.box<Event>('eventsBox');
    loadEvents();
  }

  void loadEvents() {
    allEvents.assignAll(_eventsBox.values);

    // Si no hay eventos aún, crea algunos por defecto
    if (allEvents.isEmpty) {
      final now = DateTime.now();
      final defaultEvents = List.generate(10, (i) {
        return Event(
          id: 'e$i',
          title: 'Evento ${i + 1}',
          location: 'Sala ${String.fromCharCode(65 + i)}',
          dateTime: now.add(Duration(days: i)),
          description: 'Descripción del evento ${i + 1}',
          maxParticipants: 50, currentParticipants: 13, subscribed: false,
        );
      });

      for (var event in defaultEvents) {
        _eventsBox.put(event.id, event);
      }

      allEvents.assignAll(_eventsBox.values);
    }

    // Cargar suscritos
    subscribedEvents.assignAll(allEvents.where((e) => e.subscribed));
  }

  void toggleSubscription(Event event) {
    final updated = event.copyWith(
      subscribed: !event.subscribed,
      currentParticipants: event.subscribed
          ? event.currentParticipants - 1
          : event.currentParticipants + 1,
    );

    _eventsBox.put(updated.id, updated);
    loadEvents();
  }

  void addReview(Event event, Review review) {
    final updatedReviews = [...event.reviews, review];
    final updated = event.copyWith(reviews: updatedReviews);
    _eventsBox.put(event.id, updated);
    loadEvents();
  }
}
