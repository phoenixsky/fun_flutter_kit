/// @author phoenixsky
/// @date 2021/6/28
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

const String _assetImagePrefix = "assets/images/";
const String _assetAnimationPrefix = "assets/animations/";

/// 资源类扩展方法
extension wrapAsset on String {
  /// 图片url
  String get assetImg => _assetImagePrefix + this;

  String get assetPng => _assetImagePrefix + this + ".png";

  String get assetJpg => _assetImagePrefix + this + ".jpg";

  String get assetJpeg => _assetImagePrefix + this + ".jpeg";

  /// 选中图片的url
  /// 必须满足xxx_selected.png
  String get assetImgSelected {
    var split = this.split(".");
    return "${_assetImagePrefix + split[0]}_selected.${split[1]}";
  }

  /// 动画
  String get assetAnim => _assetAnimationPrefix + this;
}
