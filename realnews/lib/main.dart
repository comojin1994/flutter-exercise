import 'package:flutter/material.dart';
import 'package:realnews/screens/detail_screen.dart';
import 'package:realnews/screens/main_screen.dart';
import 'package:realnews/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real News',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          dynamic newsInfo = settings.arguments as dynamic;
          return MaterialPageRoute(
              builder: (context) => DetailScreen(newsInfo: newsInfo));
        }
        return null;
      },
    );
  }
}
