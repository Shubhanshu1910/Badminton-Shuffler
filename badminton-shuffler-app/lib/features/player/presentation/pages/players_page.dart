import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/player_provider.dart';
import '../widgets/player_card.dart';

class PlayersPage extends ConsumerStatefulWidget {
  const PlayersPage({super.key});

  @override
  ConsumerState<PlayersPage> createState() =>
      _PlayersPageState();
}

class _PlayersPageState
    extends ConsumerState<PlayersPage> {
  final searchController =
      TextEditingController();

  String search = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final players =
        ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Players"),
      ),
      body: Column(
        children: [
          Padding(
  padding: const EdgeInsets.all(16),
  child: TextField(
    controller: searchController,
    decoration: InputDecoration(
      hintText: "Search Player...",
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onChanged: (value) {
      setState(() {
        search = value.toLowerCase();
      });
    },
  ),
),
Expanded(
            child: players.when(
              loading: () =>
                  const Center(
                child:
                    CircularProgressIndicator(),
              ),

              error: (e, _) =>
                  Center(
                child: Text("$e"),
              ),

              data: (data) {
                final filtered =
                    data.where((player) {
                  return player.name
                      .toLowerCase()
                      .contains(search);
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text(
                        "No Players Found"),
                  );
                }

                return ListView.builder(
                  itemCount:
                      filtered.length,
                  itemBuilder:
                      (_, index) {
                    return PlayerCard(
                      player:
                          filtered[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}