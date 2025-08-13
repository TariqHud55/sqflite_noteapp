import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';
import '../database/sqlflite_file.dart';

class TrashPage extends StatefulWidget {
  static const String keyTrashPage = 'trashPage';

  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  bool _isLoading = true; // ✅ عشان نتحكم في التحميل

  @override
  void initState() {
    super.initState();
    _loadTrash();
  }

  Future<void> _loadTrash() async {
    await Provider.of<ProviderServer>(context, listen: false).loadTrash();
    setState(() {
      _isLoading = false; // ✅ إيقاف التحميل بعد إحضار البيانات
    });
  }

  @override
  Widget build(BuildContext context) {
    ProviderServer provider = context.watch<ProviderServer>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('سلة المهملات', style: TextStyle(color: Colors.white,fontSize: 22)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator()) // ✅ يظهر مرة وحدة بس
              : provider.trashNotes.isEmpty
              ? Center(child: Text("🗑️ سلة المهملات فارغة"))
              : ListView.builder(
                itemCount: provider.trashNotes.length,
                itemBuilder: (context, index) {
                  final note = provider.trashNotes[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        note[SqlfliteFile.columnTitle] ?? 'بدون عنوان',
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        note[SqlfliteFile.columndescription] ?? '',
                        maxLines: 1,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.restore, color: Colors.green),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (_) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              );

                              await provider.restoreItem(
                                note[SqlfliteFile.columnId],
                              );

                              Navigator.pop(context); // إغلاق التحميل
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                MyHomePage.keyMyhomepage,
                                (route) => false,
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_forever, color: Colors.red),
                            onPressed: () async {
                              // عرض رسالة تأكيد الحذف
                              final bool?
                              confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('تنبيه'),
                                    content: Text('هل تريد الحذف نهائياً؟'),
                                    actions: [
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.red,
                                              ),
                                        ),
                                        onPressed:
                                            () => Navigator.pop(context, false),
                                        child: Text(
                                          'إلغاء',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.green,
                                              ),
                                        ),
                                        onPressed:
                                            () => Navigator.pop(context, true),
                                        child: Text(
                                          'موافق',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmDelete == true) {
                                // عرض شاشة تحميل
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder:
                                      (_) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                );

                                // تنفيذ الحذف
                                await provider.deleteForever(
                                  note[SqlfliteFile.columnId],
                                );

                                // إغلاق شاشة التحميل
                                Navigator.pop(context);

                                // الانتقال للصفحة الرئيسية
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MyHomePage.keyMyhomepage,
                                  (route) => false,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
