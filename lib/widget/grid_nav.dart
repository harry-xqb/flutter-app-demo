import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/util/tab_webview_util.dart';
import 'package:flutter_trip/widget/web_view.dart';

/// @author  Harry 
/// @date  2020/11/30 9:26
class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _buildList(context),
        ),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    List<Widget> items = [];
    if(gridNavModel == null) {
      return items;
    }
    if(gridNavModel.hotel != null) {
      items.add(_buildRow(context, gridNavModel.hotel, true));
    }
    if(gridNavModel.flight != null) {
      items.add(_buildRow(context, gridNavModel.flight, false));
    }
    if(gridNavModel.travel != null) {
      items.add(_buildRow(context, gridNavModel.travel, false));
    }
    return items;
  }

  
  Widget _buildRow(BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    Color startColor = Color(int.parse("0xff" + gridNavItem.startColor));
    Color endColor = Color(int.parse("0xff" + gridNavItem.endColor));
    print(gridNavItem);
    return Container(
      height: 88,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            startColor,
            endColor
          ]
        ),
      ),
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                CommonModel model = new CommonModel(
                  url: gridNavItem.mainItem.url,
                  title: gridNavItem.mainItem.title,
                  statusBarColor: gridNavItem.mainItem.statusBarColor,
                  hideAppBar: gridNavItem.mainItem.hideAppBar,
                );
                WebViewTabUtil.navigateTo(context, model);
              },
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Image.network(
                    gridNavItem.mainItem.icon,
                    height: 88,
                    width: 121,
                    fit: BoxFit.contain,
                    alignment: AlignmentDirectional.bottomEnd,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(gridNavItem.mainItem.title, style: TextStyle(color: Colors.white, fontSize: 14)),
                  )
                ],
              ),
            )
          ),
          _buildColumnItem(context, gridNavItem.item1, gridNavItem.item2),
          _buildColumnItem(context, gridNavItem.item3, gridNavItem.item4),
        ],
      ),
    );
  }

  Widget _buildColumnItem(BuildContext context, CommonModel itemTop, CommonModel itemBottom) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  WebViewTabUtil.navigateTo(context, itemTop);
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.white, width: 1),
                          bottom: BorderSide(color: Colors.white, width: 1),
                        )
                    ),
                    child: Center(
                      child: Text(itemTop.title,
                          style: TextStyle(
                              color: Colors.white
                          )
                      ),
                    )
                ),
              )
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  WebViewTabUtil.navigateTo(context, itemBottom);
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.white, width: 1),
                        )
                    ),
                    child: Center(
                        child: Text(itemBottom.title,
                            style: TextStyle(
                                color: Colors.white
                            )
                        )
                    )
                ),
              )
            ),
          ],
        )
    );
  }

}
