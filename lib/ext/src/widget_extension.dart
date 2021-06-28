/// @author phoenixsky
/// @date 2021/5/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

extension WidgetExtension on Widget {
  /// 用于键盘弹出后,底部按钮被遮盖问题
  /// 场景:如登录页表单弹出
  ///
  /// 方案:将view外层套一个ScrollView,大小为撑满屏幕
  /// [minHeight]为空则取屏幕高度
  Widget expandToScroll({double? minHeight}) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: minHeight ?? (Get.height - Get.statusBarHeight),
          ),
          child: IntrinsicHeight(child: this),
        ),
      );

  Widget get flex1 => Expanded(child: this, flex: 1);

  Widget get flex2 => Expanded(child: this, flex: 2);

  /// 撑满父组件
  Widget get fill =>
      ConstrainedBox(child: this, constraints: BoxConstraints.expand());
}
