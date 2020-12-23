
import 'dart:convert';
import 'package:flutter_trip/common/api_response_status.dart';
import 'package:flutter_trip/model/response_model.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

const SEARCH_URL = "http://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=";
/// 搜索dao
class SearchDao {
  static Future<ResponseModel<SearchModel>> fetch(String keyword) async {
    try{
      final response = await http.get(SEARCH_URL + keyword);
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      if(response.statusCode == APIResponseStatus.success) {
        return ResponseModel<SearchModel>.fromJson(result);
      }else {
        var resultModel = ResponseModel<SearchModel>.fromJson(result);
        resultModel.success = false;
        return resultModel;
      }
    }catch(e) {
      print(e);
      var responseModel = new ResponseModel(success: false, code: 500, msg: "请求失败");
      return responseModel;
    }
  }
}