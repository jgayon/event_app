import 'package:event_app/pages/event_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../controllers/event_model.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final allEvents = eventController.allEvents;
          final subscribed = eventController.subscribedEvents;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Eventos Cercanos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allEvents.length,
                  itemBuilder: (context, index) {
                    final event = allEvents[index];
                    return _eventCard(event);
                  },
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Eventos Cercanos Inscritos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subscribed.length,
                  itemBuilder: (context, index) {
                    final event = subscribed[index];
                    return _eventCard(event, isSubscribed: true);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _eventCard(Event event, {bool isSubscribed = false}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EventDetailsPage(event: event));
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: isSubscribed ? Colors.green[50] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(event.location),
                const SizedBox(height: 4),
                Text(
                  '${event.dateTime.day}/${event.dateTime.month} - ${event.dateTime.hour}:${event.dateTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}