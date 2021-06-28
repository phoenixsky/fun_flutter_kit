import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'fun_state_list_refresher_controller.dart';
import 'fun_state_mixin.dart';

typedef FunStateBuilder = Widget Function();
typedef FunStateErrorBuilder = Widget Function(FunStateError error);

/// 响应式
class FunStateObx extends StatelessWidget {
  const FunStateObx({
    required this.controller,
    required this.builder,
    this.onError,
    this.onLoading,
    this.onEmpty,
    Key? key,
  }) : super(key: key);

  final FunStateMixinController controller;

  final FunStateBuilder builder;
  final Widget? onLoading;
  final Widget? onEmpty;
  final FunStateErrorBuilder? onError;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      builder,
      onEmpty: onEmpty,
      onLoading: onLoading,
      onError: onError,
    );
  }
}

/// 支持下拉刷新和上拉加载更多
class FunStateRefresherObx<T> extends StatelessWidget {
  const FunStateRefresherObx({
    Key? key,
    required this.controller,
    required this.builder,
    this.onLoading,
    this.onEmpty,
    this.onError,
    this.enablePullUp: false,
    this.header,
    this.footer,
  }) : super(key: key);

  final FunStateListRefresherController<T> controller;

  /// StateWidget
  final FunStateBuilder builder;
  final Widget? onLoading;
  final Widget? onEmpty;
  final FunStateErrorBuilder? onError;

  /// copy from SmartRefresher
  final bool enablePullUp;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return FunStateObx(
      controller: controller,
      builder: () => RefreshConfiguration(
        hideFooterWhenNotFull: true,
        child: SmartRefresher(
          child: builder(),
          controller: controller.refreshController,

          /// SmartRefresh
          onRefresh: controller.pullToRefresh,
          onLoading: controller.loadMore,
          enablePullUp: enablePullUp,

          header: header ?? ClassicHeader(),
          footer: footer ?? ClassicFooter(),
        ),
      ),
      onEmpty: onEmpty,
      onLoading: onLoading,
      onError: onError,
    );
  }
}
