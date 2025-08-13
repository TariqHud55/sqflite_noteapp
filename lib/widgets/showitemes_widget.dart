import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_noteapp/provider/provider_server.dart';

class showitemes extends StatefulWidget {
  const showitemes({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  final String title;
  final String image;
  final String description;

  @override
  State<showitemes> createState() => _showitemesState();
}

class _showitemesState extends State<showitemes> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ProviderServer>(context);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      children: [
        Text(
          '${widget.title}',
          style: TextStyle(fontSize:provider.thefontsizetitle, fontWeight: FontWeight.bold),
        ),
        if (widget.image != null && widget.image.isNotEmpty)
          Image.file(File(widget.image), fit: BoxFit.contain),
        Text('${widget.description}', style: TextStyle(fontSize:provider.thefontsizedesc)),
      ],
    );
  }
}
