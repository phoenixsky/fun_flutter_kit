/// @author phoenixsky
/// @date 2021/6/24
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// 控制[FunFlutterKit]小部件在子树中的行为方式
///
///
class FunFlutterConfiguration extends InheritedWidget {
  final FunStateBehavior funStateBehavior;

  const FunFlutterConfiguration({
    Key? key,
    required Widget child,
    required this.funStateBehavior,
  }) : super(key: key, child: child);

  static FunStateBehavior of(BuildContext context) {
    final FunFlutterConfiguration? configuration =
        context.dependOnInheritedWidgetOfExactType<FunFlutterConfiguration>();
    return configuration?.funStateBehavior ??
        FunStateBehavior(paging: FunStatePaging());
  }

  @override
  bool updateShouldNotify(FunFlutterConfiguration oldWidget) {
    return funStateBehavior.runtimeType !=
            oldWidget.funStateBehavior.runtimeType ||
        (funStateBehavior != oldWidget.funStateBehavior &&
            funStateBehavior.shouldNotify(oldWidget.funStateBehavior));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<FunStateBehavior>('behavior', funStateBehavior));
  }
}

/// FunState全局配置
class FunStateBehavior {
  final FunStatePaging paging;

  FunStateBehavior({required this.paging});

  bool shouldNotify(covariant FunStateBehavior oldDelegate) => false;
}

class FunStatePaging {
  /// 分页加载初始页页码
  final int firstPageNo;

  /// 每页加载的数量
  final int pageSize;

  FunStatePaging({this.firstPageNo: 0, this.pageSize: 20});
}
