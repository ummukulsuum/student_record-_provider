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
  final formKey = GlobalKey<FormState>();

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

    // ✅ Run provider updates after first frame to avoid "setState() during build" error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<StudentsController>(context, listen: false);

      // Clear previous selected image safely
      controller.clearSelectedImage();

      // If editing an existing student, pre-fill data
      if (widget.student != null) {
        nameController.text = widget.student!.name;
        ageController.text = widget.student!.age.toString();
        gradeController.text = widget.student!.grade.toString();
        sectionController.text = widget.student!.section;
        admissionController.text = widget.student!.admission.toString();
        phoneController.text = widget.student!.phone.toString();
        emailController.text = widget.student!.email;

        if (widget.student!.imagePath.isNotEmpty) {
          controller.setSelectedImage(File(widget.student!.imagePath));
        }
      }
    });
  }

  void saveStudent(BuildContext context) {
    final controller = Provider.of<StudentsController>(context, listen: false);
    final image = controller.selectedImage;

    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final grade = gradeController.text.trim();
    final section = sectionController.text.trim();
    final admission = admissionController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();

    if (image == null ||
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

    final ageValue = int.tryParse(age);
    final gradeValue = int.tryParse(grade);
    final admissionValue = int.tryParse(admission);

    if (ageValue == null || gradeValue == null || admissionValue == null) {
      showErrorDialog(context, 'Age, Grade, and Admission must be numbers');
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
      imagePath: image.path,
      name: name,
      age: ageValue,
      grade: gradeValue,
      section: section,
      admission: admissionValue,
      phone: int.parse(phone),
      email: email,
    );

    if (widget.index == null) {
      controller.addStudent(newStudent);
    } else {
      controller.updateStudent(widget.index!, newStudent);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StudentsController>(context);

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
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final file = await pickImage();
                  if (file != null) {
                    controller.setSelectedImage(file);
                  }
                },
                child: Hero(
                  tag: 'studentImage',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: controller.selectedImage != null
                        ? FileImage(controller.selectedImage!)
                        : null,
                    child: controller.selectedImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.white)
                        : null,
                  ),
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
