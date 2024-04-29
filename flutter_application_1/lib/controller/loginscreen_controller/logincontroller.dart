import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginscreenController with ChangeNotifier {
  bool isLoading = false;
  // write fn to register new user
  Future<bool> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      isLoading = true;
      notifyListeners();

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {
        isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The password provided is too weak.")));
        isLoading = false;
        notifyListeners();
        return false;
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Wrong password provided for that user.')));
        // print('The account already exists for that email.');
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      return false;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }
}
