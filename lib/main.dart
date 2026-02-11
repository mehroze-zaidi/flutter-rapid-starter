import 'package:flutter/material.dart';
import 'core/services/connectivity_service.dart';
import 'presentation/app/app_initializer.dart';
import 'presentation/app/your_app.dart';

Future<void> main() async {
  await AppInitializer.initialize();
  await ConnectivityService.instance.initialize();
  runApp(const YourApp());
}
