import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/widgets/slider_widget.dart';

class SettingsScreen extends StatelessWidget {
  static final String keysettingsscreen = 'keysettingscreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProviderServer>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'الإعدادات',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Row(
              children: [
                Icon(Icons.nightlight_rounded, size: 30, color: Colors.blue),
                SizedBox(width: 10),
                const Text('الوضع الليلي', style: TextStyle(fontSize: 25)),
              ],
            ),
            value: provider.isdarktheme,
            onChanged: (val) {
              provider.updateisDarkTheme(val);
            },
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(SliderWidget.keysliderwidget);
            },
            child: ListTile(
              title: const Text('حجم الخط', style: TextStyle(fontSize: 25)),
              subtitle: Row(
                children: [
                  Text(
                    'العنوان:${provider.thefontsizetitle.toStringAsFixed(0)} , النص:${provider.thefontsizedesc.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              leading: Icon(Icons.format_size, size: 30, color: Colors.blue),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              provider.updatisgridorlist();
            },
            child: ListTile(
              title: Text('نمط العرض', style: TextStyle(fontSize: 25)),
              leading: Icon(
                provider.isgridorlist ? Icons.list : Icons.grid_view,
                size: 30,
                color: Colors.blue,
              ),
              subtitle: Text(provider.isgridorlist ? 'قائمة' : 'شبكة'),
            ),
          ),
          Divider(),
          
        ],
      ),
    );
  }
}
