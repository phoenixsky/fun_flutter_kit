/// @author phoenixsky
/// @date 2021/5/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension DecorationBorder on double {
  /// 头部边框
  BoxBorder get topBorder =>
      Border(top: Divider.createBorderSide(Get.context, width: this));

  /// 底部边框
  BoxBorder get bottomBorder =>
      Border(bottom: Divider.createBorderSide(Get.context, width: this));

  BoxDecoration get topBorderDecoration =>
      BoxDecoration(border: this.topBorder);

  BoxDecoration get bottomBorderDecoration =>
      BoxDecoration(border: this.bottomBorder);
}
