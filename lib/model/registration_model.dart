import 'package:hive_flutter/hive_flutter.dart';

part 'registration_model.g.dart';

@HiveType(typeId: 1)
class RegistrationModel extends HiveObject {
  @HiveField(0)
  String imagePath;

  @HiveField(1)
  String name;

  @HiveField(2)
  int age;

  @HiveField(3)
  int grade;

  @HiveField(4)
  String section;

  @HiveField(5)
  int admission;

  @HiveField(6)
  int phone;

  @HiveField(7)
  String email;

  RegistrationModel({
    required this.imagePath,
    required this.name,
    required this.age,
    required this.grade,
    required this.section,
    required this.admission,
    required this.phone,
    required this.email,
  });
}
