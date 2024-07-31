import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:myapp/UI/quiz_page.dart';
// import 'package:myapp/models/question.dart';

import 'package:myapp/widgets/loading_dialog.dart';

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}

Future<List<Category>> fetchCategories() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('questions').get();
  return querySnapshot.docs
      .map((doc) => Category.fromMap(doc.data(), doc.id))
      .toList();
}

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _userName;
  int _points = 0;

  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _connectivityService.initialize(context);
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  void _onCategorySelected(BuildContext context, String category) async {
    if (await _showAccessCodeDialog(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            userName: _userName,
            user: widget.user,
            category: category,
          ),
        ),
      ).then((_) {
        _fetchUserName();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect access code.'),
        ),
      );
    }
  }

  Future<void> _fetchUserName() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .get();
    if (doc.exists) {
      setState(() {
        _userName = doc['name'];
        _points = doc['points'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_userName ?? 'User'),
              accountEmail: Text(widget.user.email ?? ''),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color(0xffFBDEF8),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Version 1.0.0',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffEB60DF),
                        width: 2.0,
                      ),
                    ),
                    child: const Icon(Icons.person,
                        size: 35, color: Color(0xffEB60DF))),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi! ${_userName ?? 'User'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                const Text(
                  'Ready to play',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                const SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(6),
              child: SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 243, 243, 243),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.grey,
                      size: 35,
                    ),
                    labelText: 'Search for a quiz',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 141, 141, 141),
                    ),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff2100a6),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    // Background design elements
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Icon(Icons.quiz,
                          size: 100, color: Colors.white.withOpacity(0.1)),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -20,
                      child: Icon(Icons.star,
                          size: 100, color: Colors.white.withOpacity(0.1)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TekZow Courses',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Enroll Your Courses Now!',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white, // Text color
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 8.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {
                            //  addQuestionsToFirestore();
                            final quizStatus =
                                await _fetchQuizStatus(widget.user, 'Aptitude');
                            if (await _showAccessCodeDialog(
                                context)) if (quizStatus ==
                                    'not_started' ||
                                quizStatus == 'in_progress') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(
                                    userName: _userName,
                                    user: widget.user,
                                    category: 'Aptitude',
                                  ),
                                ),
                              ).then((_) {
                                _fetchUserName();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('You have completed this Quiz!'),
                                ),
                              );
                            }
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Get Started',
                                  style: TextStyle(
                                      color: Color(0xff2100a6),
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 2.0),
                              Icon(
                                Icons.arrow_right,
                                size: 24,
                                color: Color(0xff2100a6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              textAlign: TextAlign.left,
              'Categories',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            CategoryList(
              onCategorySelected: (category) =>
                  _onCategorySelected(context, category),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Recent',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            RecentSection(user: widget.user),
          ]),
        ),
      ),
    ));
  }
}

Future<String> _fetchQuizStatus(User user, String quizId) async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('userQuizStatus')
      .doc(quizId)
      .get();
  if (doc.exists) {
    return doc['status'];
  }
  return 'not_started';
}

class QuizCard extends StatelessWidget {
  final String title;
  final int questions;
  final String status;
  final IconData iconData;
  final Color statusColor;

  const QuizCard({
    required this.title,
    required this.questions,
    required this.status,
    required this.iconData,
    required this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Icon(iconData,
                  size: 30, color: const Color.fromARGB(255, 107, 107, 107)),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  if (statusColor == Colors.orange)
                    Text(
                      '$questions questions answered',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  if (statusColor == Colors.green)
                    const Text(
                      'you have completed this Quiz!',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  if (statusColor == Colors.blue)
                    const Text(
                      'Join This Quiz!',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xffFFEBFF),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 35,
                right: -20,
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      const Offset(4.0, 25.0),
                      const Offset(25.0, 5.0),
                      const [Colors.purple, Colors.blue],
                    );
                  },
                  child: Icon(
                    icon,
                    size: 100,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff2100a6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
    'currentQuestionIndex': 0,
  });
}

Future<List<QuizStatus>> fetchUserQuizStatuses(User user) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('userQuizStatus')
      .get();

