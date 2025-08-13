import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';
import 'package:sqflite_noteapp/widgets/my_iconbutton_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/provider_server.dart';

class EnterInfo extends StatefulWidget {
  static final String keyenterinfo='keyenterinfo';
  EnterInfo({super.key});

  @override
  State<EnterInfo> createState() => _EnterInfoState();
}

class _EnterInfoState extends State<EnterInfo> {
  // bool isboldtitle = false;
  // bool isbolddes = false;
  // bool isitalictitle = false;
  // bool isitalicdes = false;
  File? _image;
  String? _imagePath;
  final ImagePicker _imagePicker = ImagePicker();
  // double fontSizeTitle = 22;
  // double fontSizeNote = 20;

  TextEditingController txttitle = TextEditingController();
  TextEditingController textnote = TextEditingController();

  FocusNode txttitlefocusnode = FocusNode();
  FocusNode textnotefocusnode = FocusNode();
  Future<void> _pickimage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePath=pickedFile.path;
      });
    }
  }

  // void istogglebold() {
  //   setState(() {
  //     if (txttitlefocusnode.hasFocus) {
  //       isboldtitle = !isboldtitle;
  //     } else if (textnotefocusnode.hasFocus) {
  //       isbolddes = !isbolddes;
  //     }
  //   });
  // }

  // void istoggleitalic() {
  //   setState(() {
  //     if (txttitlefocusnode.hasFocus) {
  //       isitalictitle = !isitalictitle;
  //     } else if (textnotefocusnode.hasFocus) {
  //       isitalicdes = !isitalicdes;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ProviderServer prviderserver = Provider.of<ProviderServer>(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Spacer(),
                  // myIconButton(
                  //   icon: Icons.format_bold,
                  //   onPressed: () {
                  //     istogglebold();
                  //   },
                  //   size: 35,
                  // ),
                  // Spacer(),
                  // myIconButton(
                  //   icon: Icons.format_italic,
                  //   onPressed: () {
                  //     istoggleitalic();
                  //   },
                  //   size: 35,
                  // ),
                  // Spacer(),
                  myIconButton(
                    icon: Icons.image,
                    onPressed: () async {
                      await _pickimage();
                    },
                    size: 35,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
        actions: [
          myIconButton(icon: Icons.close, onPressed: () {
            Navigator.pushReplacementNamed(context,MyHomePage.keyMyhomepage);
          }, size: 35),
          Spacer(),
          myIconButton(
            icon: Icons.save,
            onPressed: () {
              prviderserver.updateDate(
                DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
              );
              prviderserver.updateTitle(txttitle.text);
              prviderserver.updateDes(textnote.text);
              prviderserver.updateImage(_imagePath);
              prviderserver.addNote();
              prviderserver.clear();
              Navigator.pushNamed(context, MyHomePage.keyMyhomepage);
            },
            size: 35,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 6),
        children: [
          TextFormField(
            focusNode: txttitlefocusnode,
            style: TextStyle(
              fontSize: prviderserver.thefontsizetitle,
              fontWeight:  FontWeight.bold,
            
            ),
            controller: txttitle,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "ادخل العنوان",
              hintStyle: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 7),
          if (_image != null) Image.file(_image!, fit: BoxFit.contain),
          TextFormField(
            style: TextStyle(
              fontSize: prviderserver.thefontsizedesc,
              fontWeight:FontWeight.bold,
             
            ),
            focusNode: textnotefocusnode,
            controller: textnote,
            maxLines: null,
            minLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "ادخل الملاحظة",
            ),
          ),
        ],
      ),
    );
  }
}
