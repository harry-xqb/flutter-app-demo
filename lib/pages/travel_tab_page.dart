import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/response_model.dart';
import 'package:flutter_trip/model/tab_page_mode.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

/// @author  Harry 
/// @date  2020/12/22 17:07
class TravelTabPage extends StatefulWidget {

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>  with AutomaticKeepAliveClientMixin{

  List<DataItem> _dataList = [];



  @override
  void initState() {
    print('请求数据');
    _loadData();
    super.initState();
  }

  Future _loadData() async {
    ResponseModel<TabPageModel> res = await TravelDao.getTabPage('1');
    if(res.success) {
      setState(() {
        _dataList = res.data.list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: new StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: _dataList.length,
            itemBuilder: (BuildContext context, int index) => buildItem(context, _dataList[index]),
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1)
        ),
      ),
      onRefresh: _loadData
    );
  }

  Widget buildItem(BuildContext context, DataItem item) {
    final width = MediaQuery.of(context).size.width - 12;
    final itemWidth = width / 2;
    final ratio =  (item.data.cover.photo.width / itemWidth);
    final height = item.data.cover.photo.height / ratio;
    String imagePath = "";
    if(ObjectUtil.isNotEmpty(item.data.coverImgGif)) {
      imagePath = item.data.coverImgGif;
    }else if(ObjectUtil.isNotEmpty(item.data.cover.photo.imagePath)) {
      imagePath = item.data.cover.photo.imagePath;
    }
    return Card(
      child: Column(
        children: [
           FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imagePath,
            height: height,
             fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Column(
              children: [
                Text(item.data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(right: 10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(item.data.user.avatar)
                      ),
                    ),
                    LimitedBox(
                      maxWidth: 100,
                      child: Text(
                        item.data.user.nick,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

