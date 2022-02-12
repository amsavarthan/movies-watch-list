import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static Future<String?> signInWithGoogle() async {
    try {
      final _googleSignInAccount = await GoogleSignIn().signIn();
      final _googleSignInAuthentication =
          await _googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  static Future<void> signOutFromGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
