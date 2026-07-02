import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/court_provider.dart';
import '../widgets/court_card.dart';
import 'add_court_page.dart'; // <-- Add this import

class CourtsPage extends ConsumerWidget {
  const CourtsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courts = ref.watch(courtProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Courts"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCourtPage(),
            ),
          );

          ref.invalidate(courtProvider);
        },
      ),

      body: courts.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text("$e"),
        ),
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Courts Found"),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return CourtCard(
                court: data[index],
              );
            },
          );
        },
      ),
    );
  }
}