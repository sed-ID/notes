import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/view/screens/add_note_screen.dart';
import 'package:notes/view/screens/login_screen.dart';
import 'package:notes/view/screens/registration_screen.dart';
import 'package:notes/view/screens/splash_screen.dart';

import 'view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashScreen(), //route for splashscreen
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(), //route for loginscreen
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegistrationScreen(),  // Define route for RegistrationScreen
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),  // Define route for HomeScreen
      ),
      GoRoute(
        path: '/add_note',
        builder: (context, state) => AddNoteScreen(),  // Define route for AddNoteScreen
      ),
    ],
  );
  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'Notes App',
      routerConfig: _router,
    );
  }
}
