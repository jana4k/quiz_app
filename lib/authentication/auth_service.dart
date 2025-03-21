import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/authentication/auth_exception.dart';

class AuthService {
  late AuthResultStatus status;

  Future<AuthResultStatus> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
 await _saveUserDetails(
            name: name, email: email, userId: authResult.user!.uid);
          // await  authResult.user!.updateDisplayName(name);
       if (authResult.user != null) {
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleException(e);
    } catch (e) {
      status = AuthResultStatus.undefined;
    }
    return status;
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
     
        print(e);
      
    }
  }
  Future<AuthResultStatus> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (authResult.user != null) {
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleException(e);
    } catch (e) {
      status = AuthResultStatus.undefined;
    }
    return status;
  }

  Future<void> _saveUserDetails({
    required String name,
    required String email,
    required String userId,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'userId': userId,
      'points': 0,
    });
  }
}
 