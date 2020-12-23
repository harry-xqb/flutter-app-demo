import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/util/tab_webview_util.dart';
import 'package:flutter_trip/widget/web_view.dart';

/// @author  Harry 
/// @date  2020/11/27 14:34
class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;

  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        shadowColor: Colors.grey,
        child: Container(
          height: 64,
          padding: EdgeInsets.fromLTRB(7, 10, 7, 0),
          child: _buildItems(context),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    if(localNavList == null) {
      return null;
    }
    List<Widget> items = [];
    localNavList.forEach((localNav) {
      items.add(_buildItem(context, localNav));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _buildItem(BuildContext context, CommonModel localNav) {
    return GestureDetector(
      onTap: () {
        WebViewTabUtil.navigateTo(context, localNav);
      },
      child: Column(
        children: [
          Image.network(
            localNav.icon,
            height: 32,
            width: 32,
          ),
          Text(localNav.title, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}
