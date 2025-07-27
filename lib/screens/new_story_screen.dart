import 'package:flutter/material.dart';
import 'story_screen.dart';

class NewStoryScreen extends StatefulWidget {
  static const routeName = '/new-story';
  const NewStoryScreen({super.key});

  @override
  State<NewStoryScreen> createState() => _NewStoryScreenState();
}

class _NewStoryScreenState extends State<NewStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _charactersController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _aboutController.dispose();
    _lengthController.dispose();
    _ageController.dispose();
    _charactersController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        StoryScreen.routeName,
        arguments: {
          'title': _titleController.text,
          'about': _aboutController.text,
          'length': _lengthController.text,
          'age': _ageController.text,
          'characters': _charactersController.text,
          'other': _otherController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Story')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(labelText: 'What should the story be about?'),
              ),
              TextFormField(
                controller: _lengthController,
                decoration: const InputDecoration(labelText: 'Length (minutes)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _charactersController,
                decoration: const InputDecoration(labelText: 'Characters'),
              ),
              TextFormField(
                controller: _otherController,
                decoration: const InputDecoration(labelText: 'Other'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Generate Story'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 