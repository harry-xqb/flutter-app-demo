import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/util/tab_webview_util.dart';
import 'package:flutter_trip/widget/web_view.dart';

/// @author  Harry 
/// @date  2020/11/30 14:25
class SalesBox extends StatelessWidget {

  final SalesBoxModel salesBoxModel;

  final BorderSide _borderSide = BorderSide(color: Color(0xff2f2f2), width: 1); // Color(0xff2f2f2)

  SalesBox({Key key, this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      color: Colors.white,
      child: Column(
        children: _buildItems(context),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> items = [];
    if(salesBoxModel == null ) {
      return items;
    }
    items.add(_buildHead(context));
    items.add(_buildActivityRow(context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false));
    items.add(_buildActivityRow(context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false, false));
    items.add(_buildActivityRow(context, salesBoxModel.smallCard3, salesBoxModel.smallCard4, false, true));
    return items;
  }

  Widget _buildHead(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border(
          bottom: _borderSide // Color(0xff2f2f2)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(salesBoxModel.icon, height: 14),
          GestureDetector(
            onTap: () {
              CommonModel model = new CommonModel(url: salesBoxModel.moreUrl, title: "更多活动");
              WebViewTabUtil.navigateTo(context, model);
            },
            child:  Container(
              padding: EdgeInsets.fromLTRB(7, 1, 7, 1),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffff4e63), Color(0xffff6cc9)]
                  )
              ),
              child: Text("获取更多福利 >", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, CommonModel left, CommonModel right, bool big, bool last) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              WebViewTabUtil.navigateTo(context, left);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: last ? BorderSide.none : _borderSide,
                      right: _borderSide
                  )
              ),
              child: Image.network(
                left.icon,
                height: big ? 130 : 80,
              ),
            ),
          )
        ),
        Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                WebViewTabUtil.navigateTo(context, right);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: last ? BorderSide.none : _borderSide,
                    )
                ),
                child: Image.network(
                  right.icon,
                  height: big ? 130 : 80,
                ),
              ),
            )
        )
      ],
    );
  }
}
