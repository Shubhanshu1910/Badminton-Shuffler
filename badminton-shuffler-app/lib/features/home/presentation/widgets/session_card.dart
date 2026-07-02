import 'package:badminton_shuffler_app/features/home/presentation/widgets/active_session_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/session_model.dart';
import '../providers/session_provider.dart';
import '../pages/session_details_page.dart';

class SessionCard extends ConsumerWidget {
  final SessionModel session;

  const SessionCard({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SessionDetailsPage(
                session: session,
              ),
            ),
          );
        },
        leading: const CircleAvatar(
          child: Icon(Icons.event),
        ),
        title: Text(session.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status : ${session.status}"),
            Text(
                "Courts : ${session.totalCourts}"),
            Text(
                "Players : ${session.maxPlayers}"),
            Text(
                "Round : ${session.currentRound}"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddSessionPage(
                      session: session,
                    ),
                  ),
                );

                ref.invalidate(sessionProvider);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                final confirm =
                    await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                        "Delete Session"),
                    content: Text(
                        "Delete ${session.title}?"),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, false),
                        child:
                            const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, true),
                        child:
                            const Text("Delete"),
                      ),
                    ],
                  ),
                );

                if (confirm != true) return;

                await ref
                    .read(
                        sessionRepositoryProvider)
                    .deleteSession(
                        session.id);

                ref.invalidate(
                    sessionProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}