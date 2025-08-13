import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/enter_info.dart';
import 'package:sqflite_noteapp/screens/sort_screen.dart';
import 'package:sqflite_noteapp/widgets/gridview_show_itemes_home.dart';
import 'package:sqflite_noteapp/widgets/listview_show_itemes_home.dart';
import 'package:sqflite_noteapp/widgets/my_iconbutton_widget.dart';
import '../Functions/my_showModalBottomSheet.dart';

class MyHomePage extends StatefulWidget {
  static const String keyMyhomepage = 'myhomekey';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController txtsearch = TextEditingController();
  bool _isInit = false;

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (!_isInit) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderServer>(context, listen: false).loadNote(newest: true);
    });
    _isInit = true;
  }
}


  @override
  Widget build(BuildContext context) {
    ProviderServer _providerServer = context.watch<ProviderServer>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EnterInfo.keyenterinfo);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 10, left: 10),
        automaticallyImplyLeading: false,
        actions: [
          Text(
            _providerServer.isSearching ? 'نتائج البحث' : 'مفكرتي',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          if (_providerServer.isSearching)
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _providerServer.stopSearching();
              },
            ),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                myIconButton(
                  icon: Icons.sort,
                  onPressed: () {
                    Navigator.of(context).pushNamed(SortScreen.sortscreenkey);
                  },
                  size: 30,
                ),
                myIconButton(
                  icon: Icons.search,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("ابحث"),
                          content: TextFormField(
                            controller: txtsearch,
                            decoration: InputDecoration(
                              hintText: 'أدخل عنوان الملاحظة',
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:WidgetStatePropertyAll(Colors.green),
                              ),
                              onPressed: () async {
                                try {
                                  await _providerServer.searchItem(txtsearch.text);
                                  if (_providerServer.notes.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("⚠️ لا توجد نتائج مطابقة")),
                                    );
                                  }
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  print('Error during search: $e');
                                }
                              },
                              child: Text(
                                'بحث',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 35),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.red),
                              ),
                              onPressed: () {
                                _providerServer.stopSearching();
                                Navigator.pop(context);
                              },
                              child: Text(
                                "إغلاق",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  size: 30,
                ),
                IconButton(
                  onPressed: () async {
                    await myshowModalBottomSheet(context);
                  },
                  icon: Icon(Icons.menu, size: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<ProviderServer>(
        builder: (context, instanceprovider, child) {
          if (instanceprovider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (instanceprovider.notes.isEmpty) {
            return Center(child: Text('لا توجد عناصر'));
          }
          return _providerServer.isgridorlist
              ? Listview_show_itemes_home(providerServer: _providerServer)
              : GridviewShowItemesHome(providerServer: _providerServer);
        },
      ),
    );
  }
}
