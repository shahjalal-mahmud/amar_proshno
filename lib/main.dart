import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const AmarProshnoApp());
}

class AmarProshnoApp extends StatelessWidget {
  const AmarProshnoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amar Proshno',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB39DDB),
          brightness: Brightness.light,
        ).copyWith(
          surface: const Color(0xFFEDE7F6),
          primary: const Color(0xFF9575CD),
          secondary: const Color(0xFFCE93D8),
          onSurface: const Color(0xFF4A148C),
        ),
        scaffoldBackgroundColor: const Color(0xFFEDE7F6),
      ),
      home: const HomeScreen(),
    );
  }
}