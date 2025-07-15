import 'package:flutter/material.dart';
import 'package:flutter_quiz/components/quetions_summary.dart';
import 'package:flutter_quiz/models/quiz_questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.preguntas,
    required this.onRestart,
  });

  // mostrar preguntas resueltas en resultados
  final List<String> chosenAnswers;
  final List<QuizQuestions> preguntas;
  final void Function() onRestart;

  // lista para mostrar resumen de preguntas resueltas
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questions_index': i,
        'questions': preguntas[i].text,
        'correct_answer': preguntas[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // cubrir toda la pantalla
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //centrar elementos
        children: [
          const Text('You answered X of Y questions correcttly!'),
          const SizedBox(height: 30),
          // const Text('List of answers and questions'),
          QuestionsSummary(getSummaryData()),
          const SizedBox(height: 30),
          // OutlinedButton(onPressed: () {}, child: Text('Restart Quiz!')),
          // boton para reiniciar quiz
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.restart_alt),
            onPressed: () {},
            label: const Text('Restart Quiz!'),
          ),
        ],
      ),
    );
  }
}
