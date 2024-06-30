import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

class QuizScreen extends StatefulWidget {
  final String? userName;

  const QuizScreen({super.key, required this.userName});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Question> _questions = [
    Question(
        text: 'What is the capital of France',
        options: ['Paris', 'London', 'Berlin', 'Madrid'],
        answerIndex: 0),
    Question(
        text: 'Who wrote "To Kill a Mockingbird"',
        options: [
          'Harper Lee',
          'Mark Twain',
          'Ernest Hemingway',
          'F. Scott Fitzgerald'
        ],
        answerIndex: 0),
    // Add more questions here
  ];
  int _currentQuestionIndex = 0;
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    _timer?.cancel();
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timeRemaining = 60;
        _startTimer();
      });
    } else {
      _showResults();
    }
  }

  void _selectOption(int index) {
    if (index == _questions[_currentQuestionIndex].answerIndex) {
      _score += 10; // Assuming each question is worth 10 points
    }
    _nextQuestion();
  }
Future<void> _updatePoints(int score) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.userName);
    final doc = await userDoc.get();
    if (doc.exists) {
      int currentPoints = doc['points'] ?? 0;
      await userDoc.update({'points': currentPoints + score});
    }
  }
  void _showResults() {
    _timer?.cancel();
    _updatePoints(_score).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            score: _score,
            userName: widget.userName,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final optionsLabels = ['A', 'B', 'C', 'D'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Question',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Text('${_currentQuestionIndex + 1}',
                              style: const TextStyle(
                                  color: Color(0xffE21FD0),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text('/${_questions.length}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: const Color(0xff2100a6),
                        value: _timeRemaining / 60,
                      ),
                      Text(
                        '00:${_timeRemaining.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                color: const Color(0xff2100a6),
                value: _timeRemaining / 60,
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFFEBFF),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: const Color(0xffE21FD0),
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: Text.rich(
                              TextSpan(
                                text: question.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: ' ?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffE21FD0),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Icon(Icons.help,
                        size: 100,
                        color: const Color(0xffE21FD0).withOpacity(0.1)),
                  ),
                  Positioned(
                    bottom: -40,
                    left: -20,
                    child: Icon(Icons.question_answer,
                        size: 100,
                        color: const Color(0xffE21FD0).withOpacity(0.1)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white, // Text color
                        minimumSize: const Size(double.infinity,
                            50), // Make buttons fill width and have a height of 50
                        alignment:
                            Alignment.centerLeft, // Align text to the left
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      onPressed: () => _selectOption(index),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: const Color(0xffFBDEF8),
                              radius: 12,
                              child: Text(optionsLabels[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(child: Text(question.options[index])),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2100a6)),
                  onPressed: _nextQuestion,
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final int score;
  final String? userName;

  const ResultsScreen({super.key, required this.score, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const SizedBox(height: 30),
                Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Lottie.asset(
                    'assets/gif/congrats.json',
                    fit: BoxFit.contain,
                    repeat: true,
                    animate: true,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Text(
                      'Your score ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$score points',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xff2100a6),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2100a6)),
                ),
                const SizedBox(height: 10),
                Text(
                  '$userName have completed the quiz!',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 80,
              
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 219, 219, 219),
                    ),
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child:  Row(
                    children: [
                      SizedBox(width: 5),
                      CircleAvatar(
                        backgroundColor: Color(0xffFBDEF8),
                        radius: 14,
                        child: Icon(
                          Icons.diamond,
                          color: Color(0xffE21FD0),
                          size: 21,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$score',
                        style: TextStyle(
                          color: Color(0xff2100a6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2100a6)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int answerIndex;

  Question(
      {required this.text, required this.options, required this.answerIndex});
}
