import 'package:flutter/material.dart';

class PageRouter extends InheritedWidget {
  final Function(String) goTo;
  final Widget child;

  PageRouter({Key? key, required this.goTo, required this.child}) : super(key: key, child: child);

  static PageRouter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PageRouter>();
  }

  @override
  bool updateShouldNotify(PageRouter oldWidget) {
    return goTo != oldWidget.goTo;
  }
}
