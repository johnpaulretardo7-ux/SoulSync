
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WellbeingActionScreen extends StatefulWidget {
  final String name;
  final int moodScore;
  final List<String> selectedEmotions;
  final List<String> selectedInfluences;
  final Map<String, bool> physicalStates;

  const WellbeingActionScreen({
    super.key,
    required this.name,
    required this.moodScore,
    required this.selectedEmotions,
    required this.selectedInfluences,
    required this.physicalStates,
  });

  @override
  State<WellbeingActionScreen> createState() => _WellbeingActionScreenState();
}

class _WellbeingActionScreenState extends State<WellbeingActionScreen> {
  final Map<String, bool> _wellbeingActions = {
    'Exercise': false,
    'Meditate': false,
    'Talk to someone': false,
    'Rest': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Well-being for ${widget.name}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade100,
              Colors.amber.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What actions will you take for your well-being?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ..._wellbeingActions.keys.map((action) {
                  return CheckboxListTile(
                    title: Text(action),
                    value: _wellbeingActions[action],
                    onChanged: (bool? value) {
                      setState(() {
                        _wellbeingActions[action] = value!;
                      });
                    },
                  );
                }),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.go('/end_of_day_note', extra: {
                      'name': widget.name,
                      'moodScore': widget.moodScore,
                      'selectedEmotions': widget.selectedEmotions,
                      'selectedInfluences': widget.selectedInfluences,
                      'physicalStates': widget.physicalStates,
                      'wellbeingActions': _wellbeingActions,
                    });
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
