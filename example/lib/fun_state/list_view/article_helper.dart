/// @author phoenixsky
/// @date 2021/6/28
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_flutter_kit/fun_flutter_kit.dart';
import 'package:get/get.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    Key? key,
    required this.article,
    this.index,
    this.isHomeTop: false,
  }) : super(key: key);

  final ArticleEntity article;
  final int? index;

  /// 是否是首页置顶
  final bool isHomeTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: 0.7.bottomBorderDecoration,
      child: Column(
        children: [
          Row(
            children: [
              ArticleImage(
                assetName: "avatar_small".assetJpeg,
                width: 20,
                height: 20,
                shape: BoxShape.circle,
              ).marginOnly(right: 5),
              Text(
                article.author!.isNotEmpty
                    ? article.author!
                    : article.shareUser!,
                style: Get.textTheme.caption,
              ),
              if(index != null) Text(index.toString()).paddingOnly(left: 10),
              Expanded(child: SizedBox.shrink()),
              Text(article.niceDate!, style: Get.textTheme.caption),
            ],
          ),

          /// 没有图片
          if (article.envelopePic!.isEmpty)
            Text(article.title!).paddingOnly(top: 7)
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArticleTitle(article.title!),
                      Text(
                        article.desc!,
                        style: Get.textTheme.caption,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ).marginOnly(right: 5),
                ),
                ArticleImage(
                    assetName: "avatar_big".assetJpeg, width: 60, height: 60)
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                article.superChapterName!.isNotEmpty
                    ? article.superChapterName! + ' · ' + article.chapterName!
                    : article.chapterName!,
                style: Theme.of(context).textTheme.overline,
              ).paddingOnly(top: 5, bottom: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class ArticleImage extends StatelessWidget {
  const ArticleImage(
      {Key? key, required this.assetName, this.shape, this.width, this.height})
      : super(key: key);

  final double? width;
  final double? height;
  final String assetName;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width, height: height),
      child: Container(
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(image: AssetImage(assetName)),
        ),
      ),
    );
  }
}

class ArticleTitle extends StatelessWidget {
  const ArticleTitle(this.title, {Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        )).paddingSymmetric(vertical: 3);
  }
}

/// 接口
Future<List<ArticleEntity>> fetchArticles(int pageNum, {int? cid = 294}) async {
  if (pageNum == 0) await Future.delayed(Duration(seconds: 1)); //增加动效
  var resp = await Dio().get(
      'https://www.wanandroid.com/article/list/$pageNum/json',
      queryParameters: (cid != null ? {'cid': cid} : null));

  return resp.data['data']['datas']
      .map<ArticleEntity>((item) => ArticleEntity.fromJson(item))
      .toList();
}

/// entity
class ArticleEntity {
  String? _apkLink;
  int? _audit;
  String? _author;
  bool? _canEdit;
  int? _chapterId;
  String? _chapterName;
  bool? _collect;
  int? _courseId;
  String? _desc;
  String? _descMd;
  String? _envelopePic;
  bool? _fresh;
  String? _host;
  int? _id;
  String? _link;
  String? _niceDate;
  String? _niceShareDate;
  String? _origin;
  String? _prefix;
  String? _projectLink;
  int? _publishTime;
  int? _realSuperChapterId;
  int? _selfVisible;
  int? _shareDate;
  String? _shareUser;
  int? _superChapterId;
  String? _superChapterName;
  List<Tags>? _tags;
  String? _title;
  int? _type;
  int? _userId;
  int? _visible;
  int? _zan;

  String? get apkLink => _apkLink;

  int? get audit => _audit;

  String? get author => _author;

  bool? get canEdit => _canEdit;

  int? get chapterId => _chapterId;

  String? get chapterName => _chapterName;

  bool? get collect => _collect;

  int? get courseId => _courseId;

  String? get desc => _desc;

  String? get descMd => _descMd;

  String? get envelopePic => _envelopePic;

  bool? get fresh => _fresh;

  String? get host => _host;

  int? get id => _id;

  String? get link => _link;

  String? get niceDate => _niceDate;

  String? get niceShareDate => _niceShareDate;

  String? get origin => _origin;

  String? get prefix => _prefix;

  String? get projectLink => _projectLink;

  int? get publishTime => _publishTime;

  int? get realSuperChapterId => _realSuperChapterId;

  int? get selfVisible => _selfVisible;

  int? get shareDate => _shareDate;

  String? get shareUser => _shareUser;

  int? get superChapterId => _superChapterId;

  String? get superChapterName => _superChapterName;

  List<Tags>? get tags => _tags;

  String? get title => _title;

  int? get type => _type;

  int? get userId => _userId;

  int? get visible => _visible;

  int? get zan => _zan;

