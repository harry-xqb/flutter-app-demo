import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const HOME_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
  'https://m.ctrip.com/webapp/you/',
  'https://m.ctrip.com/webapp/you/gsdestination/?seo=0',
  'www.ctrip.com/',
];

/// @author  Harry 
/// @date  2020/11/27 15:09
class WebView extends StatefulWidget {

  final String url;

  final String title;

  final String statusBarColor;

  final bool hideAppBar;

  final PageController pageController;

  const WebView({Key key, this.url, this.statusBarColor, this.hideAppBar = false, this.title, this.pageController}) : super(key: key);


  @override
  _WebViewState createState() => _WebViewState();

}

class _WebViewState extends State<WebView> {

  final webViewReference = FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  bool popFlag = false;

  @override
  void initState() {
    super.initState();
    webViewReference.close();
    _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {});
    _onStateChanged = webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      // 可以监听url的变化
      if(popFlag) {
        return;
      }
      switch(state.type) {
        case WebViewState.startLoad:
          if(_isToHome(state.url)) {
            popFlag = true;
            if(widget.pageController != null) {
              widget.pageController.jumpToPage(0);
              return;
            }
            Navigator.pop(context);
          }
          break;
        case WebViewState.shouldStart:
          if(_isToHome(state.url)) {
            popFlag = true;
            if(widget.pageController != null) {
              widget.pageController.jumpToPage(0);
              return;
            }
            Navigator.pop(context);
          }
          break;
        default:
          break;
      }
    });
    _onHttpError = webViewReference.onHttpError.listen((event) {
      print('加载错误..');
    });
  }

  bool _isToHome(String url) {
    for (final value in HOME_URLS) {
      if(url?.endsWith(value)) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webViewReference.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    Color barColor = Color(int.parse("0xff" + statusBarColorStr));
    if(statusBarColorStr == 'ffffff' || statusBarColorStr == 'FFFFFF') {
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }
    return Scaffold(
        body: Column(
          children: [
            _appBar(barColor, backButtonColor),
            Expanded(
              child: WebviewScaffold(
                // appBar: AppBar(title: Text(widget.title), backgroundColor: barColor, iconTheme: IconThemeData(color: backButtonColor)),
                url: widget.url,
                withLocalStorage: true,
                withZoom: true,
                hidden: true,
              )
            )
          ],
        )
    );
  }

  Widget _appBar(Color barBackgroundColor, Color backButtonColor) {
    if(widget.hideAppBar ?? false) {
      return Container(
        color: barBackgroundColor,
        height: 23,
      );
    }
    return Container(
      color: barBackgroundColor,
      padding: EdgeInsets.only(top: 23),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 2, 0, 0),
              child: Icon(
                Icons.close,
                color: backButtonColor,
                size: 26,
              ),
            ),
          ),
          Center(
            child: Text(widget.title, style: TextStyle(color: backButtonColor, fontSize: 20)),
          )
        ],
      ),
    );
  }
}

