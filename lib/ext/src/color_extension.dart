/// @author phoenixsky
/// @date 2021/6/28
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter


import 'dart:ui';

extension wrapColor on String {
  Color get color {
    var hexColor = this.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    // if (hexColor.length == 8) {
    //   return Color(int.parse("0x$hexColor"));
    // }
    return Color(int.parse(hexColor, radix: 16));
  }
}
