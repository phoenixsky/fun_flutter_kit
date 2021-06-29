import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

class FunStateActionExceptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FunStateActionExceptionLogic logic =
        Get.put(FunStateActionExceptionLogic());
    return Scaffold(
        appBar: AppBar(title: Text("异常处理")),
        body: FunStateObx(
          controller: logic,
          builder: () => Center(
            child: Column(
              children: [
                Text(
                  "我可以加载不同的状态页",
                  style: Get.textTheme.headline5,
                ),
                OutlinedButton(
                    onPressed: () {
                      logic.state = PageState.success;
                    },
                    child: Text("正确结果页面")),
                OutlinedButton(
                    onPressed: () {
                      logic.state = PageState.error;
                    },
                    child: Text("错误结果页面")),
              ],
            ),
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onError: (err) => Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$err'),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () {
                    logic.state = PageState.success;
                  },
                  child: Text("重置"))
            ],
          )),
        ));
  }
}

class FunStateActionExceptionLogic extends FunStateActionController {
  PageState _state = PageState.success;

  set state(PageState state) {
    _state = state;
    loadData();
  }

  @override
  Future onLoadData() async {
    await 1.seconds.delay();
    if (_state == PageState.error) {
      throw "加载数据出错";
    }
    return "我是正确的数据";
  }
}

/// action不需要支持empty的情况
enum PageState { success, error }
