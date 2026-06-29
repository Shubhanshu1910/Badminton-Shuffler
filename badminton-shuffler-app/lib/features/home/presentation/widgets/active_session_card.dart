import 'package:flutter/material.dart';

import '../../data/models/session_model.dart';

class ActiveSessionCard extends StatelessWidget {
  final SessionModel session;

  const ActiveSessionCard({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(
          session.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(session.status),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_tennis),
            Text("Round ${session.currentRound}"),
          ],
        ),
      ),
    );
  }
}