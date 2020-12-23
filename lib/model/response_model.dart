
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/model/travel_tabs_model.dart';

import 'tab_page_mode.dart';

class ResponseModel<T> {

  bool success;

  final int code;

  final String msg;

  final T data;

  final dataJson;


  ResponseModel({this.code, this.msg, this.data, this.dataJson, this.success = true});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        code: json['code'],
        msg: json['msg'],
        data: _parseData(json['data']),
        dataJson: json['data']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.dataJson;
    }
    return data;
  }
}

T _parseData<T>(json) {
  if(T == HomeModel) {
    return HomeModel.fromJson(json) as T;
  }
  if(T == SearchModel) {
    return SearchModel.fromJson(json) as T;
  }
  if(T == TravelTabsModel) {
    return TravelTabsModel.fromJson(json) as T;
  }
  if(T == TabPageModel) {
    return TabPageModel.fromJson(json) as T;
  }
  throw Exception("未知类型");
}