  ArticleEntity(
      {String? apkLink,
      int? audit,
      String? author,
      bool? canEdit,
      int? chapterId,
      String? chapterName,
      bool? collect,
      int? courseId,
      String? desc,
      String? descMd,
      String? envelopePic,
      bool? fresh,
      String? host,
      int? id,
      String? link,
      String? niceDate,
      String? niceShareDate,
      String? origin,
      String? prefix,
      String? projectLink,
      int? publishTime,
      int? realSuperChapterId,
      int? selfVisible,
      int? shareDate,
      String? shareUser,
      int? superChapterId,
      String? superChapterName,
      List<Tags>? tags,
      String? title,
      int? type,
      int? userId,
      int? visible,
      int? zan}) {
    _apkLink = apkLink;
    _audit = audit;
    _author = author;
    _canEdit = canEdit;
    _chapterId = chapterId;
    _chapterName = chapterName;
    _collect = collect;
    _courseId = courseId;
    _desc = desc;
    _descMd = descMd;
    _envelopePic = envelopePic;
    _fresh = fresh;
    _host = host;
    _id = id;
    _link = link;
    _niceDate = niceDate;
    _niceShareDate = niceShareDate;
    _origin = origin;
    _prefix = prefix;
    _projectLink = projectLink;
    _publishTime = publishTime;
    _realSuperChapterId = realSuperChapterId;
    _selfVisible = selfVisible;
    _shareDate = shareDate;
    _shareUser = shareUser;
    _superChapterId = superChapterId;
    _superChapterName = superChapterName;
    _tags = tags;
    _title = title;
    _type = type;
    _userId = userId;
    _visible = visible;
    _zan = zan;
  }

  ArticleEntity.fromJson(dynamic json) {
    _apkLink = json["apkLink"];
    _audit = json["audit"];
    _author = json["author"] ?? "";
    _canEdit = json["canEdit"];
    _chapterId = json["chapterId"];
    _chapterName = json["chapterName"];
    _collect = json["collect"];
    _courseId = json["courseId"];
    _desc = json["desc"];
    _descMd = json["descMd"];
    _envelopePic = json["envelopePic"];
    _fresh = json["fresh"];
    _host = json["host"];
    _id = json["id"];
    _link = json["link"];
    _niceDate = json["niceDate"];
    _niceShareDate = json["niceShareDate"];
    _origin = json["origin"];
    _prefix = json["prefix"];
    _projectLink = json["projectLink"];
    _publishTime = json["publishTime"];
    _realSuperChapterId = json["realSuperChapterId"];
    _selfVisible = json["selfVisible"];
    _shareDate = json["shareDate"];
    _shareUser = json["shareUser"];
    _superChapterId = json["superChapterId"];
    _superChapterName = json["superChapterName"];
    if (json["tags"] != null) {
      _tags = [];
      json["tags"].forEach((v) {
        _tags?.add(Tags.fromJson(v));
      });
    }
    _title = json["title"];
    _type = json["type"];
    _userId = json["userId"];
    _visible = json["visible"];
    _zan = json["zan"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["apkLink"] = _apkLink;
    map["audit"] = _audit;
    map["author"] = _author;
    map["canEdit"] = _canEdit;
    map["chapterId"] = _chapterId;
    map["chapterName"] = _chapterName;
    map["collect"] = _collect;
    map["courseId"] = _courseId;
    map["desc"] = _desc;
    map["descMd"] = _descMd;
    map["envelopePic"] = _envelopePic;
    map["fresh"] = _fresh;
    map["host"] = _host;
    map["id"] = _id;
    map["link"] = _link;
    map["niceDate"] = _niceDate;
    map["niceShareDate"] = _niceShareDate;
    map["origin"] = _origin;
    map["prefix"] = _prefix;
    map["projectLink"] = _projectLink;
    map["publishTime"] = _publishTime;
    map["realSuperChapterId"] = _realSuperChapterId;
    map["selfVisible"] = _selfVisible;
    map["shareDate"] = _shareDate;
    map["shareUser"] = _shareUser;
    map["superChapterId"] = _superChapterId;
    map["superChapterName"] = _superChapterName;
    if (_tags != null) {
      map["tags"] = _tags?.map((v) => v.toJson()).toList();
    }
    map["title"] = _title;
    map["type"] = _type;
    map["userId"] = _userId;
    map["visible"] = _visible;
    map["zan"] = _zan;
    return map;
  }
}

/// name : "公众号"
/// url : "/wxarticle/list/408/1"

class Tags {
  String? _name;
  String? _url;

  String? get name => _name;

  String? get url => _url;

  Tags({String? name, String? url}) {
    _name = name;
    _url = url;
  }

  Tags.fromJson(dynamic json) {
    _name = json["name"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["url"] = _url;
    return map;
  }
}
