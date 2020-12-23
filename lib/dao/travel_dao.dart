
import 'dart:convert';
import 'package:flutter_trip/common/api_response_status.dart';
import 'package:flutter_trip/model/response_model.dart';
import 'package:flutter_trip/model/tab_page_mode.dart';
import 'package:flutter_trip/model/travel_tabs_model.dart';
import 'package:http/http.dart' as http;

// 获取tabs url
const TABS_URL = "http://www.touchfish.top/mock/5fbb6df3c054360020e02845/travel/tabs";
// 获取tab下内容url
const TAB_PAGE_URL = "http://www.touchfish.top/mock/5fbb6df3c054360020e02845/video/1";
/// 旅拍dao
class TravelDao {
  /// 获取tabs
  static Future<ResponseModel<TravelTabsModel>> getTabs() async {
    try{
      final response = await http.get(TABS_URL);
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      if(response.statusCode == APIResponseStatus.success) {
        return ResponseModel<TravelTabsModel>.fromJson(result);
      }else {
        var resultModel = ResponseModel<TravelTabsModel>.fromJson(result);
        resultModel.success = false;
        return resultModel;
      }
    }catch(e) {
      print(e);
      var responseModel = new ResponseModel(success: false, code: 500, msg: "获取tabs失败");
      return responseModel;
    }
  }

  static Future<ResponseModel<TabPageModel>> getTabPage(String tagId) async {
    try{
      final response = await http.get(TAB_PAGE_URL);
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      result['msg'] = result['status']['msg'];
      result['code'] = result['status']['retCode'];
      if(response.statusCode == APIResponseStatus.success) {
        return ResponseModel<TabPageModel>.fromJson(result);
      }else {
        var resultModel = ResponseModel<TabPageModel>.fromJson(result);
        resultModel.success = false;
        return resultModel;
      }
    }catch(e) {
      print(e);
      var responseModel = new ResponseModel(success: false, code: 500, msg: "获取tab内容失败");
      return responseModel;
    }
  }
}