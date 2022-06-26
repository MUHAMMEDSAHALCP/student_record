import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_data_base/data_base/model/data_model.dart';
import 'package:hive_data_base/screens/editing_screen.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  StudentModel studentDatas;
  int index;

  DetailScreen({required this.studentDatas, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.purple),
        title: const Text(
          "STUDENT FULL DETAILS",
          style: TextStyle(color: Colors.purple),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(
                    studentDatas2: studentDatas,
                    index1: index,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 10,
                child: SizedBox(
                  height: 640,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: MemoryImage(
                          const Base64Decoder().convert(studentDatas.newimage),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(" ${studentDatas.name.toUpperCase()}",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Age: ${studentDatas.age} ",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Batch: ${studentDatas.batch} ",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Phone: ${studentDatas.phone} ",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
