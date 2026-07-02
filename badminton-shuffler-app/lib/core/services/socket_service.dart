import 'package:socket_io_client/socket_io_client.dart'
as io;

import '../../app/constants/api_constants.dart';

class SocketService {
  SocketService._();

  static final SocketService instance = SocketService._();

  late io.Socket socket;

  void connect() {
    socket = io.io(
      ApiConstants.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }


  void joinSession(
      String sessionId,
      String userName,
      ) {
    socket.emit(
      'join-session',
      {
        'sessionId': sessionId,
        'userName': userName,
      },
    );
  }

  void onRoundGenerated(
      Function(dynamic) callback,
      ) {
    socket.on(
      'round-generated',
      callback,
    );
  }

  void onScoreUpdated(
      Function(dynamic) callback,
      ) {
    socket.on(
      'score-updated',
      callback,
    );
  }
}