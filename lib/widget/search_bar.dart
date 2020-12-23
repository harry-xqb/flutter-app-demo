import 'package:flutter/material.dart';


enum SearchBarMode {home, normal, homeLight}

/// @author  Harry 
/// @date  2020/11/30 19:26
class SearchBar extends StatefulWidget {

  final SearchBarMode searchBarMode;

  final bool hideLeft;

  final String defaultText;

  final String hint;

  final Function(String) onChange;

  final Function inputBoxClick;

  final Function speakClick;

  final Function leftButtonClick;

  const SearchBar({Key key,
    this.searchBarMode = SearchBarMode.normal,
    this.defaultText,
    this.hint,
    this.onChange,
    this.inputBoxClick,
    this.speakClick,
    this.leftButtonClick,
    this.hideLeft = true
  }) : super(key: key);


  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  TextEditingController _controller = new TextEditingController();

  bool hasValue = false;

  @override
  Widget build(BuildContext context) {
    return buildSearchBar(context);
  }

  Widget buildSearchBar(BuildContext context) {
    if(widget.searchBarMode == SearchBarMode.normal || widget.searchBarMode == null) {
      return _buildNormalSearchBar();
    }
    return _buildHomeSearchBar(context);
  }

  Widget _buildHomeSearchBar(BuildContext context) {
    bool isLight =  (widget.searchBarMode == SearchBarMode.homeLight);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              child: Text('上海', style: TextStyle(color: isLight ? Colors.grey : Colors.white, fontSize: 18)),
            ),
            GestureDetector(
              onTap: () {
                if(widget.leftButtonClick != null) {
                  widget.leftButtonClick();
                }
              },
              child: Icon(Icons.keyboard_arrow_down, color: isLight ? Colors.grey : Colors.white, size: 25,)
            )
          ],
        ),
        Expanded(
          child: Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 7),
            margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.search, size: 20, color: Colors.blue),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if(widget.inputBoxClick != null) {
                        widget.inputBoxClick();
                      }
                    },
                    child: Text(widget.hint, style: TextStyle(color: Colors.grey)),
                  )
                ),
                GestureDetector(
                  onTap: () {
                    if(widget.speakClick != null) {
                      widget.speakClick();
                    }
                  },
                  child:  Icon(Icons.mic, color: Colors.grey,),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.comment, color: isLight ? Colors.grey : Colors.white, size: 20),
        )
      ],
    );
  }

  Widget _buildNormalSearchBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: widget.hideLeft ? null :  Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.search, size: 20, color: Colors.grey,),
                ),
                _inputBox,
                _getTrailingIcon()
              ],
            ),
          ),
        )
        ,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('搜索', style: TextStyle(color: Colors.blue)),
        )
      ],
    );
  }

  Widget _getTrailingIcon() {
    if(hasValue) {
      return GestureDetector(
        onTap: () {
          _controller.clear();
          setState(() {
            hasValue = false;
          });
          if(widget.onChange != null) {
            widget.onChange("");
          }
        },
        child: Icon(Icons.close, color: Colors.grey,),
      );
    }
    return Icon(Icons.mic, color: Colors.blue);
  }

  Widget get _inputBox{
    return Expanded(
        child: TextField(
            autofocus: true,
            controller: _controller,
            onChanged: (value) {
              setState(() {
                hasValue = value.isNotEmpty;
              });
              if(widget.onChange != null) {
                widget.onChange(value);
              }
            },
            decoration: InputDecoration(
              hintText: '输入',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 3),
              isDense: true,
            )
        )
    );
  }
}