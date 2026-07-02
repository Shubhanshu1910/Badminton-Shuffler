import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/court_model.dart';
import '../providers/court_provider.dart';

class AddCourtPage extends ConsumerStatefulWidget {
  final CourtModel? court;

  const AddCourtPage({
    super.key,
    this.court,
  });

  @override
  ConsumerState<AddCourtPage> createState() =>
      _AddCourtPageState();
}

class _AddCourtPageState extends ConsumerState<AddCourtPage> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.court != null) {
      nameController.text = widget.court!.name;
      numberController.text =
          widget.court!.courtNumber.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.court != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Court" : "Add Court",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Court Name",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Court Number",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final repo = ref.read(
                    courtRepositoryProvider,
                  );

                  if (isEdit) {
                    await repo.updateCourt(
                      widget.court!.id,
                      nameController.text,
                      int.parse(numberController.text),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Court updated successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    await repo.createCourt(
                      name: nameController.text,
                      courtNumber: int.parse(
                        numberController.text,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Court created successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }

                  ref.invalidate(courtProvider);

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  isEdit
                      ? "Update Court"
                      : "Create Court",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}