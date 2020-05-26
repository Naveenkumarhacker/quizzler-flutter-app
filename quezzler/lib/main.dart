import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

QuizBrain quizBrain = new QuizBrain();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Quizzler(),
          ),
        ),
      ),
    );
  }
}

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  @override
  List<Icon> scoreKeeper = [];

  changeNext(bool userAnswer) {
    if (quizBrain.isFinished() == true) {
      setState(() {
        quizBrain.reset();
        Alert(
                context: context,
                title: "Quezzler",
                desc: "Exam Over Completely.")
            .show();
        scoreKeeper = [];
      });
    } else {
      bool correctAnswer = quizBrain.questionAnswer();
      setState(() {
        if (correctAnswer == userAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      });
      quizBrain.nextNumber();
    }
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              child: Text(
                'TRUE',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              color: Colors.green,
              onPressed: () {
                changeNext(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              child: Text(
                'FALSE',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              color: Colors.red,
              onPressed: () {
                changeNext(false);
              },
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: scoreKeeper,
        ),
      ],
    );
  }
}
