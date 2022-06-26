// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_data_base/data_base/functions/db_functions.dart';
import 'package:hive_data_base/data_base/model/data_model.dart';
import 'package:hive_data_base/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

final _nameController = TextEditingController();
final _ageController = TextEditingController();
final _batchController = TextEditingController();
final _phoneController = TextEditingController();

final formKey = GlobalKey<FormState>();

class _AddStudentWidgetState extends State<AddStudentWidget> {
  String _imageNew = "";
  String _imageToString = "";

  PickImage() async {
    // ignore: deprecated_member_use
    final ImageFromGallery =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    final bytes = File(ImageFromGallery!.path).readAsBytesSync();
    _imageToString = base64Encode(bytes);
    setState(
      () {
        _imageNew = _imageToString;
      },
    );
  }

  // Future getImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   try {
  //     if (image == null) return;
  //     final imagePermanent = await SaveFilePermanently(image.path);

  //     setState(
  //       () {
  //         this._image = imagePermanent;
  //       },
  //     );
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future<File> SaveFilePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
          "REGISTER STUDENT DETAILS",
          style: TextStyle(color: Colors.purple, fontSize: 18),
        ),
      ),
      body: GestureDetector(
        child: ListView(
          children: [
            // getImageWidget(),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    PickImage();
                  },
                  child: _imageNew.isEmpty
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage("assets/personAdd.ico"),
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(_imageNew),
                          ),
                          radius: 80,
                        ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // CustomButton(
                  //     title: "pick from gallery",
                  //     onClick: () => getImage(ImageSource.gallery),
                  //     icon: Icons.image_outlined),
                  // CustomButton(
                  //     title: "pick from camera",
                  //     onClick: () => getImage(ImageSource.camera),
                  //     icon: Icons.camera),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Card(
                  color: Colors.yellow,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Builder(builder: (context) {
                      return Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Name';
                                } else {
                                  return null;
                                }
                              },
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Age';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              decoration: const InputDecoration(
                                labelText: " Age",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Batch';
                                } else {
                                  return null;
                                }
                              },
                              controller: _batchController,
                              decoration: const InputDecoration(
                                labelText: "Batch",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Phone';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: "phone",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    _imageNew.isNotEmpty) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));
                                } else {
                                  chekFormFill(context);
                                }

                                onAddStudentButtonClicked(context);
                              },
                              child: const Text("Add"),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future onAddStudentButtonClicked(BuildContext context) async {
    final _name = _nameController.text;
    final _age = _ageController.text;
    final _batch = _batchController.text;
    final _Phone = _phoneController.text;

    if (_name.isEmpty ||
        _age.isEmpty ||
        _batch.isEmpty ||
        _Phone.isEmpty ||
        _imageNew.isEmpty) {
      return;
      // chekFormFill(context);
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         actions: [
      //           const Text("Error found!! please Add Image"),
      //           IconButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               icon: const Icon(Icons.close)),
      //         ],
      //         title: const Text(
      //           "Something Wrong",
      //           style: TextStyle(color: Colors.purple),
      //         ),
      //       );
      //     });
    } else {
      final student = StudentModel(
        name: _name,
        age: _age,
        batch: _batch,
        phone: _Phone,
        newimage: _imageNew,
      );
      addStudent(student);
      // _nameController.text = '';
      // _ageController.text = '';

      // _phoneController.text = '';
      // _batchController.text = '';
      // _imageNew = "";
    }
  }
}

// Widget CustomButton({
//   required String title,
//   required IconData icon,
//   required VoidCallback onClick,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 80),
//     child: ElevatedButton(
//       onPressed: onClick,
//       child: Row(
//         children: [
//           Icon(icon),
//           const SizedBox(
//             width: 20,
//           ),
//           Text(title),
//         ],
//       ),
//     ),
//   );
// }

void chekFormFill(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left: 60, right: 60),
      padding: EdgeInsets.all(5),
      backgroundColor: Colors.purple,
      content: Text(
        "Error Found!!! Form not completed",
        textAlign: TextAlign.center,
        style: TextStyle(),
      ),
    ),
  );
}
