import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/player_provider.dart';
import '../widgets/player_card.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final players =
        ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Players"),
      ),
      body: players.when(
        loading: () => const Center(
          child:
              CircularProgressIndicator(),
        ),

        error: (e, _) =>
            Center(child: Text("$e")),

        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text(
                "No Players",
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return PlayerCard(
                player: data[index],
              );
            },
          );
        },
      ),
    );
  }
}