  final quizStatuses = querySnapshot.docs.map((doc) {
    final data = doc.data();
    return QuizStatus(
      quizId: data['quizId'],
      status: data['status'],
      currentQuestionIndex: data['currentQuestionIndex'],
    );
  }).toList();

  return quizStatuses;
}

class QuizStatus {
  final String quizId;
  final String status;
  final int currentQuestionIndex;

  QuizStatus({
    required this.quizId,
    required this.status,
    required this.currentQuestionIndex,
  });
}

class RecentSection extends StatelessWidget {
  final User user;

  const RecentSection({super.key, required this.user});

  IconData getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Java':
        return Icons.computer;
      case 'Python':
        return Icons.code;
      case 'Aptitude':
        return Icons.calculate;
      case 'CyberSecurity':
        return Icons.security_sharp;
      case 'JavaScript':
        return Icons.javascript;
      case 'HTML-and-CSS':
        return Icons.web;
      case 'Database':
        return Icons.data_object;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizStatus>>(
      future: fetchUserQuizStatuses(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return QuizCard(
                  title: 'Aptitude',
                  status: 'Get Started',
                  statusColor: Colors.blue,
                  questions: 0,
                  iconData: getCategoryIcon('Aptitude'),
                );
              });
        }

        final quizStatuses = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quizStatuses.length,
          itemBuilder: (context, index) {
            final quizStatus = quizStatuses[index];
            String statusText;
            Color statusColor;
            int questions;

            switch (quizStatus.status) {
              case 'not_started':
                statusText = 'Get Started';
                statusColor = Colors.blue;
                questions = 0;
                break;
              case 'in_progress':
                statusText = 'In Progress';
                statusColor = Colors.orange;
                questions = quizStatus.currentQuestionIndex + 1;
                break;
              case 'completed':
                statusText = 'Completed';
                statusColor = Colors.green;
                questions = 0;
                break;
              default:
                statusText = 'Unknown';
                statusColor = Colors.grey;
                questions = 0;
            }

            return QuizCard(
              title: quizStatus.quizId,
              status: statusText,
              statusColor: statusColor,
              questions: questions,
              iconData: getCategoryIcon(quizStatus.quizId),
            );
          },
        );
      },
    );
  }
}

Future<String> fetchAccessCode() async {
  final doc = await FirebaseFirestore.instance
      .collection('accessCode')
      .doc('code')
      .get();
  if (doc.exists) {
    return doc['password'];
  }
  return '';
}

Future<bool> _showAccessCodeDialog(BuildContext context) async {
  final TextEditingController codeController = TextEditingController();
  bool isCodeCorrect = false;

  final String correctCode = await fetchAccessCode();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter Access Code'),
        content: TextField(
          controller: codeController,
          keyboardType: TextInputType.number,
          obscureText: true,
          decoration: const InputDecoration(hintText: '4-digit code'),
          maxLength: 4,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (codeController.text == correctCode) {
                isCodeCorrect = true;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Incorrect access code.'),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );

  return isCodeCorrect;
}

class CategoryList extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  IconData getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Java':
        return Icons.computer;
      case 'Python':
        return Icons.code;
      case 'Aptitude':
        return Icons.calculate;
      case 'CyberSecurity':
        return Icons.security_sharp;
      case 'JavaScript':
        return Icons.javascript;
      case 'HTML-and-CSS':
        return Icons.web;
      case 'Database':
        return Icons.data_object;
      default:
        return Icons.category;
    }
  }

  Future<String> _fetchQuizStatus(User user, String quizId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('userQuizStatus')
        .doc(quizId)
        .get();
    if (doc.exists) {
      return doc['status'];
    }
    return 'not_started';
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;

    return FutureBuilder<List<Category>>(
      future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        final categories = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              return CategoryCard(
                title: category.name,
                icon: getCategoryIcon(category.name),
                onTap: () async {
                  final quizStatus = await _fetchQuizStatus(user, category.id);
                  if (quizStatus == 'not_started' ||
                      quizStatus == 'in_progress') {
                    onCategorySelected(category.id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You have completed this Quiz!'),
                      ),
                    );
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
