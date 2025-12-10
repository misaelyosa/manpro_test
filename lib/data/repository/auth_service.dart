import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection(CollectionEnums.user);

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

  void addUserToCollection(String uid, String email, String nama, String noTelp, String role){
    _userCollection.doc(uid).set({
      'id': uid,
      'email': email,
      'nama': nama,
      'no_telp': noTelp,
      'role': role,
    });
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
