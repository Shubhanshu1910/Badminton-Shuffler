import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/socket_service.dart';
import '../../data/models/round_response.dart';
import '../../data/models/session_model.dart';
import '../providers/session_provider.dart';
import '../widgets/match_card.dart';

class MatchPage extends ConsumerStatefulWidget {
  final SessionModel session;

  const MatchPage({
    super.key,
    required this.session,
  });

  @override
  ConsumerState<MatchPage> createState() =>
      _MatchPageState();
}

class _MatchPageState
    extends ConsumerState<MatchPage> {

  late Future<RoundResponse> _roundFuture;

  @override
  void initState() {
    super.initState();

    final repo = ref.read(
      sessionRepositoryProvider,
    );

    // Generate only once
    _roundFuture = repo.getCurrentRound(
  widget.session.id,
);

    SocketService.instance.joinSession(
      widget.session.id,
      "Player",
    );

    SocketService.instance.onRoundGenerated((data) {
      debugPrint("Round Generated");

      if (mounted) {
        setState(() {
          _roundFuture = ref
              .read(sessionRepositoryProvider)
              .getCurrentRound(
                widget.session.id,
              );
        });
      }
    });

    SocketService.instance.onScoreUpdated((data) {
      debugPrint("Score Updated");

      if (mounted) {
        setState(() {
        _roundFuture = ref
              .read(sessionRepositoryProvider)
              .getCurrentRound(
                widget.session.id,
              );
        });
      }
    });
  }

  @override
  void dispose() {
    SocketService.instance.socket.off(
      "round-generated",
    );

    SocketService.instance.socket.off(
      "score-updated",
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Round ${widget.session.currentRound + 1}",
        ),
      ),
      body: FutureBuilder<RoundResponse>(
        future: _roundFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No Round Found",
              ),
            );
          }

          final round = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {
              final repo = ref.read(
                sessionRepositoryProvider,
              );

              setState(() {
                _roundFuture = repo.getCurrentRound(
                              widget.session.id,
                            );
              });

              await _roundFuture;
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                Text(
                  "Round ${round.round.roundNumber}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ...round.matches.map(
                  (match) => MatchCard(
                    match: match,
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  "Waiting Players (${round.waitingPlayers.length})",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                if (round.waitingPlayers.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "No Waiting Players",
                        ),
                      ),
                    ),
                  )
                else
                  ...round.waitingPlayers.map(
                    (player) => Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(player.name),
                        subtitle: Text(
                          "Skill ${player.skillLevel}",
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}