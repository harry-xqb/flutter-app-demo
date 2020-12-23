import 'dart:async';


Function debounce(
    Function func, [
      int delay = 200
    ]) {
  Timer timer;
  Function target = (Map<String, dynamic> params) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: delay), () {
      func?.call(params);
    });
  };
  return target;
}