import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_quiz/components/answer_button.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_quiz/data/questions.dart';

// paso 3 mostrar las preguntas en pantalla
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.quizId});

  final int? quizId;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Map<String, dynamic>? quizData;

  Future<void> obtenerAnswers() async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2:8000/api/quizzes/${widget.quizId}/',
      );
      //peticion a Django que devuelva info
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          quizData = jsonDecode(response.body);
        });
      } else {
        print('Error al cargar detalle: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexion o parsing: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerAnswers();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
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
}
