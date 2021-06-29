import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:fun_flutter_kit/state/src/fun_state_configuration.dart';
import 'package:get/get.dart';

import 'article_helper.dart';

class RefresherLoadMoreListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RefresherLoadMoreListViewLogic logic =
        Get.put(RefresherLoadMoreListViewLogic());
    return Scaffold(
        appBar: AppBar(title: Text("RefresherLoadMoreListView")),
        body: FunStateRefresherObx(
          builder: () => ListView.builder(
              itemCount: logic.list.length,
              itemBuilder: (context, index) {
                return ArticleItem(
                  article: logic.list[index],
                  index: index,
                  isHomeTop: true,
                );
              }),
          controller: logic,
          enablePullUp: true,
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: InkWell(
              onTap: () {
                logic.pullToRefresh(isInit: true);
              },
              child: Text("无数据,点击重试"),
            ),
          ),
          onError: (err) => Center(child: Text('出错了$err')),
        ));
  }
}

class RefresherLoadMoreListViewLogic
    extends FunStateListRefresherController<ArticleEntity> {
  /// 分页参数
  FunStatePaging paging() => FunStatePaging(firstPageNo: 0, pageSize: 20);

  @override
  Future<List<ArticleEntity>> onLoadData(int pageNum, {int? pageSize}) {
    return fetchArticles(pageNum);
  }
}
