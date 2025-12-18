import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rasadharma_app/data/classes/user.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';
import 'package:rasadharma_app/data/enums/pref_keys_enums.dart';
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
      
      try {
        await result.user?.sendEmailVerification();
      } catch (e) {
        log('Failed to send verification email: $e');
      }
      
      await _auth.signOut();

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
        role: doc['role'],
      );
      String userJson = jsonEncode(loggedUser.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(PrefkeysEnums.loggedUser, userJson);
    } catch (e) {
      log("Error fetching user: $e");
    }
  }

  Future<UserBHT?> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(PrefkeysEnums.loggedUser);

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserBHT.fromJson(jsonMap);
  }

  /// Login existing user
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      // If email not verified, send verification and prevent access
      if (user != null && !user.emailVerified) {
        try {
          await user.sendEmailVerification();
        } catch (e) {
          log('Failed to resend verification email: $e');
        }

        await _auth.signOut();
        throw 'Email not verified. A verification email has been sent. Please verify before logging in.';
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Login failed";
    }
  }

  /// Send password reset email
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Failed to send password reset email';
    }
  }

  /// Resend verification email for currently signed-in user
  Future<void> resendVerificationForCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) throw 'No signed-in user to send verification to.';

    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Failed to send verification email';
    }
  }

  /// Logout
  Future<void> logout() async {
    // Firebase sign out
    await _auth.signOut();

    // Clear local session
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Stream for auth changes
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  /// Get user data from Firestore
  Future<UserBHT?> getUserFromCollection(String uid) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(uid).get();
      if (doc.exists) {
        return UserBHT(
          id: doc['id'],
          nama: doc['nama'],
          email: doc['email'],
          noTelp: doc['no_telp'],
          role: doc['role'],
        );
      }
      return null;
    } catch (e) {
      log("Error fetching user from collection: $e");
      return null;
    }
  }

  /// Update user data in Firestore
  Future<void> updateUserInCollection(String uid, Map<String, dynamic> updates) async {
    try {
      await _userCollection.doc(uid).update(updates);
    } catch (e) {
      log("Error updating user: $e");
      throw e;
    }
  }

  /// Update email in Firebase Auth and send verification
  Future<void> updateEmail(String newEmail) async {
    final user = _auth.currentUser;
    if (user == null) throw 'No signed-in user';

    try {
      await user.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Failed to update email';
    }
  }
}
