import 'package:flutter/material.dart';
import 'package:fun_flutter_kit_example/fun_state/list_view/refresher_load_more_list_view.dart';
import 'package:fun_flutter_kit_example/fun_state/list_view/refresher_load_more_list_view_pull_by_ctrl.dart';
import 'package:get/get.dart';

import 'action/state_action.dart';
import 'action/state_action_exception_view.dart';
import 'list_view/default_list_view.dart';
import 'list_view/default_list_view_exception.dart';
import 'list_view/refresher_list_view.dart';
import 'list_view/refresher_load_more_list_view_manual_pull.dart';

class FunStatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FunStatePage")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
                child: Text(
              'ActionState',
              style: Get.textTheme.headline4,
            )),
            OutlinedButton(
                child: Text("ActionState"),
                onPressed: () {
                  Get.to(() => FunStateActionView());
                }),
            OutlinedButton(
                child: Text("异常处理"),
                onPressed: () {
                  Get.to(() => FunStateActionExceptionPage());
                }),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              '列表相关',
              style: Get.textTheme.headline4,
            )),
            OutlinedButton(
                child: Text("一般列表"),
                onPressed: () {
                  Get.to(() => DefaultListViewPage());
                }),
            OutlinedButton(
                child: Text("一般列表，异常处理"),
                onPressed: () {
                  Get.to(() => DefaultListViewExceptionPage());
                }),
            OutlinedButton(
                child: Text("仅下拉刷新"),
                onPressed: () {
                  Get.to(() => RefresherListViewPage());
                }),
            OutlinedButton(
                child: Text("下拉刷新，上拉加载 -- 自动"),
                onPressed: () {
                  Get.to(() => RefresherLoadMoreListViewPage());
                }),
            OutlinedButton(
              child: Text("下拉刷新，上拉加载 -- 手动"),
              onPressed: () {
                Get.to(() => RefresherLoadMoreListViewManualPullPage());
              },
            ),
            OutlinedButton(
              child: Text("下拉刷新，上拉加载 -- 通过controller控制"),
              onPressed: () {
                Get.to(() => RefresherLoadMoreListViewPullByCtrlPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
