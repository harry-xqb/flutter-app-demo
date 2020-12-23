
import 'dart:convert';
import 'package:flutter_trip/common/api_response_status.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/response_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = "http://www.touchfish.top/mock/5fbb6df3c054360020e02845/trip/home";
/// 首页dao
class HomeDao {
  static Future<ResponseModel<HomeModel>> fetch() async {
    try{
      final response = await http.get(HOME_URL);
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      if(response.statusCode == APIResponseStatus.success) {
        return ResponseModel<HomeModel>.fromJson(result);
      }else {
        var resultModel = ResponseModel<HomeModel>.fromJson(result);
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