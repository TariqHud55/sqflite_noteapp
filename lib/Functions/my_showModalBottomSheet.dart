import 'package:flutter/material.dart';
import 'package:sqflite_noteapp/screens/contact_us_page.dart';
import 'package:sqflite_noteapp/screens/evaluation_page.dart';
import 'package:sqflite_noteapp/screens/help_page.dart';
import 'package:sqflite_noteapp/screens/settings_screen.dart';
import 'package:sqflite_noteapp/screens/trash_page.dart';

import 'package:sqflite_noteapp/widgets/my_textbutton_widget.dart';

Future<void> myshowModalBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
    backgroundColor:
        Theme.of(context).bottomSheetTheme.backgroundColor ??
        Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 250,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: [
              MyTextButton(
                text: 'الإعدادات',
                icon: Icons.settings,
                fun: () {
                  Navigator.pushNamed(
                    context,
                    SettingsScreen.keysettingsscreen,
                  );
                },
              ),
              MyTextButton(
                text: 'المهملات',
                icon: Icons.delete,
                fun: () {
                  Navigator.pushNamed(context, TrashPage.keyTrashPage);
                },
              ),
              MyTextButton(
                text: 'قيم التطبيق ',
                icon: Icons.star,
                fun:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EvaluationPage()),
                    ),
              ),
              MyTextButton(
                text: 'المساعدة',
                icon: Icons.help,
                fun: () => Navigator.pushNamed(context, HelpPage.keyhelppage),
              ),
              MyTextButton(
                text: 'تواصل معنا ',
                icon: Icons.contact_mail,
                fun:
                    () => Navigator.pushNamed(
                      context,
                      ContactUsPage.keycontactuspage,
                    ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
