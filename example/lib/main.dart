import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fun_state/fun_state_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fun Flutter Kit',
      home: FunStatePage(),
    );
  }
}

