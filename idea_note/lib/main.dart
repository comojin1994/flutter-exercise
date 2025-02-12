import 'package:flutter/material.dart';
import 'package:idea_note/screens/main_screen.dart';
import 'package:idea_note/screens/newidea_screen.dart';
import 'package:idea_note/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idea Note',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScreen(),
        '/newIdea': (context) => const NewIdeaScreen(),
      },
    );
  }
}
