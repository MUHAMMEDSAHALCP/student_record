import 'package:flutter/cupertino.dart';
import 'package:hive_data_base/data_base/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student db');
  final _datas = await studentDB.add(value);
  value.id = _datas;
  studentDB.putAt(value.id!, value);
  studentListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student db');
  studentDB.deleteAt(id);
  getAllStudent();
}

Future updateData(int index, StudentModel obj) async {
  final studentDB = await Hive.openBox<StudentModel>('student db');
  studentDB.putAt(index, obj);

  getAllStudent();
}
