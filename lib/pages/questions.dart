// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// /*
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: QuizQuestions(quizId: 1), // Cambia el id si hace falta
//   ));
// }
// */

// class QuizQuestions extends StatefulWidget {
//   final int quizId;
//   QuizQuestions({required this.quizId});

//   @override
//   _QuizQuestionsState createState() => _QuizQuestionsState();
// }

// class _QuizQuestionsState extends State<QuizQuestions> {
//   bool cargando = true;
//   List preguntas = [];
//   int indiceActual = 0;
//   String quizTitle = '';

//   @override
//   void initState() {
//     super.initState();
//     cargarPreguntas();
//   }

//   Future<void> cargarPreguntas() async {
//     final url = Uri.parse('http://10.0.2.2:8000/api/quizzes/${widget.quizId}/');
//     final respuesta = await http.get(url);

//     if (respuesta.statusCode == 200) {
//       final data = jsonDecode(respuesta.body);
//       setState(() {
//         quizTitle = data['title'];
//         preguntas = data['questions'] ?? [];
//         cargando = false;
//       });
//     } else {
//       print('Error: ${respuesta.statusCode}');
//     }
//   }

//   void siguiente() {
//     setState(() {
//       if (indiceActual < preguntas.length - 1) {
//         indiceActual++;
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('¡Quiz finalizado!')));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (cargando) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Cargando...')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (preguntas.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Quiz vacío')),
//         body: Center(child: Text('No hay preguntas.')),
//       );
//     }

//     final pregunta = preguntas[indiceActual];

//     return Scaffold(
//       appBar: AppBar(title: Text(quizTitle)),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Pregunta ${indiceActual + 1}/${preguntas.length}',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             Text(
//               pregunta['text'],
//               style: TextStyle(fontSize: 24),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(onPressed: siguiente, child: Text('Siguiente')),
//           ],
//         ),
//       ),
//     );
//   }
// }
