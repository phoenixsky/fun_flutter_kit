import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

import '../article_helper.dart';


class RefresherLoadMoreListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RefresherLoadMoreListViewLogic logic = Get.put(RefresherLoadMoreListViewLogic());
    return Scaffold(
        appBar: AppBar(title: Text("RefresherLoadMoreListView")),
        body: FunStateRefresherObx(
          builder: () => ListView.builder(
              itemCount: logic.list.length,
              itemBuilder: (context, index) {
                return ArticleItem(
                  article: logic.list[index],
                  isHomeTop: true,
                );
              }),
          controller: logic,
          enablePullUp: true,
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(child: Text("无数据")),
          onError: (err) => Center(child: Text('出错了$err')),
        ));
  }
}

class RefresherLoadMoreListViewLogic extends FunStateListRefresherController<ArticleEntity> {
  @override
  Future<List<ArticleEntity>> onLoadData(int pageNum, {int? pageSize}) {
    return fetchArticles(pageNum);
  }
}