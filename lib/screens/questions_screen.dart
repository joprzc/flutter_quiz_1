import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/components/answer_button.dart';
import 'package:flutter_quiz/models/quiz_questions.dart';
//import 'package:flutter_quiz/components/answer_button.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_quiz/data/questions.dart';

// paso 3 mostrar las preguntas en pantalla
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.quizId,
    required this.onSelectAnswer,
    required this.onQuestionsLoaded,
  });

  final int? quizId;
  // elgir la respuesta correcta
  final void Function(String answer) onSelectAnswer;

  final void Function(List<QuizQuestions>) onQuestionsLoaded;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Map<String, dynamic>? quizData;

  List<QuizQuestions> preguntas = []; //lista de preguntas
  int preguntaActual = 0; // indice actual

  Future<void> obtenerAnswers() async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2:8000/api/quizzes/${widget.quizId}/',
      );
      //peticion a Django que devuelva info
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        //  Mapeo de preguntas desde JSON a objetos QuizQuestions
        final questionsList =
            (data['questions'] as List).map((q) {
              return QuizQuestions(
                q['question_text'],
                List<String>.from(q['options']),
              );
            }).toList();

        setState(() {
          //quizData = jsonDecode(response.body);
          preguntas = questionsList;
        });
        // llamar al callback para informar al widget padre(quiz.dart)
        widget.onQuestionsLoaded(questionsList);
        // widget.onQuestionsLoaded(preguntas);
      } else {
        print('Error al cargar detalle: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexion o parsing: $e');
    }
  }

  //  funcion para pasar a la siguiente pregunta
  // void pasarASiguientePregunta() {
  //   setState(() {
  //     if (preguntaActual < preguntas.length - 1) {
  //       preguntaActual++;
  //     } else {
  //       //  pasar a una pantalla de resultados
  //       print('Fin del quiz');
  //     }
  //   });
  // }
  //  funcion para pasar a la siguiente pregunta
  // y elegir la respuesta correcta
  void pasarASiguientePregunta(String selectedAnswer) {
    //elegir las respuesta correcta
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      if (preguntaActual < preguntas.length - 1) {
        preguntaActual++;
      } else {
        //  pasar a una pantalla de resultados
        // print('Fin del quiz');
        widget.onSelectAnswer(selectedAnswer);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    obtenerAnswers();
  }

  /*
  @override
  Widget build(BuildContext context) {
    //pasar las preguntas

    // ignore: sized_box_for_whitespace
    return Container(
      margin: const EdgeInsets.all(30), // ajustar ancho de botones
      width: double.infinity,
      height: double.infinity,
      // ¡No pongas color ni decoración aquí!
      child: Center(
        child:
            quizData == null
                ? const CircularProgressIndicator(color: Colors.white)
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      quizData!['questions'][0]['question_text'].replaceAll(
                        '"',
                        '',
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      //  amplia los botones en toda la pantalla
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...List.generate(
                          (quizData!['questions'][0]['options'] as List).length,
                          (index) {
                            final option =
                                quizData!['questions'][0]['options'][index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  print('Opción seleccionada: $option');
                                },
                                child: Text(option.toString()),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
  */
  @override
  Widget build(BuildContext context) {
    if (preguntas.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    final pregunta = preguntas[preguntaActual];

    return Container(
      margin: const EdgeInsets.all(30), // ajustar ancho de botones
      width: double.infinity,
      height: double.infinity,
      child: Column(
        //  amplia los botones en toda la pantalla
        crossAxisAlignment: CrossAxisAlignment.stretch,

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            pregunta.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Mostrar las respuestas barajadas
          ...pregunta.getShuffledAnswers().map((opcion) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              /*
              child: ElevatedButton(
                onPressed: () {
                  print('Respuesta: $opcion');
                  pasarASiguientePregunta();
                },
                child: Text(opcion),
              ),
              */
              child: AnswerButton(
                text: opcion,
                onTap: () {
                  // print('Respuesta: $opcion');
                  pasarASiguientePregunta(opcion);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
