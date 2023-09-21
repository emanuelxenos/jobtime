import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_sersvice.dart';

class AuthSersviceImpl implements AuthSersvice {
  @override
  Future<void> signIn() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }
}
