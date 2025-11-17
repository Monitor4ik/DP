import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/mqtt_service.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MqttService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Assistant Lite',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
