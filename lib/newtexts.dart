// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_note/utils/colors.dart';

class TextPage extends StatefulWidget {
  final List? allNotes;
  const TextPage({super.key, this.allNotes});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final db = FirebaseFirestore.instance;
  final date = DateTime.now();

  final TextEditingController _note = TextEditingController();
  final TextEditingController _cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE0E0E0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColor.txt,
        elevation: 0,
        centerTitle: false,
        title: const Text("Back"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: AppColor.txt),
                controller: _note,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add new note',
                    hintStyle: const TextStyle(
                        color: Color(0XFF909090),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    suffixIcon: SizedBox(
                      child: Wrap(children: [
                        IconButton(
                          icon: const Icon(
                            Icons.file_upload_outlined,
                            size: 18,
                            color: Color(0XFF545454),
                          ),
                          onPressed: () async {
                            User? user = FirebaseAuth.instance.currentUser;
                            final updateUser = FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid);
                            setState(() {
                              widget.allNotes!.add({
                                "note_title": _note.text,
                                "note_content": _cont.text,
                                "date_created":
                                    DateFormat('MMMM d, yyy HH:mm').format(DateTime.now()),
                              });
                            });

                            await updateUser.update(
                                {'notes': widget.allNotes}).then((value) {
                              Navigator.pop(context);
                              // ignore: avoid_print
                            }).catchError((error) => print("Failed to save"));
                          },
                        ),
                      ]),
                    )),
              ),
              Container(
                height: 600,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expanded(
                    child: TextFormField(
                      controller: _cont,
                      maxLines: 100000,
                      cursorColor: AppColor.txt,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add new note',
                        hintStyle: TextStyle(
                            color: Color(0XFF909090),
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
