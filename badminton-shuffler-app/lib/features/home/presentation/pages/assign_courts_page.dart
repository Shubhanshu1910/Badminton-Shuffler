import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../court/presentation/providers/court_provider.dart';
import '../../data/models/session_model.dart';
import '../providers/session_provider.dart';

class AssignCourtsPage extends ConsumerStatefulWidget {
  final SessionModel session;

  const AssignCourtsPage({
    super.key,
    required this.session,
  });

  @override
  ConsumerState<AssignCourtsPage> createState() =>
      _AssignCourtsPageState();
}

class _AssignCourtsPageState
    extends ConsumerState<AssignCourtsPage> {

  final List<String> selectedCourts = [];

  @override
  Widget build(BuildContext context) {
    final courts = ref.watch(courtProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Courts"),
      ),
      body: courts.when(
        loading: () =>
            const Center(
              child: CircularProgressIndicator(),
            ),

        error: (e, _) =>
            Center(
              child: Text(e.toString()),
            ),

        data: (data) {
          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) {

                    final court = data[index];

                    return CheckboxListTile(
                      title: Text(court.name),
                      subtitle: Text(
                        "Court ${court.courtNumber}",
                      ),
                      value: selectedCourts.contains(court.id),

                      onChanged: (value) {

                        setState(() {

                          if (value == true) {
                            selectedCourts.add(court.id);
                          } else {
                            selectedCourts.remove(court.id);
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

                    child: const Text("Assign Courts"),

                    onPressed: () async {

                      await ref
                          .read(sessionRepositoryProvider)
                          .addCourts(
                            widget.session.id,
                            selectedCourts,
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