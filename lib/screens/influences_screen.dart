import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final Map<String, IconData> _influenceOptions = {
    'Work': Icons.work_outline,
    'Family': Icons.home_work_outlined,
    'Friends': Icons.people_outline,
    'Relationship': Icons.favorite_border,
    'Health': Icons.healing_outlined,
    'Finances': Icons.monetization_on_outlined,
    'Hobbies': Icons.palette_outlined,
    'Sleep': Icons.bedtime_outlined,
    'Weather': Icons.wb_sunny_outlined,
  };

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
        title: Text('Your Influences', style: GoogleFonts.pacifico()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown.shade200, Colors.amber.shade100],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'What influenced your mood today?',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: _influenceOptions.entries.map((entry) {
                      final String influence = entry.key;
                      final IconData icon = entry.value;
                      final bool isSelected = _selectedInfluences.contains(
                        influence,
                      );

                      return GestureDetector(
                        onTap: () => _onInfluenceSelected(influence),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.brown.shade400
                                : Colors.white.withAlpha(179),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? Colors.brown.withAlpha(128)
                                    : Colors.black.withAlpha(26),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                size: 40,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.brown.shade700,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                influence,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.brown.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.go(
                      '/physical_state',
                      extra: {
                        'name': widget.name,
                        'moodScore': widget.moodScore,
                        'selectedEmotions': widget.selectedEmotions,
                        'selectedInfluences': _selectedInfluences,
                      },
                    );
                  },
                  child: const Text('Next'),
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
