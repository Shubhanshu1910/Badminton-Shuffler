import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/session_model.dart';
import '../providers/session_provider.dart';
import 'assign_players_page.dart';
import 'assign_courts_page.dart';
import 'match_page.dart';

class SessionDetailsPage extends ConsumerWidget {
  final SessionModel session;

  const SessionDetailsPage({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text(session.title),
              subtitle: Text(session.description ?? ""),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Session Information",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Status"),
              trailing: Text(session.status),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.sports_tennis),
              title: const Text("Courts"),
              trailing: Text(
                session.totalCourts.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Maximum Players"),
              trailing: Text(
                session.maxPlayers.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text("Current Round"),
              trailing: Text(
                session.currentRound.toString(),
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// Assign Players
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text("Assign Players"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AssignPlayersPage(
                      session: session,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// Assign Courts
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.sports_tennis),
              label: const Text("Assign Courts"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AssignCourtsPage(
                      session: session,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// Start / Continue Session
          SizedBox(
            height: 55,
            child: session.status == "DRAFT"
                ? ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Start Session"),
                    onPressed: () async {
                      final repo =
                          ref.read(sessionRepositoryProvider);

                      try {
                        await repo.startSession(session.id);

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MatchPage(
                                session: session,
                              ),
                            ),
                            (route) => route.isFirst,
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text("$e"),
                            ),
                          );
                        }
                      }
                    },
                  )
                : ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: Text(
                      "Continue (${session.status})",
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MatchPage(
                            session: session,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}