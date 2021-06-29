import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'article_helper.dart';

/// 正常列表数据加载
class DefaultListViewExceptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DefaultListViewExceptionLogic logic =
        Get.put(DefaultListViewExceptionLogic());

    return Scaffold(
      appBar: AppBar(
        title: Text("DefaultListExceptionPage"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                  onPressed: () {
                    logic.state = PageState.success;
                  },
                  child: Text("正确结果页面")),
              OutlinedButton(
                  onPressed: () {
                    logic.state = PageState.empty;
                  },
                  child: Text("空数据结果页面")),
              OutlinedButton(
                  onPressed: () {
                    logic.state = PageState.error;
                  },
                  child: Text("错误结果页面")),
            ],
          ),
          Expanded(
            child: FunStateObx(
              controller: logic,
              builder: () => ListView.builder(
                  itemCount: logic.list.length,
                  itemBuilder: (context, index) {
                    return ArticleItem(
                      article: logic.list[index],
                      isHomeTop: true,
                    );
                  }),
              onLoading: CupertinoActivityIndicator(radius: 40),
              onEmpty: Icon(CupertinoIcons.tornado, size: 80),
              onError: (error) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.xmark_seal, size: 80),
                  Text(error.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultListViewExceptionLogic
    extends FunStateListController<ArticleEntity> {
  PageState _state = PageState.success;

  set state(PageState state) {
    _state = state;
    loadData();
  }

  @override
  Future<List<ArticleEntity>> onLoadData() async {
    await 1.seconds.delay();
    if (_state == PageState.error) {
      throw "加载数据出错";
    } else if (_state == PageState.empty) {
      return [];
    }
    return fetchArticles(0);
  }
}

/// action不需要支持empty的情况
enum PageState { success, error, empty }
