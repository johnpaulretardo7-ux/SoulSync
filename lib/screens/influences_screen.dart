
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfluencesScreen extends StatefulWidget {
  final String name;
  final int moodScore;
  final List<String> selectedEmotions;

  const InfluencesScreen({
    super.key,
    required this.name,
    required this.moodScore,
    required this.selectedEmotions,
  });

  @override
  State<InfluencesScreen> createState() => _InfluencesScreenState();
}

class _InfluencesScreenState extends State<InfluencesScreen> {
  final List<String> _selectedInfluences = [];

  final List<String> _influences = [
    'Work', 'Family', 'Friends', 'Health', 'Finance', 'Hobbies', 'Weather',
  ];

  void _onInfluenceSelected(String influence) {
    setState(() {
      if (_selectedInfluences.contains(influence)) {
        _selectedInfluences.remove(influence);
      } else {
        _selectedInfluences.add(influence);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Influences for ${widget.name}'),
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
                  'What influenced your feelings?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  alignment: WrapAlignment.center,
                  children: _influences.map((influence) {
                    final isSelected = _selectedInfluences.contains(influence);
                    return ChoiceChip(
                      label: Text(influence),
                      selected: isSelected,
                      onSelected: (selected) => _onInfluenceSelected(influence),
                      selectedColor: Colors.amberAccent,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.go('/physical_state', extra: {
                      'name': widget.name,
                      'moodScore': widget.moodScore,
                      'selectedEmotions': widget.selectedEmotions,
                      'selectedInfluences': _selectedInfluences,
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
