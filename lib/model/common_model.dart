import 'dart:convert';

/// 首页公共类
class CommonModel {

  final String icon;

  final String title;

  final String url;

  final String statusBarColor;

  final bool hideAppBar;


  CommonModel({this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }

  static List<CommonModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CommonModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}