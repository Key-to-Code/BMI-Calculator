import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyC2UbHb1f2Lxh08N-eGr2iuIM9kRrANG2c';

  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  static Future<String> getPersonalizedAnalysis({
    required double bmi,
    required String category,
    required int age,
    required String goal,
    required String gender,
  }) async {
    try {
      final prompt = '''
You are a health advisor. Provide a personalized health analysis for a person with the following details:
- BMI: ${bmi.toStringAsFixed(1)}
- BMI Category: $category
- Age: $age years old
- Goal: $goal
- Gender: $gender

Write a comprehensive paragraph (about 150-200 words) analyzing their current health status based on BMI, and provide insights on how they can achieve their goal. Be encouraging and supportive. Do not use bullet points or numbered lists, write in paragraph form only.
''';

      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 500,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString().trim();
        }
      }
      return _fallbackAnalysis(bmi, category, age, goal);
    } catch (e) {
      return _fallbackAnalysis(bmi, category, age, goal);
    }
  }

  static Future<List<String>> getRecommendedActions({
    required double bmi,
    required String category,
    required String goal,
    required int age,
    required String gender,
  }) async {
    try {
      final prompt = '''
Based on the following health data, provide exactly 2 specific, actionable health recommendations:
- BMI: ${bmi.toStringAsFixed(1)}
- BMI Category: $category
- Goal: $goal
- Age: $age years old
- Gender: $gender

Return ONLY 2 recommendations. Each recommendation should be 2-3 sentences. Be specific and actionable. Do NOT include numbering, bullet points, or any prefix. Just return the two recommendations separated by a newline.
''';

      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 300,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text != null && text.toString().trim().isNotEmpty) {
          final lines = text
              .toString()
              .split('\n')
              .map((line) => line.replaceAll(RegExp(r'^[\d]+[\.\)\-\:]\s*'), '').trim())
              .where((line) => line.isNotEmpty)
              .toList();
          if (lines.length >= 2) return lines.take(2).toList();
          if (lines.isNotEmpty) return lines;
        }
      }
      return _fallbackRecommendations(goal);
    } catch (e) {
      return _fallbackRecommendations(goal);
    }
  }

  static String _fallbackAnalysis(double bmi, String category, int age, String goal) {
    return 'Your current BMI of ${bmi.toStringAsFixed(1)} indicates that you fall within '
        'the $category range for your age and sex. This is a '
        'positive indicator as it suggests that your body weight '
        'is generally in line with your height. However, since your '
        'goal is to ${goal.toLowerCase()}, it\'s important to approach this '
        'process thoughtfully. Aiming for gradual changes '
        'can be beneficial for maintaining muscle mass and '
        'overall health, rather than drastic changes that might '
        'not be sustainable. Incorporating more physical activity into your '
        'routine can help you reach your goals while also improving '
        'your overall fitness levels. Nutritional adjustments, in '
        'combination with more exercise, can enhance your '
        'results. It\'s important to focus not just on caloric '
        'changes but on the quality of the foods you consume, '
        'optimizing your diet for nutrient-rich choices that '
        'support your health goals.';
  }

  static List<String> _fallbackRecommendations(String goal) {
    final g = goal.toLowerCase();
    if (g.contains('lose')) {
      return [
        'Increase your activity level by incorporating more cardiovascular exercises like jogging, cycling, or swimming at least 3-4 times a week.',
        'Focus on a balanced diet with plenty of vegetables, lean proteins, and whole grains while reducing processed foods and sugary drinks.',
      ];
    } else if (g.contains('gain')) {
      return [
        'Increase your caloric intake by 300-500 calories per day with nutrient-dense foods like nuts, avocados, and whole grains.',
        'Incorporate strength training exercises 3-4 times per week to build muscle mass effectively.',
      ];
    }
    return [
      'Maintain your current balanced diet and continue regular physical activity to preserve your healthy weight.',
      'Incorporate a mix of cardio and strength training exercises to maintain muscle mass and cardiovascular health.',
    ];
  }
}
