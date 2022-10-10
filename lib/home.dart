
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
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.purple,
    Colors.black,
    Colors.green,
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
                                        onPressed: () {
                                          
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
                                                              color: const Color(
                                                                  0XFF00AFEF),
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
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(builder: (_) => ViewTexts(index: index, allNote: newNote, title: newNote[index]['note_title'], content: newNote[index]['note_content'])),
                                                                              );
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
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}
