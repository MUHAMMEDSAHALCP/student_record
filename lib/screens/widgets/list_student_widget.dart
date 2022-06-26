import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_data_base/data_base/functions/db_functions.dart';
import 'package:hive_data_base/data_base/model/data_model.dart';
import 'package:hive_data_base/screens/detail_screen.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];

              return Padding(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 5),
                child: Card(
                  color: const Color(0xff4495BD),
                  elevation: 2,
                  child: ListTile(
                    title: Text(data.name.toUpperCase()),
                    subtitle: const Text("Tap here to show more details"),
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(data.newimage),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        deleteStudent(index);
                        // if (data.id != null) {
                        //   deleteStudent(data.id!);
                        // } else {
                        //   print("Student id is null, unable to delete");
                        // }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            index: index,
                            studentDatas: data,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox();
            },
            itemCount: studentList.length);
      },
    );
  }
}
