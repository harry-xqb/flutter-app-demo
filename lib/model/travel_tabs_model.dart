
/// 旅拍tab模块
class TravelTabsModel {
  List<TabModel> tabs;

  TravelTabsModel({this.tabs});

  TravelTabsModel.fromJson(Map<String, dynamic> json) {
    tabs = new List<TabModel>();
    json['tabs'].forEach((v) {
      tabs.add(new TabModel.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TabModel {
  String labelName;
  String groupChannelCode;

  TabModel({this.labelName, this.groupChannelCode});

  TabModel.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}