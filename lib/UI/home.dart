import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:myapp/UI/quiz_page.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .get();
    if (doc.exists) {
      setState(() {
        _userName = doc['name'];
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
                Navigator.pop(context); // Close the drawer
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
            child: const Row(
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
                  'score',
                  style: TextStyle(
                    color: Color(0xff2100a6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
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
                        'Start Quiz',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Play and Win',
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  QuizScreen(userName: _userName)));
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
          const CategoryList(),
          const SizedBox(height: 16.0),
          const Text(
            'Recent',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          const Column(
            children: [
              QuizCard(
                title: 'History Quiz',
                questions: '10 questions',
                status: 'Completed',
                iconData: Icons.history,
                statusColor: Colors.green,
              ),
              QuizCard(
                title: 'Science Quiz',
                questions: '8 questions',
                status: 'In Progress',
                iconData: Icons.science,
                statusColor: Colors.orange,
              ),
              QuizCard(
                title: 'Sports Quiz',
                questions: '12 questions',
                status: 'Completed',
                iconData: Icons.sports_soccer,
                statusColor: Colors.green,
              ),
              QuizCard(
                title: 'Music Quiz',
                questions: '15 questions',
                status: 'In Progress',
                iconData: Icons.music_note,
                statusColor: Colors.orange,
              ),
            ],
          ),
        ])),
      ),
    ));
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 150, // Adjust the width of the card
        height: 120, // Adjust the height of the card
        decoration: BoxDecoration(
          color: const Color(0xffFFEBFF),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            // Background icon
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
                  // const Spacer(),
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
    );
  }
}

class QuizCard extends StatelessWidget {
  final String title;
  final String questions;
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
              child: Icon(iconData, size: 30, color: Colors.grey.shade800),
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
                  Text(
                    questions,
                    style: const TextStyle(
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

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryCard(title: 'History', icon: Icons.history_edu),
          SizedBox(
            width: 5,
          ),
          CategoryCard(title: 'Science', icon: Icons.science),
          SizedBox(
            width: 5,
          ),
          CategoryCard(title: 'Sports', icon: Icons.sports_soccer),
          SizedBox(
            width: 5,
          ),
          CategoryCard(title: 'Music', icon: Icons.music_note),
          SizedBox(
            width: 5,
          ),
          // Add more categories here
        ],
      ),
    );
  }
}
