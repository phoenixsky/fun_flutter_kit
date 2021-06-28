/// @author phoenixsky
/// @date 2021/5/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';

extension ImageExtension on ImageProvider {
  /// 圆形
  ///
  /// 没有使用[ClipOval]是为了避免saveLayer。
  /// 文档:要创建带圆角的矩形，而不是clipping，请考虑使用很多 widget 都提供的 borderRadius属性。
  Widget get circular => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: this),
        ),
      );
}
