/// @author phoenixsky
/// @date 2021/6/28
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

class FunStateActionView extends StatelessWidget {
  const FunStateActionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var action1logic = Get.put(FunStateAction1Logic());
    var action2logic = Get.put(FunStateAction2Logic());

    return Scaffold(
      appBar: AppBar(
        title: Text("FunStateAction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              FunStateObx(
                controller: action1logic,
                builder: () => OutlinedButton(
                    child: Text("我要去加载数据了"),
                    onPressed: () {
                      action1logic.loadData();
                    }),
              ).flex1,
              SizedBox(width: 10,),
              FunStateObx(
                controller: action2logic,
                builder: () => CupertinoButton(
                    color: Colors.blue,
                    child: Text("我也去"),
                    onPressed: () {
                      action2logic.loadData();
                    }),
                onLoading: CupertinoActivityIndicator(),
              ).flex1,
            ],
          ),
        ),
      ),
    );
  }
}

class FunStateAction1Logic extends FunStateActionController {
  @override
  Future onLoadData() async {
    await 2.delay();
  }
}

class FunStateAction2Logic extends FunStateActionController {
  @override
  Future onLoadData() async {
    await 1.5.delay();
  }
}
