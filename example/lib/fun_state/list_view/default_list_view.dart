
import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import 'article_helper.dart';

/// 正常列表数据加载
class DefaultListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DefaultListViewPageLogic logic = Get.put(DefaultListViewPageLogic());
    return Scaffold(
      appBar: AppBar(title: Text("DefaultListPageLogic")),
      body: FunStateObx(
        controller: logic,
        builder: () => ListView.builder(
            itemCount: logic.list.length,
            itemBuilder: (context, index) {
              return ArticleItem(
                article: logic.list[index],
                isHomeTop: true,
              );
            }),
      ),
    );
  }
}

class DefaultListViewPageLogic extends FunStateListController<ArticleEntity> {
  @override
  Future<List<ArticleEntity>> onLoadData() async {
    return fetchArticles(0);
  }
}
