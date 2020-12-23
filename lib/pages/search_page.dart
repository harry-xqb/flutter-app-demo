import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/util/debounce_util.dart';
import 'package:flutter_trip/util/tab_webview_util.dart';
import 'package:flutter_trip/widget/search_bar.dart';


const ITEM_TYPES = [
  'channelhotel',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup',
];

/// @author  Harry 
/// @date  2020/11/25 19:48
class SearchPage extends StatefulWidget {

  final bool hideLeft;

  final String defaultText;

  final String hint;

  const SearchPage({Key key, this.hideLeft = false, this.defaultText, this.hint}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchModel searchModel;

  String keyword = "";

  Function _debounceSearch;

  @override
  void initState() {
    _debounceSearch = debounce((params) {
      String keyword = params["keyword"];
      if(keyword != null && keyword.length > 0) {
        SearchDao.fetch(keyword).then((result){
          if(result.success) {
            setState(() {
              searchModel = result.data;
            });
          }
        });
      }
    }, 200);
    super.initState();
  }

  void search(keyword) {
    Map<String, dynamic> map = new HashMap();
    map.putIfAbsent("keyword", () => keyword);
    _debounceSearch(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
                flex: 1,
                child:  ListView.builder(
                    itemCount: searchModel?.data?.length ?? 0,
                    itemBuilder: (context, index) => _item(index)
                )
            ))
        ],
      ),
    );
  }


  _handleTextChange(String text) {
    keyword = text;
    if(text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    this.search(text);

  }

  get _appBar {
    return  Column(
      children: [
        Container(
          height: 70,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: SearchBar(
            hideLeft: widget.hideLeft,
            defaultText: widget.defaultText,
            hint: widget.hint,
            onChange: _handleTextChange,
          ),
        ),
        Container(
          height: 0.5,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget _item(int position) {
    SearchItemModel searchItemModel = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        CommonModel commonModel = new CommonModel(
          url: searchItemModel.url,
          title: searchItemModel.word,
        );
        WebViewTabUtil.navigateTo(context, commonModel);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Image(image: AssetImage(_typeImage(searchItemModel.type)), width: 26, height: 26),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    child: _buildItemWord(searchItemModel, keyword),
                  ),
                  Text(searchItemModel.districtname ?? "", style: TextStyle(color: Colors.grey))
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  RichText _buildItemWord(SearchItemModel item, String keyword) {
    List<TextSpan> spans = [];
    spans.addAll(_getWordWrap(item, keyword));
    return RichText(text: TextSpan(children: spans));
  }

  List<TextSpan> _getWordWrap(SearchItemModel item, String keyword) {
    List<TextSpan> spanList = [];
    if(item.word == null || item.word.length == 0) {
      return spanList;
    }
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    List<String> splitArray = item.word.split(keyword);
    // wordwoc.split("w") => [ , ord, oc]
    // ordwoc.split("w") => [org, oc]
    // ordow2w.split("w") => [org, 2, ""]
    // wordo2w.split("w") => ["", org2, ""]
    for(int i = 0; i < splitArray.length; i++) {
      String val = splitArray[i];
      if((i + 1) % 2 == 0) {
        spanList.add(TextSpan(text: keyword, style: keywordStyle));
      }
      if(val != null && val.length > 0) {
        spanList.add(TextSpan(text: val, style: normalStyle));
      }
    }
    // 如果首位都存在keyword，则需要往尾部补充一个keyword
    if(splitArray[splitArray.length - 1].isEmpty && splitArray.length % 2 != 0) {
      spanList.add(TextSpan(text: keyword, style: keywordStyle));
    }
    return spanList;
  }

  _typeImage(String type) {
    String imgType = "channelgroup";
    print(type);
    for(int i = 0; i < ITEM_TYPES.length; i++) {
      if(ITEM_TYPES[i] == type) {
        imgType = type;
        break;
      }
    }
    return "assets/images/${imgType}.png";
  }
}