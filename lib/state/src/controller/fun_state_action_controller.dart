/// @author phoenixsky
/// @date 2021/6/10
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/widgets.dart';
import 'fun_state_mixin.dart';

/// 动作类管理器
/// 主要用于按钮点击等触发动作 : 登录等
abstract class FunStateActionController<T> extends FunStateMixinController {


  /// 通过重写该方法,填充数据加载逻辑
  /// 不能直接调用,手动加载使用[loadData]方法
  @protected
  Future<T> onLoadData();

  loadData() async {
    changeLoading();
    try {
      T data = await onLoadData();
      changeIdle();
      return data;
    } catch (e, s) {
      changeError(e, stackTrace: s);
    }
  }
}
