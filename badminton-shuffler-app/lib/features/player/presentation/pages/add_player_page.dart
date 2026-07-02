import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/player_model.dart';
import '../providers/player_provider.dart';

class AddPlayerPage extends ConsumerStatefulWidget {
  final PlayerModel? player;

  const AddPlayerPage({
    super.key,
    this.player,
  });

  @override
  ConsumerState<AddPlayerPage> createState() =>
      _AddPlayerPageState();
}

class _AddPlayerPageState extends ConsumerState<AddPlayerPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  int skill = 3;

  @override
  void initState() {
    super.initState();

    if (widget.player != null) {
      nameController.text = widget.player!.name;
      phoneController.text = widget.player?.phone ?? "";
      skill = widget.player!.skillLevel;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.player != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Player" : "Add Player",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<int>(
              value: skill,
              isExpanded: true,
              items: List.generate(
                5,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text("Skill ${i + 1}"),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  skill = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                final repo = ref.read(playerRepositoryProvider);

                if (isEdit) {
                  await repo.updatePlayer(
                    widget.player!.id,
                    nameController.text,
                    phoneController.text,
                    skill,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Player updated successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  await repo.createPlayer(
                      name: nameController.text,
                      phone: phoneController.text,
                      skill: skill,
                    );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Player created successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                ref.invalidate(playerProvider);
                Navigator.pop(context);
              },
              child: Text(
                isEdit ? "Update Player" : "Create Player",
              ),
            ),
          ],
        ),
      ),
    );
  }
}