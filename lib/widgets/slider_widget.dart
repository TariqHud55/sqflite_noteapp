import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';

class SliderWidget extends StatefulWidget {
  static final keysliderwidget = 'keysliderwidget';
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    var theslider = Provider.of<ProviderServer>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                Text(
                  'حجم خط العنوان :${theslider.thefontsizetitle}',
                  style: TextStyle(
                    fontSize: theslider.thefontsizetitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  divisions: (34 - 18),

                  min: 18,
                  max: 34,
                  value: theslider.thefontsizetitle,
                  onChanged: (value) {
                    theslider.updatethefontsizetitle(value);
                  },
                ),
                SizedBox(height: 20),
                Divider(),
                Text(
                  'حجم خط الملاحظة: ${theslider.thefontsizedesc}',
                  style: TextStyle(
                    fontSize: theslider.thefontsizedesc,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  divisions: (34 - 18),
                  min: 18,
                  max: 34,
                  value: theslider.thefontsizedesc,
                  onChanged: (value) {
                    theslider.updatethefontsizedesc(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
