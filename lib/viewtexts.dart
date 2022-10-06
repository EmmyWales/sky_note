// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_note/utils/colors.dart';

class ViewTexts extends StatefulWidget {
  final List allNote;
  final int index;
  final String title, content;
  const ViewTexts({
    super.key,
    required this.title,
    required this.content,
    required this.allNote,
    required this.index,
  });

  @override
  State<ViewTexts> createState() => _ViewTextsState();
}

class _ViewTextsState extends State<ViewTexts> {
  TextEditingController _cont = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  void initState() {
    _note = TextEditingController(text: widget.title);
    _cont = TextEditingController(text: widget.content);
    super.initState();
  }

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
                    child: Wrap(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.upload,
                            size: 18,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            User? user = FirebaseAuth.instance.currentUser;
                            final updateUser = FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid);
                            setState(() {
                              widget.allNote[widget.index] = {
                                "note_title": _note.text,
                                "note_content": _cont.text,
                                "date_created": DateTime.now().toString(),
                              };
                            });

                            await updateUser.update(
                                {'notes': widget.allNote}).then((value) {
                              Navigator.pop(context);
                            }).catchError((error) => print("Failed to save"));
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            User? user = FirebaseAuth.instance.currentUser;
                            final updateUser = FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid);
                            setState(() {
                              widget.allNote.removeAt(widget.index);
                            });
                            await updateUser.update(
                                {'notes': widget.allNote}).then((value) {
                              Navigator.pop(context);
                            }).catchError((error) => print("Failed to save"));
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 600,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
