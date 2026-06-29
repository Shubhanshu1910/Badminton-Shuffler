import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/socket_service.dart';

final socketProvider =
Provider<SocketService>((ref) {
  final socket = SocketService();

  socket.connect();

  ref.onDispose(() {
    socket.disconnect();
  });

  return socket;
});