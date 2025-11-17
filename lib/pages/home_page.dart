import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mqtt_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mqtt = context.watch<MqttService>();

    return Scaffold(
      appBar: AppBar(title: const Text("Home Assistant Lite")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MQTT status: ${mqtt.connected ? "Connected" : "Disconnected"}"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => mqtt.connect(),
              child: const Text("Connect"),
            ),
            const SizedBox(height: 24),
            const Text("Last message:"),
            Text(mqtt.lastMessage),
            const SizedBox(height: 24),
            const Text("Send test message:"),
            ElevatedButton(
              onPressed: () => mqtt.publish("home/test", "hello from flutter"),
              child: const Text("Publish"),
            )
          ],
        ),
      ),
    );
  }
}
