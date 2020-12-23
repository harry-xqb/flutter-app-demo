
/// tab页内容
class TabPageModel {
  List<DataItem> list;
  String lastUrl;

  TabPageModel({this.list, this.lastUrl});

  TabPageModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<DataItem>();
      json['list'].forEach((v) {
        list.add(new DataItem.fromJson(v));
      });
    }
    lastUrl = json['lastUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['lastUrl'] = this.lastUrl;
    return data;
  }
}

class DataItem {
  Data data;
  String dynamicStyle;
  String dynamicAction;
  DynamicTrack dynamicTrack;

  DataItem({this.data, this.dynamicStyle, this.dynamicAction, this.dynamicTrack});

  DataItem.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    dynamicStyle = json['dynamicStyle'];
    dynamicAction = json['dynamicAction'];
    dynamicTrack = json['dynamicTrack'] != null
        ? new DynamicTrack.fromJson(json['dynamicTrack'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['dynamicStyle'] = this.dynamicStyle;
    data['dynamicAction'] = this.dynamicAction;
    if (this.dynamicTrack != null) {
      data['dynamicTrack'] = this.dynamicTrack.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  User user;
  String coverImgGif;
  int likeCount;
  Cover cover;
  int noteType;
  int userId;

  Data(
      {this.id,
        this.title,
        this.user,
        this.coverImgGif,
        this.likeCount,
        this.cover,
        this.noteType,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    coverImgGif = json['coverImgGif'];
    likeCount = json['likeCount'];
    cover = json['cover'] != null ? new Cover.fromJson(json['cover']) : null;
    noteType = json['noteType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['coverImgGif'] = this.coverImgGif;
    data['likeCount'] = this.likeCount;
    if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
    data['noteType'] = this.noteType;
    data['userId'] = this.userId;
    return data;
  }
}

class User {
  String avatar;
  String nick;

  User({this.avatar, this.nick});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nick = json['nick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['nick'] = this.nick;
    return data;
  }
}

class Cover {
  Photo photo;
  int type;
  Video video;

  Cover({this.photo, this.type, this.video});

  Cover.fromJson(Map<String, dynamic> json) {
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    type = json['type'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    data['type'] = this.type;
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Photo {
  int width;
  int id;
  int height;
  String imagePath;

  Photo({this.width, this.id, this.height, this.imagePath});

  Photo.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    id = json['id'];
    height = json['height'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['id'] = this.id;
    data['height'] = this.height;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class Video {
  int height;
  int width;
  String originPath;
  PersistentPath persistentPath;

  Video({this.height, this.width, this.originPath, this.persistentPath});

  Video.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    originPath = json['originPath'];
    persistentPath = json['persistentPath'] != null
        ? new PersistentPath.fromJson(json['persistentPath'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    data['originPath'] = this.originPath;
    if (this.persistentPath != null) {
      data['persistentPath'] = this.persistentPath.toJson();
    }
    return data;
  }
}

class PersistentPath {
  String m3u8640480;
  String vframe;
  String iphone;

  PersistentPath({this.m3u8640480, this.vframe, this.iphone});

  PersistentPath.fromJson(Map<String, dynamic> json) {
    m3u8640480 = json['m3u8_640_480'];
    vframe = json['vframe'];
    iphone = json['iphone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m3u8_640_480'] = this.m3u8640480;
    data['vframe'] = this.vframe;
    data['iphone'] = this.iphone;
    return data;
  }
}

class DynamicTrack {
  int trackEnableView;
  String trackTag;
  TrackData trackData;

  DynamicTrack({this.trackEnableView, this.trackTag, this.trackData});

  DynamicTrack.fromJson(Map<String, dynamic> json) {
    trackEnableView = json['trackEnableView'];
    trackTag = json['trackTag'];
    trackData = json['trackData'] != null
        ? new TrackData.fromJson(json['trackData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trackEnableView'] = this.trackEnableView;
    data['trackTag'] = this.trackTag;
    if (this.trackData != null) {
      data['trackData'] = this.trackData.toJson();
    }
    return data;
  }
}

class TrackData {
  int dataId;
  String dataType;
  String cpmSource;

  TrackData({this.dataId, this.dataType, this.cpmSource});

  TrackData.fromJson(Map<String, dynamic> json) {
    dataId = json['data_id'];
    dataType = json['data_type'];
    cpmSource = json['cpm_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_id'] = this.dataId;
    data['data_type'] = this.dataType;
    data['cpm_source'] = this.cpmSource;
    return data;
  }
}