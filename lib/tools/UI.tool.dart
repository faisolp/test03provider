import 'package:flutter/material.dart';

IconData getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'person':
        return Icons.person;
      // เพิ่ม icons อื่นๆ ที่นี่
      default:
        return Icons.circle; // Default icon
    }
  }