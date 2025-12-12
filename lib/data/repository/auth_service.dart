import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rasadharma_app/data/classes/user.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection(CollectionEnums.user);

  /// Register new user
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Registration failed";
    }
  }

  void addUserToCollection(
    String uid,
    String email,
    String nama,
    String noTelp,
    String role,
  ) {
    _userCollection.doc(uid).set({
      'id': uid,
      'email': email,
      'nama': nama,
      'no_telp': noTelp,
      'role': role,
    });
  }

  Future<void> logUserSharedpref(String uid) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(uid).get();
      UserBHT loggedUser = UserBHT(
        id: doc['id'],
        nama: doc['nama'],
        email: doc['email'],
        noTelp: doc['no_telp'],
      );
      String userJson = jsonEncode(loggedUser.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedUser', userJson);
    } catch (e) {
      log("Error fetching user: $e");
    }
  }

  /// Login existing user
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Login failed";
    }
  }

  /// Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Stream for auth changes
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
