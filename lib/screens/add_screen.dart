import 'package:flutter/material.dart';
import 'package:hive_data_base/screens/widgets/add_student_widget.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AddStudentWidget(),
      ),
    );
  }
}
