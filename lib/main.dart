import 'package:flutter/material.dart';
import 'package:restaurand_guide/welcome.dart';
import 'globals.dart' as globals;

void main() async {
  // Ensure Flutter is initialized for SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved users and reviews from memory
  await globals.loadData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beirut Restaurant Suggester',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const WelcomePage(),
    );
  }
}