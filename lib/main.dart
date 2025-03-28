import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/event_controller.dart';
import 'pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'controllers/event_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(ReviewAdapter());

  await Hive.openBox<Event>('eventsBox');

  runApp(const EventApp());
}

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Event App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
      initialBinding: BindingsBuilder(() {
        Get.put(EventController());
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}