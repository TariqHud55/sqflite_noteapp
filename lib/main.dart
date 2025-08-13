import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';
import 'package:sqflite_noteapp/screens/add_note_page.dart';
import 'package:sqflite_noteapp/screens/contact_us_page.dart';
import 'package:sqflite_noteapp/screens/enter_info.dart';
import 'package:sqflite_noteapp/screens/help_page.dart';
import 'package:sqflite_noteapp/screens/my_home_page.dart';
import 'package:sqflite_noteapp/screens/settings_screen.dart';
import 'package:sqflite_noteapp/screens/show_items_page.dart';
import 'package:sqflite_noteapp/screens/sort_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/screens/trash_page.dart';
import 'package:sqflite_noteapp/widgets/loading_page.dart';
import 'package:sqflite_noteapp/widgets/slider_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProviderServer(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServer>(
      builder: (context, provider, child) {
        return MaterialApp(
          locale: const Locale('ar', 'AE'),
          supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
            brightness: Brightness.dark,
          ),
          themeMode: provider.isdarktheme ? ThemeMode.dark : ThemeMode.light,
          initialRoute: MyHomePage.keyMyhomepage, // نبدأ بشاشة التحميل
          routes: {
            LoadingScreen.routeName: (context) => LoadingScreen(),
            MyHomePage.keyMyhomepage: (_) => MyHomePage(),
            SortScreen.sortscreenkey: (_) => SortScreen(),
            AddNotePage.keyMyhomepage: (_) => AddNotePage(),
            EnterInfo.keyenterinfo: (_) => EnterInfo(),
            ShowItemsPage.keyshowitemspage: (_) => ShowItemsPage(),
            TrashPage.keyTrashPage: (_) => TrashPage(),
            SettingsScreen.keysettingsscreen: (_) => SettingsScreen(),
            SliderWidget.keysliderwidget: (_) => SliderWidget(),
            ContactUsPage.keycontactuspage:(_)=> ContactUsPage(),
            HelpPage.keyhelppage:(_)=>HelpPage()
          },
        );
      },
    );
  }
}
