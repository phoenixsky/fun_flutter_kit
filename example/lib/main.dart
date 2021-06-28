import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/state/src/fun_state_configuration.dart';
import 'package:get/get.dart';

import 'fun_state/fun_state_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FunFlutterConfiguration(
      funStateBehavior: FunStateBehavior(
        /// 全局分页参数设置
        paging: FunStatePaging(firstPageNo: 0, pageSize: 20),
      ),
      child: GetMaterialApp(
        title: 'Fun Flutter Kit',
        home: FunStatePage(),
      ),
    );
  }
}
