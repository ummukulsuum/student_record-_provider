import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_project/model/registration_model.dart';

class StudentsController extends ChangeNotifier {
  final _box = Hive.box<RegistrationModel>('studentsBox');
  List<RegistrationModel> students = [];

  StudentsController() {
    loadStudents();
  }

  void loadStudents() {
    students = _box.values.toList();
    notifyListeners();
  }

  void addStudent(RegistrationModel student) async {
    await _box.add(student);
    loadStudents();
  }

  void updateStudent(int index, RegistrationModel updatedStudent) async {
    await _box.putAt(index, updatedStudent);
    loadStudents();
  }

  void deleteStudent(int index) async {
    await _box.deleteAt(index);
    loadStudents();
  }
}
