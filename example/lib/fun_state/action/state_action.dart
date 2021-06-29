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
    var action2logic = Get.put(FunStateAction2Logic(), tag: "error2");
    var action3logic = Get.put(FunStateAction2Logic(), tag: "error3");

    return Scaffold(
      appBar: AppBar(
        title: Text("FunStateAction"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 40,
              child: FunStateObx(
                controller: action1logic,
                builder: () => OutlinedButton(
                    child: Text("加载数据"),
                    onPressed: () {
                      action1logic.loadData();
                    }),
              ),
            ).marginSymmetric(vertical: 10),
            Container(
              height: 40,
              child: FunStateObx(
                controller: action2logic,
                builder: () => OutlinedButton(
                    child: Text("加载失败,只toast提示"),
                    onPressed: action2logic.loadData),
                onLoading: CupertinoActivityIndicator(),
                onError: (error) {
                  /// 如果只是toast提示等,直接在此提示即可
                  Get.log(error.toString());
                },
              ),
            ).marginSymmetric(vertical: 10),
            Container(
              height: 40,
              child: FunStateObx(
                controller: action3logic,
                builder: () => OutlinedButton(
                    child: Text("加载失败,显示错误图标"),
                    onPressed: action3logic.loadData),
                onLoading: CupertinoActivityIndicator(),
                onError: (error) {
                  /// 如果需要修改widget,可以通过返回值来修改
                  return InkWell(
                      onTap: action3logic.loadData, child: Icon(Icons.error));
                },
              ),
            ).marginSymmetric(vertical: 10),
          ],
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
    throw "logic出现错误";
  }
}
