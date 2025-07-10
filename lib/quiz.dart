import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/api_questions.dart';
import 'package:flutter_quiz/screens/questions_screen.dart';
//import 'package:flutter_quiz/screens/questions_screen.dart';
import 'package:flutter_quiz/screens/start_screen.dart';

//paso 3
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // paso 4 creo una variable de tipo widget y asignas una instancia StartScreen
  //Widget activeScreen = const StartScreen(switchScreen);
  /*
  Widget? activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(switchScreen);
  }
  */
  int? selectedQuizId;
  var activeScreen = 'start-screen';

  void switchApiQuestions() {
    setState(() {
      activeScreen = 'api-questions';
    });
  }

  void switchApiQuestions1(int quizId) {
    setState(() {
      selectedQuizId = quizId;
      activeScreen = 'questions-screen';
    });
  }

  void switchQuestionsScreen(int quizId) {
    setState(() {
      selectedQuizId = quizId;
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    if (activeScreen == 'start-screen') {
      screenWidget = StartScreen(switchApiQuestions);
    } else if (activeScreen == 'api-questions') {
      screenWidget = ApiQuestions(onQuizSelected: switchApiQuestions1);
    } else if (activeScreen == 'questions-screen' && selectedQuizId != null) {
      screenWidget = QuestionsScreen(quizId: selectedQuizId!);
    } else {
      screenWidget = const Center(child: Text('No se ha seleccionado un quiz'));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false, //quitar etiqueta DEBUG
      home: Scaffold(
        // crear fondo de pantalla
        body: Container(
          decoration: const BoxDecoration(
            //distribuir color
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 112, 63, 197),
                Color.fromARGB(255, 71, 38, 128),
              ],
            ),
          ),
          //child: const Text('Start Screen'),
          //child: const StartScreen(), //llamo a la clase StartScreen
          //child: activeScreen, //cambia de ventana
          child: screenWidget, //cambia de ventana
        ),
      ),
    );
  }
}
