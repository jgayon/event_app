import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../controllers/event_model.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({super.key, required this.event});

  final TextEditingController feedbackController = TextEditingController();
  final RxInt rating = 0.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();

    bool isPast = event.dateTime.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.description),
              const SizedBox(height: 12),
              Text('${event.location} • ${event.dateTime}'),
              const SizedBox(height: 12),
              Obx(() => ElevatedButton(
                onPressed: () => controller.toggleSubscription(event),
                child: Text(event.subscribed ? 'Cancelar Suscripción' : 'Suscribirse'),
              )),
              const SizedBox(height: 20),
              Text('Reseñas:'),
              ...event.reviews.map((r) => ListTile(
                    leading: Icon(Icons.star, color: Colors.amber),
                    title: Text('${r.rating} estrellas'),
                    subtitle: Text(r.comment),
                  )),
              if (isPast) ...[
                const SizedBox(height: 20),
                TextField(
                  controller: feedbackController,
                  decoration: const InputDecoration(labelText: 'Escribe una reseña'),
                ),
                const SizedBox(height: 8),
                Obx(() => Row(
                  children: List.generate(5, (i) => IconButton(
                    icon: Icon(
                      i < rating.value ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () => rating.value = i + 1,
                  )),
                )),
                ElevatedButton(
                  onPressed: () {
                    if (feedbackController.text.isNotEmpty && rating.value > 0) {
                      controller.addReview(event, Review(
                        rating: rating.value,
                        comment: feedbackController.text,
                      ));
                      feedbackController.clear();
                      rating.value = 0;
                    }
                  },
                  child: const Text('Enviar reseña'),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
