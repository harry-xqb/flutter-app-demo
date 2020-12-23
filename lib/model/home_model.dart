

import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {

  final ConfigModel config;

  final List<CommonModel> bannerList;

  final List<CommonModel> localNavList;

  final GridNavModel gridNav;

  final List<CommonModel> subNavList;

  final SalesBoxModel salesBox;

  HomeModel({this.config, this.bannerList, this.localNavList, this.gridNav,
    this.subNavList, this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: CommonModel.fromJsonList(json['bannerList']),
      localNavList: CommonModel.fromJsonList(json['localNavList']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList:  CommonModel.fromJsonList(json['subNavList']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.localNavList != null) {
      data['localNavList'] = this.localNavList.map((v) => v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav.toJson();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList.map((v) => v.toJson()).toList();
    }
    if (this.salesBox != null) {
      data['salesBox'] = this.salesBox.toJson();
    }
    return data;
  }
}

