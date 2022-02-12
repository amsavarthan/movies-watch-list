import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/providers/movie_list_provider.dart';
import 'package:movie_watch_list/src/screens/home_screen.dart';
import 'package:movie_watch_list/src/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _appTheme,
      debugShowCheckedModeBanner: false,
      home: FirebaseApp(),
    );
  }

  ThemeData get _appTheme => ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.black12,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noOverlay,
          trackHeight: 18,
          thumbColor: Colors.black87,
          activeTrackColor: Colors.black54,
          inactiveTrackColor: Colors.black12,
          valueIndicatorColor: Colors.black,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black87,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
        ),
      );
}

class FirebaseApp extends StatelessWidget {
  FirebaseApp({Key? key}) : super(key: key);

  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Firebase Error.')),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data;
                if (user == null) return const LoginScreen();
                return ChangeNotifierProvider(
                  create: ((context) => MoviesListProvier()),
                  builder: ((context, _) => const HomeScreen()),
                );
              }
              return const Scaffold(
                body: Center(child: Text('Please wait...')),
              );
            }),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Please wait...')),
        );
      },
    );
  }
}
