import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record_project/controllers/students_controller.dart';
import 'package:student_record_project/model/registration_model.dart';
import 'package:student_record_project/views/widgets/register_w.dart';

class RegisterPage extends StatefulWidget {
  final RegistrationModel? student;
  final int? index;

  const RegisterPage({super.key, this.student, this.index});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController admissionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      gradeController.text = widget.student!.grade.toString();
      sectionController.text = widget.student!.section;
      admissionController.text = widget.student!.admission.toString();
      phoneController.text = widget.student!.phone.toString();
      emailController.text = widget.student!.email;
      if (widget.student!.imagePath.isNotEmpty) {
        _image = File(widget.student!.imagePath);
      }
    }
  }

  void saveStudent(BuildContext context) {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final grade = gradeController.text.trim();
    final section = sectionController.text.trim();
    final admission = admissionController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();

    if (_image == null ||
        name.isEmpty ||
        age.isEmpty ||
        grade.isEmpty ||
        section.isEmpty ||
        admission.isEmpty ||
        phone.isEmpty ||
        email.isEmpty) {
      showErrorDialog(context, 'Please fill all fields');
      return;
    }

    if (phone.length != 10 || int.tryParse(phone) == null) {
      showErrorDialog(context, 'Phone number must be 10 digits');
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      showErrorDialog(context, 'Email must end with @gmail.com');
      return;
    }

    final newStudent = RegistrationModel(
      imagePath: _image!.path,
      name: name,
      age: int.parse(age),
      grade: int.parse(grade),
      section: section,
      admission: int.parse(admission),
      phone: int.parse(phone),
      email: email,
    );

    final controller = Provider.of<StudentsController>(context, listen: false);
    if (widget.index == null) {
      controller.addStudent(newStudent);
    } else {
      controller.updateStudent(widget.index!, newStudent);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6EA39E),
        title: Text(
          widget.index == null ? 'Add Student' : 'Edit Student',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final file = await pickImage();
                  if (file != null) {
                    setState(() {
                      _image = file;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_alt,
                          size: 40, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 25),

              buildTextField(nameController, 'Full Name', Icons.person),
              buildTextField(ageController, 'Age', Icons.cake, isNumber: true),
              buildTextField(gradeController, 'Grade', Icons.school,
                  isNumber: true),
              buildTextField(sectionController, 'Section', Icons.class_),
              buildTextField(admissionController, 'Admission No.', Icons.badge,
                  isNumber: true),
              buildTextField(phoneController, 'Phone Number', Icons.call,
                  isNumber: true),
              buildTextField(emailController, 'Email', Icons.email),

              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6EA39E),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => saveStudent(context),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
