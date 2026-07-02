import 'package:badminton_shuffler_app/core/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SocketService.instance.connect();
  runApp(
  const ProviderScope(
    child: BadmintonShufflerApp(),
  ),
);
}