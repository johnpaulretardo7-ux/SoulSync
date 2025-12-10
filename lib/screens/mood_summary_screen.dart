import 'package:flutter/material.dart';
import 'package:myapp/models/client_log.dart';

class MoodSummaryScreen extends StatelessWidget {
  final ClientLog? log;
  const MoodSummaryScreen({super.key, this.log});

  @override
  Widget build(BuildContext context) {
    if (log == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No log data found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Log Summary for ${log!.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(
              context,
              title: 'Mood Level',
              content: '${log!.moodScore} / 10',
              icon: Icons.sentiment_satisfied_alt,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Emotions Felt',
              content: log!.emotions.join(', '),
              icon: Icons.emoji_emotions,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Mood Influences',
              content: log!.influences.join(', '),
              icon: Icons.stream,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Physical Sensations',
              content: log!.physicalSensation.join(', '),
              icon: Icons.accessibility_new,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Wellbeing Actions',
              content: log!.wellbeingActions.join(', '),
              icon: Icons.spa,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'End of Day Note',
              content: log!.endOfDayNote,
              icon: Icons.edit_note,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context,
      {required String title, required String content, required IconData icon}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
