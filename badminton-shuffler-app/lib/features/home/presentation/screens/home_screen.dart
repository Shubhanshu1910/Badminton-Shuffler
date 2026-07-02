// import 'package:badminton_shuffler_app/features/player/presentation/pages/players_page.dart';
import '../../../court/presentation/pages/courts_page.dart';
import '../../../player/presentation/pages/add_player_page.dart';
import '../../../player/presentation/pages/players_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../player/presentation/providers/player_provider.dart';
import '../../../splash/presentation/pages/splash_page.dart';
import '../providers/session_provider.dart';
import '../widgets/session_card.dart';
import '../../../../shared/widgets/quick_action_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionProvider);
    final players = ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Badminton Shuffler"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(sessionProvider);
            },
          ),
        ],
      ),

      body: sessions.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),

        error: (e, _) =>
            Center(child: Text(e.toString())),

        data: (data) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(sessionProvider);
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    QuickActionCard(
                      icon: Icons.people,
                      title: "Players",
                      onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PlayersPage(),
                        ),
                      );
                    },
                    ),

                    const SizedBox(width: 12),

                    QuickActionCard(
                      icon: Icons.sports_tennis,
                      title: "Courts",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CourtsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    QuickActionCard(
                      icon: Icons.event,
                      title: "Sessions",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SessionsPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 12),

                    QuickActionCard(
                      icon: Icons.bar_chart,
                      title: "Statistics",
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Recent Sessions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                if (data.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("No Sessions Found"),
                    ),
                  )
                else
                  ...data.map(
                    (session) => SessionCard(session: session),
                  ),
              ],
            ),
          );
        },
      ),

      floatingActionButton:
    FloatingActionButton(

  child: const Icon(Icons.add),

  onPressed: () async {

    await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddPlayerPage(),

      ),

    );

    ref.invalidate(playerProvider);

  },

),
    );
  }
}