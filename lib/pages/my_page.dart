import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/web_view.dart';

/// @author  Harry 
/// @date  2020/11/25 19:48
class MyPage extends StatefulWidget {

  PageController pageController;

  MyPage({this.pageController});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {



  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebView(
        url: 'https://m.ctrip.com/webapp/myctrip',
        hideAppBar: true,
        title: null,
        statusBarColor: null,
        pageController: widget.pageController
      )
    );
  }
}