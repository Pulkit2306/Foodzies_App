import 'package:flutter/material.dart';

class ListTiling extends StatefulWidget {
  final String text;
  final IconData icons;
  const ListTiling({
    required this.text, 
    required this.icons,
    
    
    Key? key}) : super(key: key);

  @override
  State<ListTiling> createState() => _ListTilingState();
}

class _ListTilingState extends State<ListTiling> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.icons,
      ),
      title: Text(widget.text),
    );
  }
}
