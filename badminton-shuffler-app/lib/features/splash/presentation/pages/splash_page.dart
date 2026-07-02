import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/session_provider.dart';
import '../../../home/presentation/widgets/active_session_card.dart';
import '../../../home/presentation/widgets/session_card.dart';

class SessionsPage
    extends ConsumerStatefulWidget {
  const SessionsPage({super.key});

  @override
  ConsumerState<SessionsPage>
      createState() =>
          _SessionsPageState();
}

class _SessionsPageState
    extends ConsumerState<SessionsPage> {
  final searchController =
      TextEditingController();

  String search = "";

  @override
  Widget build(BuildContext context) {
    final sessions =
        ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sessions"),
      ),
      floatingActionButton:
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddSessionPage(),
            ),
          );

          ref.invalidate(
              sessionProvider);
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(
              sessionProvider);
        },
        child: sessions.when(
          loading: () => const Center(
              child:
                  CircularProgressIndicator()),
          error: (e, _) =>
              Center(child: Text("$e")),
          data: (data) {
            final filtered = data
                .where(
                  (e) => e.title
                      .toLowerCase()
                      .contains(search),
                )
                .toList();

            if (filtered.isEmpty) {
              return const Center(
                child: Text(
                    "No Sessions"),
              );
            }

            return ListView(
              padding:
                  const EdgeInsets.all(16),
              children: [
                TextField(
                  controller:
                      searchController,
                  decoration:
                      const InputDecoration(
                    hintText:
                        "Search Session",
                    prefixIcon:
                        Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search =
                          value.toLowerCase();
                    });
                  },
                ),
                const SizedBox(
                    height: 20),
                ...filtered.map(
                  (e) =>
                      SessionCard(session: e),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}