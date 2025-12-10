
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmotionSelectionScreen extends StatefulWidget {
  final String name;
  final int moodScore;

  const EmotionSelectionScreen({
    super.key,
    required this.name,
    required this.moodScore,
  });

  @override
  State<EmotionSelectionScreen> createState() => _EmotionSelectionScreenState();
}

class _EmotionSelectionScreenState extends State<EmotionSelectionScreen> {
  final List<String> _selectedEmotions = [];

  final List<String> _emotions = [
    'Happy', 'Excited', 'Grateful', 'Relaxed', 'Content',
    'Sad', 'Angry', 'Anxious', 'Stressed', 'Tired',
  ];

  void _onEmotionSelected(String emotion) {
    setState(() {
      if (_selectedEmotions.contains(emotion)) {
        _selectedEmotions.remove(emotion);
      } else {
        _selectedEmotions.add(emotion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emotions for ${widget.name}'),
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
                  'What specific emotions are you feeling?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  alignment: WrapAlignment.center,
                  children: _emotions.map((emotion) {
                    final isSelected = _selectedEmotions.contains(emotion);
                    return ChoiceChip(
                      label: Text(emotion),
                      selected: isSelected,
                      onSelected: (selected) => _onEmotionSelected(emotion),
                      selectedColor: Colors.amberAccent,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.go('/influences', extra: {
                      'name': widget.name,
                      'moodScore': widget.moodScore,
                      'selectedEmotions': _selectedEmotions,
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
