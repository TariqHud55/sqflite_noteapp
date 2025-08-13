import 'package:flutter/material.dart';
import 'package:sqflite_noteapp/database/sqlflite_file.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/show_items_page.dart';

class Listview_show_itemes_home extends StatelessWidget {
  const Listview_show_itemes_home({
    super.key,
    required ProviderServer providerServer,
  }) : _providerServer = providerServer;

  final ProviderServer _providerServer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _providerServer.notes.length,
      itemBuilder: (context, index) {
        final note = _providerServer.notes[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ShowItemsPage.keyshowitemspage,
              arguments: {
                'id': note[SqlfliteFile.columnId],
                'title': note[SqlfliteFile.columnTitle],
                'description': note[SqlfliteFile.columndescription],
                'image': note[SqlfliteFile.columnImage],
              },
            );
            // Navigator.pushNamed(
            //   context,
            //   DescScreen.keydescscree,
            //   arguments: {
            //     'title': note[SqlfliteFile.columnTitle],
            //     'description': note[SqlfliteFile.columndescription],
            //     'image': note[SqlfliteFile.columnImage],
            //   },
            // );
          },
          child: Card(
            child: Column(
              children: [
                Text(note[SqlfliteFile.columnTime] ?? ''),
                ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (contex) => AlertDialog(
                              title: Text('تنبيه'),
                              content: const Text(
                                'هل تريد حذف الملاحظة الى المهملات  ؟',
                                style: TextStyle(fontSize: 18),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () async {
                                    try {
                                      await  _providerServer.deleteItem(
                                        note[SqlfliteFile.columnId],
                                      );
                                     
                                    } catch (e) {
                                      print('Error: $e');
                                    }
                                   Navigator.pop(contex);
                                  },
                                  child: Text(
                                    'نعم',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 35),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'لا',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                  title: Text(style:TextStyle(fontSize: _providerServer.thefontsizetitle) ,
                    note[SqlfliteFile.columnTitle] ?? 'بدون عنوان',
                  ),
                  subtitle: Text(style:TextStyle(fontSize: _providerServer.thefontsizetitle),maxLines: 1,
                    
                      note[SqlfliteFile.columndescription],
                    
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
