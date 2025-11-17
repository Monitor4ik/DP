import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/foundation.dart';

class MqttService extends ChangeNotifier {
  late MqttServerClient client;
  bool connected = false;
  String lastMessage = "";

  Future<void> connect() async {
    client = MqttServerClient('test.mosquitto.org', 'flutter_client');
    client.port = 1883;
    client.keepAlivePeriod = 30;
    client.logging(on: false);

    client.onConnected = () {
      connected = true;
      notifyListeners();
    };

    client.onDisconnected = () {
      connected = false;
      notifyListeners();
    };

    client.onSubscribed = (topic) {};

    final connMess = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (e) {
      client.disconnect();
    }

    client.subscribe("home/#", MqttQos.atMostOnce);

    client.updates!.listen((events) {
      final recMess = events.first.payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      lastMessage = "${events.first.topic}: $payload";
      notifyListeners();
    });
  }

  void publish(String topic, String msg) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }
}
