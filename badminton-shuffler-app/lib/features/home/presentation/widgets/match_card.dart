import 'package:badminton_shuffler_app/features/home/presentation/pages/score_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/match_model.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;

  const MatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              "Court ${match.courtNumber}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            const Text(
              "Team A",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            ...match.teamA.map(
              (player) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(player.name),
                subtitle:
                    Text("Skill ${player.skillLevel}"),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "VS",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Team B",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            ...match.teamB.map(
              (player) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(player.name),
                subtitle:
                    Text("Skill ${player.skillLevel}"),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.sports_score),
                label: const Text(
                  "Enter Score",
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScorePage(
                        match: match,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}