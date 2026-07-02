import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/match_model.dart';
import '../providers/game_provider.dart';

class ScorePage extends ConsumerStatefulWidget {
  final MatchModel match;

  const ScorePage({
    super.key,
    required this.match,
  });

  @override
  ConsumerState<ScorePage> createState() =>
      _ScorePageState();
}

class _ScorePageState
    extends ConsumerState<ScorePage> {
  int scoreA = 0;
  int scoreB = 0;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Court ${widget.match.courtNumber}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Team A",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...widget.match.teamA.map(
              (e) => Text(
                e.name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              scoreA.toString(),
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),

            Slider(
              min: 0,
              max: 30,
              divisions: 30,
              value: scoreA.toDouble(),
              onChanged: (v) {
                setState(() {
                  scoreA = v.toInt();
                });
              },
            ),

            const Divider(height: 40),

            const Text(
              "Team B",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...widget.match.teamB.map(
              (e) => Text(
                e.name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              scoreB.toString(),
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),

            Slider(
              min: 0,
              max: 30,
              divisions: 30,
              value: scoreB.toDouble(),
              onChanged: (v) {
                setState(() {
                  scoreB = v.toInt();
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
               onPressed: loading
    ? null
    : () async {
        setState(() {
          loading = true;
        });

        try {
          final repo = ref.read(gameRepositoryProvider);

          // Update Score
          await repo.updateScore(
            widget.match.matchId,
            scoreA,
            scoreB,
          );

          // Finish Match
          await repo.finishGame(
            widget.match.matchId,
            scoreA > scoreB ? 1 : 2,
          );

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Match Completed"),
              ),
            );

            Navigator.pop(context, true);
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        } finally {
          if (mounted) {
            setState(() {
              loading = false;
            });
          }
        }
      },
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Save Score",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}