import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;

  User? user;

  @override
  void onInit() {
    super.onInit();
    user = _auth.currentUser;
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = _auth.currentUser;

      // ScaffoldMessenger로 Snackbar 표시
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      user = null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
