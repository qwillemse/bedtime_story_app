import 'package:flutter/material.dart';
import 'new_story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bedtime Story App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, NewStoryScreen.routeName);
          },
          child: const Text('Start New Story'),
        ),
      ),
    );
  }
} 