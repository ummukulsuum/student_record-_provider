import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record_project/controllers/students_controller.dart';
import 'package:student_record_project/hive_service.dart/hive.dart';
import 'package:student_record_project/views/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final controller = StudentsController();
        controller.loadStudents();
        return controller;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
