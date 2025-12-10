
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoodScreen extends StatefulWidget {
  final String name;

  const MoodScreen({super.key, required this.name});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  double _moodScore = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood for ${widget.name}'),
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
                  'How are you feeling overall, ${widget.name}?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Slider(
                  value: _moodScore,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _moodScore.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _moodScore = value;
                    });
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.go('/emotions', extra: {'name': widget.name, 'moodScore': _moodScore.toInt()});
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
