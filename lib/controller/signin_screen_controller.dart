import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import '../../view/homescreen/home_screen.dart';

class SigninScreenController with ChangeNotifier {
  bool isLoading = false;

  onSignIn({
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      if (credential.user?.uid != null) {
        String userId = credential.user!.uid;

        // Get current time and format it
        String formattedTime =
            DateFormat("MMMM d, y, h:mm a").format(DateTime.now());
        // Extract name from email (removing @gmail.com)
        String name = email.split('@')[0];

        // Store login details in Firestore
        await FirebaseFirestore.instance
            .collection("loginInfo")
            .doc(userId)
            .set(
          {
            'email': email,
            'name': name,
            'password': pass,
            'time': formattedTime, // Formatted login time
          },
          SetOptions(merge: true), // Merge to update only the 'time' field
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Signed In successfully",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );

        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle invalid credentials error
      String errorMessage = "Something went wrong. Please try again.";
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
