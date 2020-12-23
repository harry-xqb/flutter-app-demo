import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/web_view.dart';

/// @author  Harry 
/// @date  2020/11/30 15:05
class WebViewTabUtil {

  static navigateTo(BuildContext context, CommonModel model) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return WebView(
            statusBarColor: model.statusBarColor,
            title: model.title,
            hideAppBar: model.hideAppBar,
            url: model.url,
          );
        }
    ));
  }
}
