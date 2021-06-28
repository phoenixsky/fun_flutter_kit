/// @author phoenixsky
/// @date 2021/6/8
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'fun_state_configuration.dart';
import 'fun_state_list_controller.dart';

abstract class FunStateListRefresherController<T>
    extends FunStateBaseListController<T> {
  /// 下拉刷新控制器
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  late int _currentPageNum;

  @override
  @mustCallSuper
  void onInit() {
    /// 是否需要在页面第一次加载的时候load数据
    if (funStateStatus.isLoading) {
      pullToRefresh(isInit: true);
    }
    super.onInit();
  }

  @override
  @mustCallSuper
  void onClose() {
    super.onClose();
    _refreshController.dispose();
  }

  /// 下拉刷新
  ///
  /// [isInit]是否是第一次加载,主要用来显示骨架屏等空页面时的loading效果
  pullToRefresh({bool isInit = false}) async {
    if (isInit) changeLoading();

    /// 分页
    final _paging = paging();
    _currentPageNum = _paging.firstPageNo;
    int _pageSize = _paging.pageSize;

    try {
      /// 当前接口返回数据
      List<T> data = await onLoadData(_currentPageNum, pageSize: _pageSize);
      if (data.isEmpty) {
        _refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        changeEmpty();
      } else {
        onCompleted(data);
        list.assignAll(data);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < _pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        changeIdle(forceUpdate: true);
      }
    } catch (e, s) {
      if (isInit) list.clear();
      refreshController.refreshFailed();
      changeError(e, stackTrace: s);
    }
  }

  /// 上拉加载更多
  loadMore() async {
    final _paging = paging();
    _currentPageNum = _paging.firstPageNo;
    int _pageSize = _paging.pageSize;
    try {
      var data = await onLoadData(++_currentPageNum, pageSize: _pageSize);
      if (data.isEmpty) {
        /// 数据为空,当前页索引减一,防止上拉无线增大
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < _pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }

        /// 上拉加载更多
        changeIdle(forceUpdate: true);
      }
    } catch (e, s) {
      /// 记载失败,当前页索引减一,防止上拉无限增大
      _currentPageNum--;
      refreshController.loadFailed();
      // todo 记录错误 打印堆栈信息
      // debugPrint('error--->\n' + e.toString());
      // debugPrint('statck--->\n' + s.toString());
    }
  }

  /// 加载数据
  Future<List<T>> onLoadData(int pageNum, {int? pageSize});

  /// 分页配置,通过重写来局部自定义分页参数.
  /// 默认可以通过[FunFlutterConfiguration]读取
  /// [firstPageNo]默认0
  /// [pageSize]默认20
  FunStatePaging paging() => FunFlutterConfiguration.of(Get.context!).paging;
}
