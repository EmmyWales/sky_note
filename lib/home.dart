// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_note/newtexts.dart';
import 'package:sky_note/utils/colors.dart';
import 'package:sky_note/viewtexts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  bool value = false;
  bool visi = false;
  // int? _selected;
  final List<int> _selectedId = [];

  List<Color> colors = [
    const Color(0XFF00AFEF),
    const Color(0XFF0018EF),
    const Color(0XFFEF0081),
    const Color(0XFF05EF00),
    const Color(0XFFEF0000),
    const Color(0XFFEFBA00),
    const Color(0XFF0048BA),
    const Color(0XFFB0BF1A),
    const Color(0XFF7CB9E8),
    const Color(0XFFB284BE),
    const Color(0XFFDB2D43),
    const Color(0XFF006B3C),
    const Color(0XFFFFA6C9),
    const Color(0XFFED9121),
    const Color(0XFF6F4E37),
    const Color(0XFFFF7F50),
    const Color(0XFF58427C),
    const Color(0XFF8C92AC),
    const Color(0XFF996666),
    const Color(0XFFFF7F50),
    const Color(0XFFFFF8DC),
    const Color(0XFF654321),
    const Color(0XFF8B008B),
    const Color(0XFF556B2F),
    const Color(0XFF00CED1),
    const Color(0XFF556B2F),
    const Color(0XFF87421F),
    const Color(0XFF9EFD38),
    const Color(0XFFA67B5B),
    const Color(0XFFFFFAF0),
    const Color(0XFFEEDC82),
    const Color(0XFF006400),
    const Color(0XFF86608E),
    const Color(0XFFC154C1),
    const Color(0XFFE25822),
    const Color(0XFFF88379),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection("users").doc(user!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.connectionState == ConnectionState.active) {
          List newNote = List.from(snapshot.data!['notes'].reversed);
          var spiltname = snapshot.data!['fullname'].split(' ');
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0XFF00AFEF),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TextPage(
                      allNotes: snapshot.data!['notes'],
                    ),
                  ),
                );
                // Navigator.pushNamed(context, '/txts');
              },
              tooltip: 'Add Note',
              child: const Icon(
                Icons.add,
                size: 26,
              ),
            ),
            body: WillPopScope(
              onWillPop: () async => false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      const Image(image: AssetImage("assets/Frame.png")),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/profile');
                                    },
                                    child: Icon(
                                      Icons.account_circle_outlined,
                                      color: AppColor.icon,
                                      size: 28,
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      " Welcome, ${spiltname[0]}",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.txt,
                                              fontSize: 16)),
                                    ),
                                    Visibility(
                                      visible: visi,
                                      child: IconButton(
                                          onPressed: () async {
                                            User? user = FirebaseAuth
                                                .instance.currentUser;
                                            final updateUser = FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .doc(user!.uid);
                                            for (var i in _selectedId) {
                                              setState(() {
                                                newNote.removeAt(i);
                                              });
                                            }

                                            await updateUser.update({
                                              'notes': newNote
                                            }).then((value) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const MyHomePage()));
                                              snackBar('Deleted');
                                            }).catchError((error) =>
                                             
                                                // ignore: invalid_return_type_for_catch_error
                                                print("Failed to save"));
                                          },
                                          icon: const Icon(Icons.delete)),
                                      // child: Checkbox(
                                      //     value: value,
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         this.value = value!;
                                      //       });
                                      //     }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color(0XFF909090),
                                  ),
                                  hintText: 'Search notes',
                                  hintStyle:
                                      TextStyle(color: Color(0XFF909090)),
                                  filled: true,
                                  isDense: true,
                                  fillColor: Color(0XFFF1F1F1),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFF1F1F1),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0XFFDADADA)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)))),
                            ),
                            const SizedBox(height: 20),
                            newNote.isEmpty
                                ? const Text(
                                    'You currently do not have any note, kindly click on the button below to add one.')
                                : ListView.builder(
                                    itemCount: newNote.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ViewTexts(
                                                  index: index,
                                                  allNote: newNote,
                                                  title: newNote[index]
                                                      ['note_title'],
                                                  content: newNote[index]
                                                      ['note_content']),
                                            ),
                                          );
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            visi = !visi;
                                            _selectedId.clear();
                                          });
                                        },
                                        child: Flexible(
                                          child: Container(
                                            height: 120,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: const Color(0XFFF7F7F7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: Container(
                                                            height: 120,
                                                            width: 10,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: colors[index],
                                                              color:
                                                                  colors[index],
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.1),
                                                                  blurRadius:
                                                                      12.0,
                                                                  offset:
                                                                      const Offset(
                                                                          4.0,
                                                                          5.0),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            height: 120,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          newNote[index]
                                                                              [
                                                                              'note_title'],
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w500, color: AppColor.txt, fontSize: 16)),
                                                                        ),
                                                                      ),
                                                                      PopupMenuButton(
                                                                        tooltip:
                                                                            'Options',
                                                                        shape: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            borderSide: const BorderSide(color: Color(0XFFFFFFFF))),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          size:
                                                                              18,
                                                                        ),
                                                                        itemBuilder:
                                                                            (context) =>
                                                                                [
                                                                          PopupMenuItem(
                                                                            onTap:
                                                                                () {
                                                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (_) => ViewTexts(index: index, allNote: newNote, title: newNote[index]['note_title'], content: newNote[index]['note_content'])),
                                                                                );
                                                                              });
                                                                            },
                                                                            value:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              "Edit",
                                                                              style: GoogleFonts.poppins(
                                                                                textStyle: TextStyle(fontWeight: FontWeight.w400, color: AppColor.txt, fontSize: 13),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          PopupMenuItem(
                                                                            onTap:
                                                                                () async {
                                                                              User? user = FirebaseAuth.instance.currentUser;
                                                                              final updateUser = FirebaseFirestore.instance.collection('users').doc(user!.uid);

                                                                              setState(() {
                                                                                newNote.removeAt(index);
                                                                              });

                                                                              await updateUser.update({
                                                                                'notes': newNote
                                                                              }).then((value) {
                                                                                Navigator.pop(context);
                                                                              // ignore: invalid_return_type_for_catch_error
                                                                              }).catchError((error) => print("Failed to save"));
                                                                            },
                                                                            value:
                                                                                2,
                                                                            child:
                                                                                Text(
                                                                              "Delete",
                                                                              style: GoogleFonts.poppins(
                                                                                textStyle: TextStyle(fontWeight: FontWeight.w400, color: AppColor.txt, fontSize: 13),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    newNote[index]
                                                                        [
                                                                        'note_content'],
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    softWrap:
                                                                        true,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: AppColor
                                                                              .txt,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '${newNote[index]["date_created"]}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                11),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            visi,
                                                                        child: Checkbox(
                                                                            value: _selectedId.contains(index),
                                                                            onChanged: (value) {
                                                                              if (_selectedId.contains(index)) {
                                                                                _selectedId.remove(index);
                                                                              } else {
                                                                                _selectedId.add(index);
                                                                              }
                                                                              setState(() {});
                                                                            }),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
              child: Text(
                  'Something went wrong ${snapshot.data!} / ${snapshot.connectionState}'));
        }
      },
    );
  }

  snackBar(String title) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }
}
