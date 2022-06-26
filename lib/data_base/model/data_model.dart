import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String batch;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String newimage;

  StudentModel(
      {required this.name,
      required this.age,
      required this.batch,
      required this.phone,
      required this.newimage,
      this.id});
}
