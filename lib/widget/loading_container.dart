import 'package:flutter/material.dart';

/// @author  Harry 
/// @date  2020/11/30 15:33
class LoadingContainer extends StatelessWidget {

  final bool loading;
  final bool cover;
  final Widget child;

  const LoadingContainer({Key key, this.loading, this.cover = true, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(cover) {
      return loading ? _loadingView : child;
    }
    return Stack(
      children: [
        child,
        loading ? _loadingView : Container()
      ],
    );
  }
  Widget get _loadingView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
