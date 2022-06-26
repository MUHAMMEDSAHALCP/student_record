import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_data_base/data_base/functions/db_functions.dart';
import 'package:hive_data_base/data_base/model/data_model.dart';
import 'package:hive_data_base/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  StudentModel studentDatas2;
  int index1;
  EditScreen({required this.studentDatas2, required this.index1, Key? key})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String _imageNew = "";
  String _imageToString = "";

  pickImage() async {
    // ignore: deprecated_member_use
    final imageFromGallery =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    final bytes = File(imageFromGallery!.path).readAsBytesSync();
    _imageToString = base64Encode(bytes);
    setState(() {
      _imageNew = _imageToString;
    });
  }

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _batchController = TextEditingController();

  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.studentDatas2.name;
    _ageController.text = widget.studentDatas2.age;
    _batchController.text = widget.studentDatas2.batch;
    _phoneController.text = widget.studentDatas2.phone;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.purple),
        title: const Text(
          "EDIT STUDENT DETAILS",
          style: TextStyle(color: Colors.purple),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: _imageNew.isEmpty
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: MemoryImage(
                            const Base64Decoder()
                                .convert(widget.studentDatas2.newimage),
                          ),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(_imageNew),
                          ),
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
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,
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
                                labelText: " Name",
                                border: OutlineInputBorder(),
                              ),
                              autofocus: true,
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
                                labelText: " Batch",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Phone ';
                                } else {
                                  return null;
                                }
                              },
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: " phone",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_imageNew.isEmpty) {
                                    _imageNew = widget.studentDatas2.newimage;
                                  }
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                      (route) => false);
                                } else {
                                  chekFormFill1(context);
                                }

                                submit();
                              },
                              child: const Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future submit() async {
    final _name = _nameController.text;
    final _age = _ageController.text;
    final _batch = _batchController.text;
    final _phone = _phoneController.text;

    final submit = StudentModel(
      name: _name,
      age: _age,
      batch: _batch,
      phone: _phone,
      newimage: _imageNew,
    );
    await updateData(widget.index1, submit);
  }
}

void chekFormFill1(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      padding: EdgeInsets.all(10),
      backgroundColor: Colors.purple,
      content: Text(" Error Found!!! Edit not completed"),
    ),
  );
}
