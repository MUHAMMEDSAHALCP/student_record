import 'package:flutter/material.dart';
import 'package:hive_data_base/data_base/functions/db_functions.dart';
import 'package:hive_data_base/screens/search_screen.dart';
import 'package:hive_data_base/screens/widgets/list_student_widget.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
          backgroundColor:  const Color(0xff4495BD),
          leading: const Padding(
            padding: EdgeInsets.only(left: 12, right: 8),
            child: Image(
              image: AssetImage(
                "assets/addedImage.png",
              ),
            ),
          ),
          title: const Center(
            child: Text(
              "REGISTERED STUDENT",
              style: TextStyle(color: Colors.purple, fontSize: 18),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchScreen());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.purple,
              ),
            )
          ]),
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListStudentWidget(),
            )
          ],
        ),
      ),
    );
  }
}
