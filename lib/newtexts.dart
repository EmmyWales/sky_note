import 'package:flutter/material.dart';
import 'package:sky_note/utils/colors.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
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
                style:  TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color:   AppColor.txt),
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
                      onPressed: () {},
                        ),
                        IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      iconSize: 18,
                        )
                      ]),
                    )
                    // suffix: Row(
      
                    //   children: <Widget>[
                    //     IconButton(
                    //       icon: const Icon(
                    //         Icons.file_upload_outlined,
                    //         size: 20,
                    //         color: Color(0XFF545454),
                    //       ),
                    //       onPressed: () {},
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     GestureDetector(child: Image.asset('assets/Vector.png'))
                    //   ],
                    // ),
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
