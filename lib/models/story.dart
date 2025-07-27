class Story {
  final String title;
  final String about;
  final String length;
  final String age;
  final String characters;
  final String other;
  final String? generatedText;

  Story({
    required this.title,
    required this.about,
    required this.length,
    required this.age,
    required this.characters,
    required this.other,
    this.generatedText,
  });
} 