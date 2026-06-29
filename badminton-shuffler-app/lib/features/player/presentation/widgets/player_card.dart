import 'package:flutter/material.dart';

import '../../data/models/player_model.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel player;

  const PlayerCard({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(player.name),
        subtitle: Text(
          "Skill ${player.skillLevel}",
        ),
        trailing: Text(
          "Played ${player.gamesPlayed}",
        ),
      ),
    );
  }
}