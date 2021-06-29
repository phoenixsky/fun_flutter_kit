/// @author phoenixsky
/// @date 2021/6/8
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'fun_state_mixin.dart';

/// 列表类状态管理
///
/// 子类只需要重写[loadData]方法,填充业务逻辑即可
///
/// 默认初始化加载数据 可通过重写[isNeedInitData]方法改变
abstract class FunStateBaseListController<T> extends FunStateMixinController {
  /// 数据源
  RxList<T> list = <T>[].obs;

  @override
  FunStateStatus initStatus() => FunStateStatus.loading();

  /// 当前页数据加载完成
  /// 用于数据的遍历处理的场景:更新文章收藏状态
  onCompleted(List<T> data) {}
}

/// 列表类状态管理
///
/// 子类只需要重写[loadData]方法,填充业务逻辑即可
///
/// 默认初始化加载数据 可通过重写[isNeedInitData]方法改变
abstract class FunStateListController<T> extends FunStateBaseListController<T> {
  @override
  void onInit() {
    /// 页面第一次加载数据
    if (funStateStatus.isLoading) {
      loadData();
    }
    super.onInit();
  }

  /// 通过重写该方法,填充数据加载逻辑
  /// 不能直接调用,手动加载使用[loadData]方法
  @protected
  Future<List<T>> onLoadData();

  loadData() async {
    changeLoading();
    try {
      /// 当前接口返回数据
      List<T> data = await onLoadData();
      if (data.isEmpty) {
        list.clear();
        changeEmpty();
      } else {
        onCompleted(data);
        list.assignAll(data);
        changeIdle();
      }
    } catch (e, s) {
      changeError(e,stackTrace: s);
    }
  }
}
