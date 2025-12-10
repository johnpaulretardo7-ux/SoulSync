
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/client_log.dart';
import 'package:myapp/screens/emotion_selection_screen.dart';
import 'package:myapp/screens/end_of_day_note_screen.dart';
import 'package:myapp/screens/influences_screen.dart';
import 'package:myapp/screens/loading_screen.dart';
import 'package:myapp/screens/mood_screen.dart';
import 'package:myapp/screens/mood_summary_screen.dart';
import 'package:myapp/screens/personal_info_screen.dart';
import 'package:myapp/screens/physical_state_screen.dart';
import 'package:myapp/screens/wellbeing_action_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ClientLogAdapter());
  await Hive.openBox<ClientLog>('client_logs');

  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/loading',
  routes: [
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      path: '/mood',
      builder: (context, state) => MoodScreen(name: state.extra as String),
    ),
    GoRoute(
      path: '/emotions',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return EmotionSelectionScreen(
          name: data['name'] as String,
          moodScore: data['moodScore'] as int,
        );
      },
    ),
    GoRoute(
      path: '/influences',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return InfluencesScreen(
          name: data['name'] as String,
          moodScore: data['moodScore'] as int,
          selectedEmotions: data['selectedEmotions'] as List<String>,
        );
      },
    ),
    GoRoute(
      path: '/physical_state',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return PhysicalStateScreen(
          name: data['name'] as String,
          moodScore: data['moodScore'] as int,
          selectedEmotions: data['selectedEmotions'] as List<String>,
          selectedInfluences: data['selectedInfluences'] as List<String>,
        );
      },
    ),
    GoRoute(
      path: '/wellbeing_actions',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return WellbeingActionScreen(
          name: data['name'] as String,
          moodScore: data['moodScore'] as int,
          selectedEmotions: data['selectedEmotions'] as List<String>,
          selectedInfluences: data['selectedInfluences'] as List<String>,
          physicalStates: data['physicalStates'] as Map<String, bool>,
        );
      },
    ),
    GoRoute(
      path: '/end_of_day_note',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return EndOfDayNoteScreen(
          name: data['name'] as String,
          moodScore: data['moodScore'] as int,
          selectedEmotions: data['selectedEmotions'] as List<String>,
          selectedInfluences: data['selectedInfluences'] as List<String>,
          physicalStates: data['physicalStates'] as Map<String, bool>,
          wellbeingActions: data['wellbeingActions'] as Map<String, bool>,
        );
      },
    ),
    GoRoute(
      path: '/summary',
      builder: (context, state) =>
          MoodSummaryScreen(log: state.extra as ClientLog?),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      routerConfig: _router,
      title: 'SoulSync',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.nunitoSansTextTheme(textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.pacifico(
            fontSize: 28,
            color: Colors.black87,
          ),
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.amber.shade100.withAlpha(128),
          selectedColor: Colors.amber.shade300,
          shape: const StadiumBorder(),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
