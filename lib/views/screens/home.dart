import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record_project/controllers/students_controller.dart';
import 'package:student_record_project/views/screens/registration_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6EA39E),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
      ),

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

              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(100, 85, 97, 96),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child:
                            (student.imagePath.isNotEmpty &&
                                File(student.imagePath).existsSync())
                            ? Image.file(
                                File(student.imagePath),
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 110,
                                height: 110,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                      ),

                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2F3E46),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Age: ${student.age}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4F5B62),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Grade: ${student.grade} - Section: ${student.section}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4F5B62),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.badge_outlined,
                                  size: 16,
                                  color: Colors.teal,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Adm No: ${student.admission}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                  size: 16,
                                  color: Colors.teal,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  student.phone.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  size: 16,
                                  color: Colors.teal,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    student.email,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons (Edit + Delete)
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.teal,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(
                                    // student: student,
                                    // index: index,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            onPressed: () => controller.deleteStudent(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
