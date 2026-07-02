import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../player/presentation/providers/player_provider.dart';
import '../../data/models/session_model.dart';
import '../providers/session_provider.dart';

class AssignPlayersPage extends ConsumerStatefulWidget {
  final SessionModel session;

  const AssignPlayersPage({
    super.key,
    required this.session,
  });

  @override
  ConsumerState<AssignPlayersPage> createState() =>
      _AssignPlayersPageState();
}

class _AssignPlayersPageState
    extends ConsumerState<AssignPlayersPage> {
  final List<String> selectedPlayers = [];

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Players"),
      ),
      body: players.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(e.toString())),
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    final player = data[index];

                    return CheckboxListTile(
                      value: selectedPlayers.contains(player.id),
                      title: Text(player.name),
                      subtitle:
                          Text("Skill ${player.skillLevel}"),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedPlayers.add(player.id);
                          } else {
                            selectedPlayers.remove(player.id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("Assign Players"),
                    onPressed: () async {
                      await ref
                          .read(sessionRepositoryProvider)
                          .addPlayers(
                            widget.session.id,
                            selectedPlayers,
                          );

                      ref.invalidate(sessionProvider);

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}