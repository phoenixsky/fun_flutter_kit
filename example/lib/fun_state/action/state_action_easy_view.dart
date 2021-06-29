import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

class StateActionEasyLogic extends FunStateActionController {
  @override
  Future onLoadData() async {
    return await 1.seconds.delay();
  }
}

class ActionViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StateActionEasyLogic logic = Get.put(StateActionEasyLogic());
    return Scaffold(
      body: FunStateObx(
        controller: logic,
        builder: () => OutlinedButton(
          child: Text("点我加载"),
          onPressed: logic.loadData,
        ),
        onLoading: CircularProgressIndicator(),
        onError: (error) => InkWell(
          onTap: logic.loadData,
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
