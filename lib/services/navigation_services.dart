import 'package:flutter/material.dart';

class Nav {
  static void pushNav(context, route) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => route));
  }
}
