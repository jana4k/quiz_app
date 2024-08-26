import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/UI/course.dart';
import 'package:myapp/UI/home.dart';
import 'package:myapp/UI/login.dart';
import 'package:myapp/UI/welcome.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(user: FirebaseAuth.instance.currentUser!),
    const CoursePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return Scaffold(
                body: _pages[_selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Course',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  elevation: 1,
                  selectedItemColor: const Color(0xff2100a6),
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  showUnselectedLabels: true,
                  unselectedLabelStyle: TextStyle(color: Colors.grey.shade700),
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: 12,
                  unselectedFontSize: 10,
                  iconSize: 28,
                  onTap: _onItemTapped,
                ),
              );
            } else {
              return const Welcome();
            }
          }
        },
      ),
    );
  }
}
