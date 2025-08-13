import 'package:flutter/material.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';

class HelpPage extends StatefulWidget {
  static final keyhelppage = 'keyhelppage';
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'المساعدة',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('سيتم إضافة ادوات المساعدة  عند نشر التطبيق في المتجر.'),
            SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}
