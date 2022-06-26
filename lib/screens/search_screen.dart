import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_data_base/data_base/functions/db_functions.dart';
import 'package:hive_data_base/data_base/model/data_model.dart';
import 'package:hive_data_base/screens/detail_screen.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color(0xffF7C83A),
//         actions: const [
//           Icon(Icons.search),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: const [Text("Search screen")],
//         ),
//       ),
//     );
//   }
// }

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
        color: Colors.purple,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.yellow,
      ),
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentListNotifier,
            Widget? child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final datas = studentListNotifier[index];
                if (datas.name.toUpperCase().contains(query) ||
                    datas.name.toLowerCase().contains(query)) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Colors.yellow,
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(datas.newimage),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  studentDatas: datas, index: index),
                            ),
                          );
                        },
                        title: Text(datas.name.toUpperCase()),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: studentListNotifier.length);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentListNotifier,
            Widget? child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final datas = studentListNotifier[index];
                if (datas.name.toUpperCase().contains(query) ||
                    datas.name.toLowerCase().contains(query)) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: Card(
                      color: Colors.yellow,
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(datas.newimage),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  studentDatas: datas, index: index),
                            ),
                          );
                        },
                        title: Text(datas.name.toUpperCase()),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: studentListNotifier.length);
        });
  }
}
