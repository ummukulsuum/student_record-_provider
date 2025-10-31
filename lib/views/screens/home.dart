import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record_project/controllers/students_controller.dart';
import 'package:student_record_project/views/widgets/home_w.dart';
import 'package:student_record_project/views/screens/registration_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      appBar: AppBar(
        elevation: 6,
        shadowColor: const Color(0xFF6EA39E),
        backgroundColor: const Color(0xFF6EA39E),
        centerTitle: true,
        title: const Text(
          'Student Records',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6EA39E),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
      ),

      body: Consumer<StudentsController>(
        builder: (context, controller, _) {
          if (controller.students.isEmpty) {
            return const Center(
              child: Text(
                'No student data added yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: controller.students.length,
            itemBuilder: (context, index) {
              final student = controller.students[index];
              return buildStudentCard(
                student: student,
                index: index,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(
                        student: student,
                        index: index,
                      ),
                    ),
                  );
                },
                onDelete: () => controller.deleteStudent(index),
              );
            },
          );
        },
      ),
    );
  }
}
