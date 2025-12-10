
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalStateScreen extends StatefulWidget {
  final String name;
  final int moodScore;
  final List<String> selectedEmotions;
  final List<String> selectedInfluences;

  const PhysicalStateScreen({
    super.key,
    required this.name,
    required this.moodScore,
    required this.selectedEmotions,
    required this.selectedInfluences,
  });

  @override
  State<PhysicalStateScreen> createState() => _PhysicalStateScreenState();
}

class _PhysicalStateScreenState extends State<PhysicalStateScreen> {
  final Map<String, bool> _physicalStates = {
    // Bad
    'Tired': false,
    'Headache': false,
    'Body Pain': false,
    'Tense': false,
    'Stressed': false,

    // Good
    'Energetic': false,
    'Rested': false,
    'Calm': false,
    'Healthy': false,
    'Focused': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physical State'),
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
                  'How are you feeling physically?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  alignment: WrapAlignment.center,
                  children: _physicalStates.keys.map((state) {
                    return ChoiceChip(
                      label: Text(state),
                      selected: _physicalStates[state]!,
                      onSelected: (selected) {
                        setState(() {
                          _physicalStates[state] = selected;
                        });
                      },
                    );
                  }).toList(),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.go(
                      '/wellbeing_actions',
                      extra: {
                        'name': widget.name,
                        'moodScore': widget.moodScore,
                        'selectedEmotions': widget.selectedEmotions,
                        'selectedInfluences': widget.selectedInfluences,
                        'physicalStates': _physicalStates,
                      },
                    );
                  },
                  child: const Text('Continue'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
