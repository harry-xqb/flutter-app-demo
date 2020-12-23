import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/util/tab_webview_util.dart';

/// @author  Harry
/// @date  2020/11/27 14:34
class SubNav extends StatelessWidget {

  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: EdgeInsets.fromLTRB(7, 10, 7, 0),
          child: _buildItems(context),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    if(subNavList == null) {
      return null;
    }
    List<Widget> items = [];
    subNavList.forEach((localNav) {
      items.add(_buildItem(context, localNav));
    });
    int separate = subNavList.length ~/ 2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, items.length),
          ),
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context, CommonModel localNav) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          WebViewTabUtil.navigateTo(context, localNav);
        },
        child: Column(
          children: [
            Image.network(
              localNav.icon,
              height: 16,
              width: 16,
            ),
            Text(localNav.title, style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }
}
