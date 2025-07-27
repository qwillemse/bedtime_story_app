import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/new_story_screen.dart';
import 'screens/story_screen.dart';

void main() {
  runApp(const BedtimeStoryApp());
}

class BedtimeStoryApp extends StatelessWidget {
  const BedtimeStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bedtime Story App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
      routes: {
        NewStoryScreen.routeName: (context) => const NewStoryScreen(),
        StoryScreen.routeName: (context) => const StoryScreen(),
      },
    );
  }
}
