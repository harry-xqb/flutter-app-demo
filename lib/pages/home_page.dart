import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/common/api_response_status.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/response_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/util/tab_webview_util.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

/// @author  Harry 
/// @date  2020/11/25 19:46
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROlL_OFFSET = 100;

const DEFAULT_SEARCH_HINT = '网红打卡地 景点 酒店 美食';

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  double appBarOpacity = 0;

  String resultMsg = "";

  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;
  List<CommonModel> bannerList = [];
  bool _loading = true;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROlL_OFFSET;
    alpha = min(1, max(0, alpha)) ;
    setState(() {
      appBarOpacity = alpha;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future _loadData() async {
    ResponseModel<HomeModel> responseModel = await HomeDao.fetch();
    setState(() {
      _loading = false;
      if(responseModel.success) {
        resultMsg = json.encode(responseModel);
        localNavList = responseModel.data.localNavList;
        gridNavModel = responseModel.data.gridNav;
        subNavList = responseModel.data.subNavList;
        salesBoxModel = responseModel.data.salesBox;
        bannerList = responseModel.data.bannerList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: LoadingContainer(
        loading: _loading,
        cover: false,
        child: Stack(
          children: [
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: NotificationListener(
                  onNotification: (notification) {
                    if(notification is ScrollUpdateNotification && notification.depth == 0) {
                      _onScroll(notification.metrics.pixels);
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: _loadData,
                    child: _listView,
                  ),
                )
            ),
            _appBar,
          ],
        ),
      ),
    );
  }
  Widget get _listView{
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        _banner,
        LocalNav(localNavList: localNavList),
        GridNav(gridNavModel: gridNavModel),
        SubNav(subNavList: subNavList),
        SalesBox(salesBoxModel: salesBoxModel),
      ],
    );
  }
  Widget get _banner{
    if(bannerList.length == 0) {
      return Container(
        height: 160,
      );
    }
    return Container(
      height: 160,
      child:  Swiper(
          itemCount: bannerList.length,
          autoplay: true,
          pagination: SwiperPagination(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                WebViewTabUtil.navigateTo(context, bannerList[index]);
              },
              child: Image.network(
                bannerList[index].icon,
                fit: BoxFit.fill,
              ),
            );
          }
      ),
    );
  }

  Widget get _appBar{
    SearchBarMode mode = appBarOpacity > 0.2 ? SearchBarMode.homeLight : SearchBarMode.home;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 30, 5, 15),
            decoration: BoxDecoration(
              color: Color.fromARGB((255 * appBarOpacity).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              searchBarMode: mode,
              hint: DEFAULT_SEARCH_HINT,
              inputBoxClick: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) {
                      return SearchPage(hint: DEFAULT_SEARCH_HINT);
                    })
                );
              }
            ),
          ),
        ),
        Container(
          height: appBarOpacity > 0.2 ? 2 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}