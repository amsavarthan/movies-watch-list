import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_watch_list/src/services/firebase_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _signInWithGoogle(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseService.signInWithGoogle();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Movies Watch List',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A Flutter project created for ZuPay Internship Assignment',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          color: Colors.black38,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => _signInWithGoogle(context),
                      child: const Text('Sign In with Google'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
