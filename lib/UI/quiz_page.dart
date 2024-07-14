import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';


class Question {
  final String id;
  final String text;
  final List<String> options;
  final int answerIndex;
  final String? image;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.answerIndex,
    this.image,
  });
  

  // Create a factory method to convert a Map into a Question object
  factory Question.fromMap(Map<String, dynamic> map, String id) {
    return Question(
      id: id,
      text: map['text'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      answerIndex: map['answerIndex'] ?? 0,
      image: map['image'] as String?,
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String? userName;
  final User user;
  final String category;

  const QuizScreen({
    super.key,
    required this.userName,
    required this.user,
    required this.category,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 60;
  late List<Question> _questions;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions().then((questions) {
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
      _startTimer();
    });
    _updateQuizStatus(
        widget.user, widget.category, 'in_progress', _currentQuestionIndex);
  }

  Future<void> _updateQuizStatus(
      User user, String quizId, String status, int currentQuestionIndex) async {
    final userQuizStatusDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('userQuizStatus')
        .doc(quizId);

    await userQuizStatusDoc.set({
      'quizId': quizId,
      'status': status,
      'currentQuestionIndex': _currentQuestionIndex,
    });
  }

  Future<List<Question>> _fetchQuestions() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .doc(widget.category)
        .get();
    if (querySnapshot.exists) {
      final data = querySnapshot.data();
      final questionsData = data?['questions'] as List<dynamic>?;
      return questionsData
              ?.map((q) => Question.fromMap(q, q['id'] ?? ''))
              .toList() ??
          [];
    } else {
      return [];
    }
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
      _updateQuizStatus(
          widget.user, widget.category, 'in_progress', _currentQuestionIndex);
    } else {
      _updateQuizStatus(
          widget.user, widget.category, 'completed', _questions.length);
      _showResults();
    }
  }

  void _selectOption(int index) {
    if (index == _questions[_currentQuestionIndex].answerIndex) {
      _score += 10;
    }
    _nextQuestion();
  }

  Future<void> _updatePoints(int score) async {
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
    final doc = await userDoc.get();
    if (doc.exists) {
      int currentPoints = doc['points'] ?? 0;
      await userDoc.update({'points': currentPoints + score});
    }
  }

  void _showResults() {
    _timer?.cancel();
    _updateQuizStatus(
        widget.user, widget.category, 'completed', _currentQuestionIndex = 0);
    _updatePoints(_score).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            userName: widget.userName,
            userId: widget.user.uid,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final optionsLabels = ['A', 'B', 'C', 'D', 'E'];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
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
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
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
                                  )),
                                
                                ],
                              ),
                            
                                if (question.image != null)
                                    Container(
                                                                          child: Image.network(question.image!),
                                                                        ),  const SizedBox(height: 10),
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
                              backgroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              alignment: Alignment.centerLeft,
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
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2100a6)),
                onPressed: _nextQuestion,
                child: const Text('Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final int score;
  final String userId;
  final String? userName;

  const ResultScreen(
      {super.key,
      required this.score,
      required this.userId,
      required this.userName});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _points = 0;
  Future<int> _fetchPoints() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
    if (doc.exists) {
      setState(() {
        _points = doc['points'] ?? 0;
      });
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    _fetchPoints();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  height: 250,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.score} points',
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
                  '${widget.userName}, you have completed the quiz!',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 85,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 219, 219, 219),
                    ),
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      const CircleAvatar(
                        backgroundColor: Color(0xffFBDEF8),
                        radius: 14,
                        child: Icon(
                          Icons.diamond,
                          color: Color(0xffE21FD0),
                          size: 21,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$_points',
                        style: const TextStyle(
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
                    Navigator.popUntil(context, (route) => route.isFirst);
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
