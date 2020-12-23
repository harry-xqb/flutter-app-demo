import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_tabs_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';

/// @author  Harry 
/// @date  2020/11/25 19:47
class TravelPage extends StatefulWidget {

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController _tabController;

  TravelTabsModel tabsModel;

  @override
  void initState() {
    _tabController = TabController(length: tabsModel?.tabs?.length ?? 0, vsync: this);
    TravelDao.getTabs().then((result){
      if(result.success) {
        setState(() {
          this.tabsModel = result.data;
        });
        _tabController = TabController (length: result.data.tabs.length, vsync: this);
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _tabs,
          _tabBarViews
        ],
      ),
    );
  }

  get _tabs{
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 27),
      child: TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.fromLTRB(20, 0, 20, 5),
        controller: _tabController,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.black45,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Color(0xff2fcfbb),
            width: 3
          ),
          insets: EdgeInsets.only(bottom: 5)
        ),
        tabs: tabsModel?.tabs?.map((tab){
          return Tab(text: tab.labelName);
        })?.toList() ?? [],
      ),
    );
  }

  get _tabBarViews{
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Expanded(
          child: TabBarView(
              controller: _tabController,
              children: tabsModel?.tabs?.map((tab){
                return tabItem(tab);
              })?.toList() ?? []
          )
      )
    );
  }


  Widget tabItem(item) {
    return TravelTabPage();
  }

  @override
  bool get wantKeepAlive => true;
}