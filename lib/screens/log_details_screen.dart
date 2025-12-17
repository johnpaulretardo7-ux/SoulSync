import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/models/client_log.dart';

class LogDetailsScreen extends StatelessWidget {
  final ClientLog log;

  const LogDetailsScreen({super.key, required this.log});

  String _generatePersonalizedAdvice() {
    List<String> advices = [];

    // --- Advice based on mood score ---
    if (log.moodScore <= 2) {
      advices.add(
        "You're going through a lot right now. Embrace yourself. It's okay to cry. Don't forget that a new day awaits.",
      );
    } else if (log.moodScore <= 4) {
      advices.add(
        "It seems like today was a tough day for you. Remember that it's normal to feel this way. Give yourself time to rest and do something light for yourself.",
      );
    } else if (log.moodScore <= 6) {
      advices.add(
        "Thank you for sharing how you feel. It's good to take time to reflect on what you need right now. Maybe a short walk or listening to music will help.",
      );
    } else if (log.moodScore <= 8) {
      advices.add(
        "You're in a good disposition today. This is a great opportunity to tackle tasks that require your energy.",
      );
    } else {
      advices.add(
        "It's great that you're feeling good! Use this energy for things that make you happy and share it with others.",
      );
    }

    // --- Combination advice ---
    if (log.moodScore <= 4 && log.influences.contains('Work')) {
      advices.add(
        "It looks like work has a heavy impact on you today. Remember that work is just one part of your life. Try to disconnect after work hours to recharge.",
      );
    }
    if (log.emotions.contains('Sad') &&
        log.wellbeingActions.contains('Be alone')) {
      advices.add(
        "Sometimes, we need to be alone to process sadness. That's okay. But remember, there are people ready to listen when you're ready.",
      );
    }
    if (log.emotions.contains('Anxious') && log.influences.contains('Work')) {
      advices.add(
        "Work-related anxiety is common. After your workday, make sure to completely disconnect. Try a hobby that takes your mind off things.",
      );
    }

    // --- Advice based on emotions ---
    if (log.emotions.contains('Sad')) {
      advices.add(
        "Sadness is a valid feeling. Try listening to your favorite music, watching a funny show, or talking to a friend.",
      );
    }
    if (log.emotions.contains('Tired')) {
      advices.add(
        "Fatigue is a sign from your body that you need to rest. Don't force yourself. You might need a short nap or a longer sleep tonight.",
      );
    }
    if (log.emotions.contains('Happy')) {
      advices.add(
        "Keep doing the things that make you happy. Share your smile with others! Cherish this moment.",
      );
    }
    if (log.emotions.contains('Angry')) {
      advices.add(
        "Anger is a strong emotion. Try writing down your feelings or doing a physical activity to release it in a safe way.",
      );
    }
    if (log.emotions.contains('Anxious')) {
      advices.add(
        "When anxious, try to focus on your breathing. Breathe deeply and slowly. This can help calm your mind. Think about what you can control and let go of what you can't.",
      );
    }
    if (log.emotions.contains('Excited')) {
      advices.add(
        "Embrace the excitement! Channel this energy into something you're passionate about.",
      );
    }
    if (log.emotions.contains('Grateful')) {
      advices.add(
        "Gratitude is a beautiful feeling. Take a moment to write down three things you're thankful for.",
      );
    }
    if (log.emotions.contains('Relaxed')) {
      advices.add(
        "It's wonderful that you're feeling relaxed. Enjoy this peace and allow your body and mind to fully recharge.",
      );
    }
    if (log.emotions.contains('Content')) {
      advices.add(
        "Feeling content is a sign of inner peace. Savor this moment and appreciate the simple joys of life.",
      );
    }
    if (log.emotions.contains('Stressed')) {
      advices.add(
        "Stress can be overwhelming. Try some deep breathing exercises or a short walk to clear your head. Break down big tasks into smaller, manageable steps.",
      );
    }
    if (log.emotions.contains('Inspired')) {
      advices.add(
        "Use that inspiration! This is the perfect time to start a new project, a hobby, or continue something you've started.",
      );
    }

    // --- Advice based on influences ---
    if (log.influences.contains('Work')) {
      advices.add(
        "If work is affecting you, try taking a break and stretching. Work-life balance is important. Set boundaries on your work hours.",
      );
    }
    if (log.influences.contains('Family')) {
      advices.add(
        "Family can be complicated. Remember to take care of yourself and create space if needed.",
      );
    }
    if (log.influences.contains('Friends')) {
      advices.add(
        "Friends are important. If there's an issue, try to talk honestly. If they are the reason for your joy, thank them.",
      );
    }
    if (log.influences.contains('Health')) {
      advices.add(
        "Health is wealth. If this is affecting you, listen to your body and consult a professional if necessary.",
      );
    }
    if (log.influences.contains('Finances')) {
      advices.add(
        "Financial stress is real. Take small steps to manage your budget. Every penny counts.",
      );
    }
    if (log.influences.contains('Relationship')) {
      advices.add(
        "Relationships have their ups and downs. Communication is key. Whether it's good or bad, expressing your feelings can help.",
      );
    }
    if (log.influences.contains('Sleep')) {
      advices.add(
        "Sleep is crucial for wellbeing. If you're not getting enough, try to establish a relaxing bedtime routine.",
      );
    }
    if (log.influences.contains('Weather')) {
      advices.add(
        "The weather can definitely affect our mood. If it's gloomy outside, try to bring some brightness inside with music, a good book, or a warm drink.",
      );
    }

    // --- Advice based on physical sensations ---
    if (log.physicalSensation.contains('Headache')) {
      advices.add(
        "Don't forget to drink enough water and rest for a while. A gentle massage on your temples might also help.",
      );
    }
    if (log.physicalSensation.contains('Chest tightness')) {
      advices.add(
        "Chest tightness can be scary. Try to sit up straight, focus on your breathing, and if it continues, consult a doctor.",
      );
    }
    if (log.physicalSensation.contains('Stomach ache')) {
      advices.add(
        "This might be related to stress or something you ate. Try drinking warm tea and relaxing.",
      );
    }
    if (log.physicalSensation.contains('Fatigue')) {
      advices.add(
        "Fatigue is a signal to slow down. Give yourself enough sleep and nutrition.",
      );
    }
    if (log.physicalSensation.contains('Tense muscles')) {
      advices.add(
        "Your body might be holding onto stress. Try some gentle stretching or a warm bath to release the tension.",
      );
    }
    if (log.physicalSensation.contains('Lack of energy')) {
      advices.add(
        "Low energy can be frustrating. Ensure you're eating nutritious food and staying hydrated. A little bit of movement can sometimes boost your energy levels.",
      );
    }

    // --- Advice based on wellbeing actions ---
    if (log.wellbeingActions.contains('Exercise')) {
      advices.add(
        "It's great that you thought of exercising! This is a big help for your physical and mental health.",
      );
    }
    if (log.wellbeingActions.contains('Meditate')) {
      advices.add(
        "Meditation is a great way to connect with yourself. Keep it up!",
      );
    }
    if (log.wellbeingActions.contains('Eat healthy')) {
      advices.add(
        "Eating right is taking care of your body. Every nutritious meal is a step towards feeling better.",
      );
    }
    if (log.wellbeingActions.contains('Talk to a friend')) {
      advices.add(
        "It's a wonderful step to connect with others. Talking is an effective way to feel lighter.",
      );
    }
    if (log.wellbeingActions.contains('Write in a journal')) {
      advices.add(
        "Writing is a way to release the contents of your mind and heart. Continue this good habit.",
      );
    }
    if (log.wellbeingActions.contains('Listen to music')) {
      advices.add(
        "Music is a powerful tool. Let the rhythm and melodies carry you away and lift your spirits.",
      );
    }
    if (log.wellbeingActions.contains('Spend time in nature')) {
      advices.add(
        "Connecting with nature is a great way to ground yourself. Even a few minutes outdoors can make a difference.",
      );
    }

    if (advices.isEmpty) {
      advices.add(
        "Thank you for checking in with yourself. Being mindful of your feelings is a great start.",
      );
    }

    return advices.toSet().toList().join('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    final personalizedAdvice = _generatePersonalizedAdvice();
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Details for ${log.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
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
              content: '${log.moodScore} / 10',
              icon: Icons.sentiment_satisfied_alt,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Emotions Felt',
              content: log.emotions.join(', '),
              icon: Icons.emoji_emotions,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Mood Influences',
              content: log.influences.join(', '),
              icon: Icons.stream,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Physical Sensations',
              content: log.physicalSensation.join(', '),
              icon: Icons.accessibility_new,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              context,
              title: 'Wellbeing Actions',
              content: log.wellbeingActions.join(', '),
              icon: Icons.spa,
            ),
            if (log.endOfDayNote.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildSummaryCard(
                context,
                title: 'End of Day Note',
                content: log.endOfDayNote,
                icon: Icons.edit_note,
              ),
            ],
            const SizedBox(height: 24),
            const Divider(thickness: 2),
            const SizedBox(height: 24),
            Text(
              'Personalized Advice',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  personalizedAdvice,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
  }) {
    if (content.isEmpty) return const SizedBox.shrink();

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
