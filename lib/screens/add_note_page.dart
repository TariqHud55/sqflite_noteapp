import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/widgets/my_iconbutton_widget.dart';

class AddNotePage extends StatefulWidget {
  static final String keyMyhomepage = 'addNotePageKey';

  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provin = Provider.of<ProviderServer>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const SizedBox(width: 20),
          myIconButton(
            icon: Icons.check,
            onPressed: () async {
              provin.updateTitle(titleController.text);
              String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
              provin.updateDate(formattedDate);

              await provin.addNote();

              // تنظيف البيانات بعد انتهاء الإطار الحالي
              WidgetsBinding.instance.addPostFrameCallback((_) {
                provin.clear();
                Navigator.of(context).pop();
              });
            },
            size: 40,
          ),
          const Spacer(),
          myIconButton(
  icon: Icons.cancel_rounded,
  onPressed: () {
    Navigator.of(context).pop();
  },
  size: 40,
),

          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(fontSize: provin.thefontsizetitle),
              decoration: const InputDecoration(labelText: 'العنوان'),
              onChanged: (value) {
                provin.updateTitle(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
