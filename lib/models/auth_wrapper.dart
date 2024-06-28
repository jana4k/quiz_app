import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/UI/home.dart';
import 'package:myapp/UI/login.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>( 
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,AsyncSnapshot<User?> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting){
           return const CircularProgressIndicator();
         }else{
          if (snapshot.hasData) {
            return HomePage(user: snapshot.data!,);
          } else {
              
            return const loginPage();
          }
        }}
      ),
    );
  }
}