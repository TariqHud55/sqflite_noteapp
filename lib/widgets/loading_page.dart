import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';


class LoadingScreen extends StatefulWidget {
  static const String routeName = 'loading_screen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await Provider.of<ProviderServer>(context, listen: false).loadNote(newest: true);
      // بعد الانتهاء انتقل للشاشة الرئيسية
      Navigator.of(context).pushReplacementNamed(MyHomePage.keyMyhomepage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // مؤشر التحميل الدائري في الوسط
      ),
    );
  }
}
