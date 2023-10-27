import 'dart:io';
import 'package:torch_light/torch_light.dart';
import 'package:flutter/material.dart';
// import 'package:battery_plus/battery_plus.dart';

void main() async {
  runApp(const MainApp());
  final server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    8080, // 원하는 포트 번호로 변경
  );
  // var battery = Battery();

  try {
    final isTorchAvailable = await TorchLight.isTorchAvailable();
  } on Exception catch (_) {
    // Handle error
  }

  print('Listening on ${server.address}:${server.port}');

  await for (HttpRequest request in server) {
    if (request.uri.path == '/turnOn') {
      // 손전등 켜기 로직을 여기에 추가

// Be informed when the state (full, charging, discharging) changes
//       battery.onBatteryStateChanged.listen((BatteryState state) {
        // Do something with new state
      // });
      try {
        await TorchLight.enableTorch();
      } on Exception catch (_) {
        // Handle error
      }

      // final batteryLevel = await battery.batteryLevel;
      const batteryLevel = "add batter library";

      request.response.write('Flashlight turned on $batteryLevel');
    } else if (request.uri.path == '/turnOff') {
      // 손전등 끄기 로직을 여기에 추가
      try {
        await TorchLight.disableTorch();
      } on Exception catch (_) {
        // Handle error
      }
      request.response.write('Flashlight turned off');
    } else {
      request.response.write('Invalid command');
    }
    await request.response.close();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}