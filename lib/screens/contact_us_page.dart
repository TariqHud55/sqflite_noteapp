import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  static final keycontactuspage = 'keycontactuspage';

  ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController _txtusername = TextEditingController();

  TextEditingController _textemail = TextEditingController();

  TextEditingController _textmassege = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme:IconThemeData(color:Colors.white),centerTitle: true,
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        title: Text('تواصل معنا', style: TextStyle(color: Colors.white,fontSize: 26)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              TextFormField(
                controller: _txtusername,
                decoration: InputDecoration(
                  label: Text('ادخل الاسم'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _textemail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text('ادخل البريد الإلكتروني '),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _textmassege,
                decoration: InputDecoration(
                  labelText: 'ادخل الرسالة',
                  border: OutlineInputBorder(),
                  alignLabelWithHint:
                      true, // Keeps label aligned to top for multi-line
                ),
                minLines: 5, // Starts with 5 lines
                maxLines: 8, // Expands up to 8 lines
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.left, // Aligns text to the left
              ),
              SizedBox(height: 15),
              SizedBox(width:220,
                child: ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.blue),
                  onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:const Text('هذه النسخة تجريبية، لن يتم إرسال الرسالة'),
                    action:SnackBarAction(label:'تنبيه', onPressed:()=> Navigator.pop(context)),
                    duration: const Duration(seconds:5),
                    ));
                  },
                  child: Text(
                    'ارسل',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
