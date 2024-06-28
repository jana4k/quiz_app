import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

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
                child: const CircleAvatar(
                  backgroundColor: Color(0xffEB60DF),
                  child: Icon(Icons.person, size: 30, color: Colors.white),
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
                      color: Color(0xffE21FD0) ,
                      size: 21,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '200',
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
        body: Center(
          child: Text('Welcome ${widget.user.email}'),
        ),
      ),
    );
  }
}
