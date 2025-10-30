import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_project/model/registration_model.dart';

class HiveService {
  static const String studentBoxName = 'studentsBox';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RegistrationModelAdapter());
    await Hive.openBox<RegistrationModel>(studentBoxName);
  }

  // Get Box
  static Box<RegistrationModel> getBox() {
    return Hive.box<RegistrationModel>(studentBoxName);
  }

  // Add data
  static Future<void> addStudent(RegistrationModel student) async {
    final box = getBox();
    await box.add(student);
  }

  // Delete data
  static Future<void> deleteStudent(int index) async {
    final box = getBox();
    await box.deleteAt(index);
  }

  // Get all students
  static List<RegistrationModel> getAllStudents() {
    final box = getBox();
    return box.values.toList();
  }
}
