import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  DrawerItem({required this.title, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }
}