import 'package:flutter/material.dart';

class EvaluationPage extends StatelessWidget {
  const EvaluationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قيم التطبيق',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body:Center(child:Text('سيتم اضافة ادوات المساعدة عند نشر التطبيق في المتجر'),),
    );
  }
}
