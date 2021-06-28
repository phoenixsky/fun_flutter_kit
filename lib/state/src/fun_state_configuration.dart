/// @author phoenixsky
/// @date 2021/6/24
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// 控制[FunState]小部件在子树中的行为方式
///
///
class FunStateConfiguration extends InheritedWidget {
  final FunStateBehavior behavior;

  const FunStateConfiguration({
    Key? key,
    required Widget child,
    required this.behavior,
  }) : super(key: key, child: child);

  static FunStateBehavior of(BuildContext context) {
    final FunStateConfiguration? configuration =
        context.dependOnInheritedWidgetOfExactType<FunStateConfiguration>();
    return configuration?.behavior ?? FunStateBehavior();
  }

  @override
  bool updateShouldNotify(FunStateConfiguration oldWidget) {
    return behavior.runtimeType != oldWidget.behavior.runtimeType ||
        (behavior != oldWidget.behavior &&
            behavior.shouldNotify(oldWidget.behavior));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FunStateBehavior>('behavior', behavior));
  }
}

class FunStateBehavior {
  /// 分页加载初始页页码
  final int firstPageNum;

  /// 每页加载的数量
  final int pageSize;

  FunStateBehavior({
    this.firstPageNum: 0,
    this.pageSize: 20,
  });

  bool shouldNotify(covariant FunStateBehavior oldDelegate) => false;
}
