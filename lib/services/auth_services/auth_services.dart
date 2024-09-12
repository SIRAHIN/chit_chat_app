

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // login service //

     Future<UserCredential> signinWithEmailandPass(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception('An unknown error occurred.');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<UserCredential> registrationWithEmailandPass(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use by another account.');
      } else if (e.code == 'weak-password') {
        throw Exception('The password is too weak.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception('An unknown error occurred.');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // for sign Out //
  Future<void> signOut () async {
   return await _auth.signOut();
  }

}




