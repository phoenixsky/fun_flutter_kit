/// @author phoenixsky
/// @date 2021/6/9
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

extension StringExtension on String {
  /// 字符转int
  int get parseInt => int.parse(this);

  /// 解决排版断句问题,防止文字被省略
  String get notBreak => replaceAll('', '\u{200B}');
}
