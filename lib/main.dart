import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/client_log.dart';
import 'package:myapp/screens/emotion_selection_screen.dart';
import 'package:myapp/screens/end_of_day_note_screen.dart';
import 'package:myapp/screens/influences_screen.dart';
import 'package:myapp/screens/loading_screen.dart';
import 'package:myapp/screens/log_details_screen.dart';
import 'package:myapp/screens/mood_screen.dart';
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
    GoRoute(path: '/', builder: (context, state) => const PersonalInfoScreen()),
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
      path: '/log_details',
      builder: (context, state) =>
          LogDetailsScreen(log: state.extra as ClientLog),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.nunitoSansTextTheme();

    return MaterialApp.router(
      routerConfig: _router,
      title: 'SoulSync',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
          primary: Colors.brown.shade600,
          secondary: Colors.amber.shade700,
        ),
        textTheme: baseTextTheme.copyWith(
          displayLarge: GoogleFonts.pacifico(
            textStyle: baseTextTheme.displayLarge,
            color: Colors.brown.shade800,
          ),
          displayMedium: GoogleFonts.pacifico(
            textStyle: baseTextTheme.displayMedium,
            color: Colors.brown.shade800,
          ),
          displaySmall: GoogleFonts.pacifico(
            textStyle: baseTextTheme.displaySmall,
            color: Colors.brown.shade800,
          ),
          headlineLarge: GoogleFonts.pacifico(
            textStyle: baseTextTheme.headlineLarge,
            color: Colors.brown.shade700,
          ),
          headlineMedium: GoogleFonts.pacifico(
            textStyle: baseTextTheme.headlineMedium,
            color: Colors.brown.shade700,
          ),
          headlineSmall: GoogleFonts.pacifico(
            textStyle: baseTextTheme.headlineSmall,
            color: Colors.brown.shade700,
          ),
          titleLarge: baseTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.pacifico(
            fontSize: 28,
            color: Colors.brown.shade700,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.brown.shade700),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown.shade600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: GoogleFonts.nunitoSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.amber.shade100.withAlpha(150),
          selectedColor: Colors.amber.shade400,
          shape: const StadiumBorder(),
          side: BorderSide.none,
          labelStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
          secondaryLabelStyle: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.nunitoSans(color: Colors.brown.shade600),
          filled: true,
          fillColor: Colors.white.withAlpha(204),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.brown.shade400, width: 2),
          ),
        ),
      ),
    );
  }
}
