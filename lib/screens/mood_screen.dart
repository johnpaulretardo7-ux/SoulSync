import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodScreen extends StatefulWidget {
  final String name;
  const MoodScreen({super.key, required this.name});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  double _moodScore = 5;

  String get _moodEmoji {
    if (_moodScore <= 2) return '😞'; // Sad
    if (_moodScore <= 4) return '😟'; // Worried
    if (_moodScore <= 6) return '😐'; // Neutral
    if (_moodScore <= 8) return '🙂'; // Slightly Smiling
    return '😄'; // Happy
  }

  Color get _moodColor {
    if (_moodScore <= 2) return Colors.blue.shade800;
    if (_moodScore <= 4) return Colors.indigo.shade400;
    if (_moodScore <= 6) return Colors.grey.shade600;
    if (_moodScore <= 8) return Colors.orange.shade600;
    return Colors.amber.shade700;
  }

  void _next() {
    context.go(
      '/emotions',
      extra: {'name': widget.name, 'moodScore': _moodScore.toInt()},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello, ${widget.name}!')),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _moodColor.withAlpha(153),
              Colors.amber.shade50.withAlpha(230),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                Text(
                  'How are you feeling overall?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  _moodEmoji,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 120),
                ),
                const SizedBox(height: 40),
                Text(
                  _moodScore.toInt().toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 12.0,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withAlpha(77),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 16.0,
                    ),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withAlpha(51),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 32.0,
                    ),
                  ),
                  child: Slider(
                    value: _moodScore,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() {
                        _moodScore = value;
                      });
                    },
                  ),
                ),
                const Spacer(flex: 3),
                ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _moodColor,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: GoogleFonts.nunitoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Next'),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
