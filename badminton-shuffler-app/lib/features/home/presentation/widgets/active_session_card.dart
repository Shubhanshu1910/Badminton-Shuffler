import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/session_model.dart';
import '../providers/session_provider.dart';

class AddSessionPage
    extends ConsumerStatefulWidget {
  final SessionModel? session;

  const AddSessionPage({
    super.key,
    this.session,
  });

  @override
  ConsumerState<AddSessionPage>
      createState() =>
          _AddSessionPageState();
}

class _AddSessionPageState
    extends ConsumerState<AddSessionPage> {
  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final courtController =
      TextEditingController();

  final playerController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.session != null) {
      titleController.text =
          widget.session!.title;

      courtController.text =
          widget.session!.totalCourts
              .toString();

      playerController.text =
          widget.session!.maxPlayers
              .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit =
        widget.session != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? "Edit Session"
              : "Create Session",
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration:
                const InputDecoration(
              labelText:
                  "Session Title",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller:
                descriptionController,
            decoration:
                const InputDecoration(
              labelText:
                  "Description",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: courtController,
            keyboardType:
                TextInputType.number,
            decoration:
                const InputDecoration(
              labelText:
                  "Total Courts",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller:
                playerController,
            keyboardType:
                TextInputType.number,
            decoration:
                const InputDecoration(
              labelText:
                  "Maximum Players",
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              final repo = ref.read(
                  sessionRepositoryProvider);

              if (isEdit) {
                await repo
                    .updateSession(
                  widget.session!.id,
                  titleController.text,
                  descriptionController
                      .text,
                  int.parse(
                      courtController.text),
                  int.parse(
                      playerController
                          .text),
                );
              } else {
                await repo
                    .createSession(
                  title:
                      titleController.text,
                  description:
                      descriptionController
                          .text,
                  totalCourts:
                      int.parse(
                          courtController
                              .text),
                  maxPlayers:
                      int.parse(
                          playerController
                              .text),
                );
              }

              ref.invalidate(
                  sessionProvider);

              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: Text(
              isEdit
                  ? "Update Session"
                  : "Create Session",
            ),
          )
        ],
      ),
    );
  }
}