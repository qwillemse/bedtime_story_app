import 'package:flutter/material.dart';
import '../services/story_service.dart';

class StoryScreen extends StatefulWidget {
  static const routeName = '/story';
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  String? _story;
  bool _loading = true;
  String? _error;
  bool _didRequest = false;
  List<String> _paragraphs = [];
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didRequest) {
      _didRequest = true;
      _generateStory();
    }
  }

  Future<void> _generateStory() async {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (args == null) {
      setState(() {
        _error = 'No story data provided.';
        _loading = false;
      });
      return;
    }
    try {
      final story = await StoryService().generateStory(
        title: args['title'] ?? '',
        about: args['about'] ?? '',
        length: args['length'] ?? '',
        age: args['age'] ?? '',
        characters: args['characters'] ?? '',
        other: args['other'] ?? '',
      );
      final paragraphs = story.split(RegExp(r'\n\s*\n|\r\n\s*\r\n|\n{2,}|\r{2,}')).where((p) => p.trim().isNotEmpty).toList();
      setState(() {
        _story = story;
        _paragraphs = paragraphs.isNotEmpty ? paragraphs : [story];
        _currentPage = 0;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to generate story.';
        _loading = false;
      });
    }
  }

  void _nextPage() {
    if (_currentPage < _paragraphs.length - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    return Scaffold(
      appBar: AppBar(title: const Text('Your Story')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: args == null
            ? const Text('No story data provided.')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title:  ${args['title']}', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('About:  ${args['about']}'),
                  Text('Length:  ${args['length']} minutes'),
                  Text('Age:  ${args['age']}'),
                  Text('Characters:  ${args['characters']}'),
                  Text('Other:  ${args['other']}'),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  if (_loading)
                    const Center(child: CircularProgressIndicator())
                  else if (_error != null)
                    Text(_error!, style: const TextStyle(color: Colors.red))
                  else if (_paragraphs.isNotEmpty)
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                _paragraphs[_currentPage],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _currentPage > 0 ? _prevPage : null,
                                child: const Text('Previous'),
                              ),
                              Text('Page ${_currentPage + 1} of ${_paragraphs.length}'),
                              ElevatedButton(
                                onPressed: _currentPage < _paragraphs.length - 1 ? _nextPage : null,
                                child: const Text('Next'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }
} 