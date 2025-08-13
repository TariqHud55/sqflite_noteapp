import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';

class SortScreen extends StatefulWidget {
  static final String sortscreenkey = 'sortscreenkey';

  const SortScreen({super.key});

  @override
  State<SortScreen> createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen> {
  @override
  Widget build(BuildContext context) {
    // نستخدم watch عشان أي تغيير في Provider يعيد بناء الصفحة
    ProviderServer providerServer = context.watch<ProviderServer>();
    String? selectedSort = providerServer.currentSort;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.check, size: 40, color: Colors.white),
              onPressed: () async {
                await providerServer.orderData(selectedSort == "newest");
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(width: 15),
            IconButton(
              icon: const Icon(Icons.cancel_rounded, size: 40, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed(MyHomePage.keyMyhomepage);
              },
            ),
            const Spacer(),
            const Icon(Icons.sort, size: 40, color: Colors.white),
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          RadioListTile<String>(
            title: const Text(
              'تاريخ الإضافة (الأحدث أولاً)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            value: 'newest',
            groupValue: selectedSort,
            onChanged: (value) {
              providerServer.updateSort(value!); // ✅ حفظ الاختيار
            },
          ),
          const SizedBox(height: 20),
          RadioListTile<String>(
            title: const Text(
              'تاريخ الإضافة (الأقدم أولاً)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            value: 'oldest',
            groupValue: selectedSort,
            onChanged: (value) {
              providerServer.updateSort(value!); // ✅ حفظ الاختيار
            },
          ),
        ],
      ),
    );
  }
}
