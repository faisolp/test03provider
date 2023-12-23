import 'package:flutter/material.dart';

import '../../Component/Drawer/DrawerItem.dart';

class AppDrawerItems extends StatelessWidget {
  final List<Map<String, dynamic>> routes;
  final Function(String) onChangePage;
  final Function(String) getIcon;

  AppDrawerItems({required this.routes, required this.onChangePage, required this.getIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map((route) => DrawerItem(
            title: route['title'],
            iconData: getIcon(route['icon']),
            onTap: () => onChangePage(route['route']),
          )).toList(),
    );
  }
}

