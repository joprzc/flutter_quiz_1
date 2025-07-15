import 'package:flutter/material.dart';

// resumen de las preguntas resueltas
class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          summaryData.map((preguntas) {
            return Row(
              children: [
                Text(((preguntas['questions_index'] as int) + 1).toString()),
                Expanded(
                  child: Column(
                    children: [
                      Text(preguntas['questions'] as String),
                      const SizedBox(height: 5),
                      Text(preguntas['user_answer'] as String),
                      const SizedBox(height: 5),
                      Text(preguntas['correct_answer'] as String),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
