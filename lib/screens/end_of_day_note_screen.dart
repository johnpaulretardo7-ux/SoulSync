import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:myapp/models/client_log.dart';

class EndOfDayNoteScreen extends StatefulWidget {
  final String name;
  final int moodScore;
  final List<String> selectedEmotions;
  final List<String> selectedInfluences;
  final Map<String, bool> physicalStates;
  final Map<String, bool> wellbeingActions;

  const EndOfDayNoteScreen({
    super.key,
    required this.name,
    required this.moodScore,
    required this.selectedEmotions,
    required this.selectedInfluences,
    required this.physicalStates,
    required this.wellbeingActions,
  });

  @override
  State<EndOfDayNoteScreen> createState() => _EndOfDayNoteScreenState();
}

class _EndOfDayNoteScreenState extends State<EndOfDayNoteScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('End of Day Note for ${widget.name}')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade100, Colors.amber.shade100],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Any final thoughts or notes?',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _noteController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Write your thoughts here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    final newLog = ClientLog(
                      name: widget.name,
                      moodScore: widget.moodScore,
                      emotions: widget.selectedEmotions,
                      influences: widget.selectedInfluences,
                      physicalSensation: widget.physicalStates.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList(),
                      wellbeingActions: widget.wellbeingActions.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList(),
                      endOfDayNote: _noteController.text,
                      timestamp: DateTime.now(),
                    );
                    await Hive.box<ClientLog>('client_logs').add(newLog);
                    if (context.mounted) {
                      context.go('/'); // Navigate back to home
                    }
                  },
                  child: const Text('Finish & Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
