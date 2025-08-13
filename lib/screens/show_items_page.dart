import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';
import 'package:sqflite_noteapp/widgets/my_iconbutton_widget.dart';
import 'package:sqflite_noteapp/widgets/showitemes_widget.dart';

class ShowItemsPage extends StatefulWidget {
  static final keyshowitemspage = 'keyshowitemspage';

  ShowItemsPage({super.key});

  @override
  State<ShowItemsPage> createState() => _ShowItemsPageState();
}

class _ShowItemsPageState extends State<ShowItemsPage> {
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtdes = TextEditingController();
  File? _image;
  String? pickimage;
  int? id;
  bool isEditing = true;
  ProviderServer? providerins;
  Future<void> pickTheImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? _pickimage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (_pickimage != null) {
      setState(() {
        _image = File(_pickimage.path);
        pickimage = _image!.path; // تحديث المسار الجديد
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // نحصل القيم من arguments مرة وحدة
    providerins = context.watch<ProviderServer>();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (pickimage == null) {
      id = args['id'];
      txttitle.text = args['title'];
      txtdes.text = args['description'];
      pickimage = args['image'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        actions: [
          myIconButton(
            icon: Icons.edit,
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            size: 35,
          ),
          Spacer(),
          if (isEditing == false)
            TextButton(
              onPressed: () async {
                try {
                  providerins!.updateId(id!);
                  providerins!.updateTitle(txttitle.text);
                  providerins!.updateDes(txtdes.text);
                  providerins!.updateImage(pickimage);
                  providerins!.updateDate(
                    DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                  );

                  await providerins!.updateData();
                  providerins!.clear();
                } catch (e) {
                  print('=========================== $e +==================');
                }
                Navigator.pushNamed(context, MyHomePage.keyMyhomepage);
              },
              child: Text(
                'تعديل',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
        ],
      ),
      body:
          isEditing
              ? showitemes(
                title: txttitle.text,
                image: pickimage ?? '',
                description: txtdes.text,
              )
              : ListView(
                children: [
                  TextFormField(
                    controller: txttitle,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  if (pickimage != null && pickimage!.isNotEmpty)
                    Image.file(File(pickimage!), fit: BoxFit.contain),
                  SizedBox(height: 10),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    onPressed: () async {
                      await pickTheImage();
                    },
                    child: Text(
                      'تغيير الصورة',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  TextFormField(
                    maxLines: null,
                    controller: txtdes,
                    minLines: 5,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
    );
  }
}
