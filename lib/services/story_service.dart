import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StoryService {
  // In the future, this will call an AI or backend to generate the story.
  Future<String> generateStory({
    required String title,
    required String about,
    required String length,
    required String age,
    required String characters,
    required String other,
  }) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      return 'API key not found. Please set OPENAI_API_KEY in your .env file.';
    }
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    String prompt = 'Write a bedtime story for a child';
    if (age.trim().isNotEmpty) {
      prompt += ' who is $age years old';
    }
    prompt += '. ';

    if (title.trim().isNotEmpty) {
      prompt += 'The story should be titled "$title". ';
    } else {
      prompt += 'Invent a creative and fitting title. ';
    }

    if (about.trim().isNotEmpty) {
      prompt += 'It should be about "$about". ';
    } else {
      prompt += 'Invent an interesting topic or theme for the story. ';
    }

    if (characters.trim().isNotEmpty) {
      prompt += 'Include the following characters: $characters. ';
    } else {
      prompt += 'Invent suitable characters for the story. ';
    }

    if (other.trim().isNotEmpty) {
      prompt += '$other. ';
    }

    if (length.trim().isNotEmpty) {
      prompt += 'The story should take about $length minutes to read. ';
    } else {
      prompt += 'Choose an appropriate length for a bedtime story.';
    }

    prompt += 'Make it imaginative, positive, and age-appropriate.';

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: jsonEncode({
              'model': 'gpt-3.5-turbo',
              'messages': [
                {'role': 'system', 'content': 'You are a helpful assistant that writes bedtime stories for children.'},
                {'role': 'user', 'content': prompt},
              ],
              'max_tokens': 800,
              'temperature': 0.8,
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final story = data['choices'][0]['message']['content'];
        return story.trim();
      } else {
        return 'Sorry, there was an error generating your story.';
      }
    } on TimeoutException {
      return 'Sorry, the story generation took too long. Please try again later.';
    } catch (e) {
      return 'Sorry, there was a network error generating your story.';
    }
  }
} 