/// @author phoenixsky
/// @date 2021/6/9
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

import 'fun_state_obx.dart';

/// 基础状态管理
abstract class FunStateMixinController extends FullLifeCycleController
    with FunStateMixin {
  /// 默认为闲置状态
  @override
  FunStateStatus initStatus() => FunStateStatus.idle();
}

/// StateMixin包装类
/// 为了简化change代码
mixin FunStateMixin on ListNotifier {
  FunStateStatus? _status;

  FunStateStatus get funStateStatus {
    notifyChildrens();
    return _status ??= _status = initStatus();
  }

  /// 初始化页面状态
  /// 可以用[funStateStatus.isLoading]判断是否初始化加载数据
  FunStateStatus initStatus();

  void _change(FunStateStatus status, {bool forceUpdate = false}) {
    /// 强制刷新
    if (_status == status && !forceUpdate) return;
    _status = status;
    refresh();
  }

  @protected
  changeIdle({bool forceUpdate = false}) {
    _change(FunStateStatus.idle(), forceUpdate: forceUpdate);
  }

  @protected
  changeLoading({bool forceUpdate = false}) {
    _change(FunStateStatus.loading(), forceUpdate: forceUpdate);
  }

  // @protected
  // changeLoadingMore({bool forceUpdate = false}) {
  //   change(FunStatus.loadingMore(),forceUpdate: forceUpdate);
  // }

  @protected
  changeEmpty({bool forceUpdate = false}) {
    _change(FunStateStatus.empty(), forceUpdate: forceUpdate);
  }

  /// [error]为dynamic类型
  /// [stackTrace]为堆栈信息
  /// [message]为业务层想展示的message,优先级会大于原error的message
  @protected
  changeError(dynamic error,
      {StackTrace? stackTrace, String? message, bool forceUpdate = false}) {
    final funStateError = FunStateError(error, stackTrace, message);
    _change(FunStateStatus.error(funStateError), forceUpdate: forceUpdate);
  }

  /// 重写了原get提供的扩展方法
  Widget obx(
    FunStateBuilder stateBuilder, {
    FunStateErrorBuilder? onError,
    Widget? onLoading,
    Widget? onEmpty,
  }) {
    return SimpleBuilder(builder: (_) {
      if (funStateStatus.isLoading) {
        return onLoading ?? const Center(child: CircularProgressIndicator());
      } else if (funStateStatus.isError) {
        /// onError的返回值如果为空,则返回原widget,适用于[FunStateAction]中的按钮场景
        return onError != null
            ? onError(funStateStatus.error!) ?? stateBuilder()
            : Center(child: Text(funStateStatus.error!.message!));
      } else if (funStateStatus.isEmpty) {
        return onEmpty != null
            ? onEmpty
            : SizedBox.shrink(); // Also can be widget(null); but is risky
      }
      return stateBuilder();
    });
  }
}

class FunStateStatus {
  final bool isIdle;
  final bool isLoading;
  final bool isEmpty;
  final bool isError;
  final bool isLoadingMore;
  final FunStateError? error;

  FunStateStatus._({
    this.isIdle = false,
    this.isEmpty = false,
    this.isLoading = false,
    this.isError = false,
    this.error,
    this.isLoadingMore = false,
  });

  factory FunStateStatus.idle() {
    return FunStateStatus._(isIdle: true);
  }

  factory FunStateStatus.loading() {
    return FunStateStatus._(isLoading: true);
  }

  factory FunStateStatus.loadingMore() {
    return FunStateStatus._(isIdle: true, isLoadingMore: true);
  }

  factory FunStateStatus.error(FunStateError error) {
    return FunStateStatus._(isError: true, error: error);
  }

  factory FunStateStatus.empty() {
    return FunStateStatus._(isEmpty: true);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FunStateStatus &&
          runtimeType == other.runtimeType &&
          isIdle == other.isIdle &&
          isLoading == other.isLoading &&
          isEmpty == other.isEmpty &&
          isError == other.isError &&
          isLoadingMore == other.isLoadingMore;

  @override
  int get hashCode =>
      isIdle.hashCode ^
      isLoading.hashCode ^
      isEmpty.hashCode ^
      isError.hashCode ^
      isLoadingMore.hashCode;
}

class FunStateError {
  final dynamic originError;
  final StackTrace? stackTrace;

  /// 业务message
  final String? _message;

  /// 原始的错误message
  late final String errorMessage;

  FunStateError(this.originError, [this.stackTrace, this._message]) {
    errorMessage = originError.toString();
    Get.log(stackTrace.toString());
  }

  get message => _message ?? errorMessage;

  @override
  String toString() {
    return '$message';
  }
}
