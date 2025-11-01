import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_project/model/registration_model.dart';

class HiveService {
  static const String studentBoxName = 'studentsBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RegistrationModelAdapter());
    await Hive.openBox<RegistrationModel>(studentBoxName);
  }

  static Box<RegistrationModel> getBox() {
    return Hive.box<RegistrationModel>(studentBoxName);
  }

  static Future<void> addStudent(RegistrationModel student) async {
    final box = getBox();
    await box.add(student);
  }

  static Future<void> deleteStudent(int index) async {
    final box = getBox();
    await box.deleteAt(index);
  }

  static List<RegistrationModel> getAllStudents() {
    final box = getBox();
    return box.values.toList();
  }
}
