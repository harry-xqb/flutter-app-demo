class SearchModel {

  List<SearchItemModel> data;

  SearchModel({this.data});

  factory SearchModel.fromJson(List<dynamic> jsonList) {
    List<SearchItemModel> listData = jsonList.map((json) => SearchItemModel.fromJson(json)).toList();
    return SearchModel(data: listData);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class SearchItemModel {
  String word;
  String type;
  String districtname;
  String url;

  SearchItemModel({this.word, this.type, this.districtname, this.url});

  SearchItemModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    type = json['type'];
    districtname = json['districtname'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['type'] = this.type;
    data['districtname'] = this.districtname;
    data['url'] = this.url;
    return data;
  }
}