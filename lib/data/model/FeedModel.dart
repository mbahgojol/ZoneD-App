class FeedModel {
  FeedModel({
    required this.title,
    required this.description,
    required this.voteUp,
    required this.voteDown,
    required this.id,
    required this.typeReport,
    required this.userId,
    required this.imgPosting,
    required this.userImg,
    required this.username,
    required this.location,
    required this.lat,
    required this.long,
  });

  FeedModel.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    voteUp = json['vote_up'];
    voteDown = json['vote_down'];
    id = json['id'];
    typeReport = json['type_report'];
    userId = json['user_id'];
    username = json['username'];
    imgPosting = json['img_posting'];
    userImg = json['user_img'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
  }

  late String title;
  late String description;
  late String voteUp;
  late String voteDown;
  late String id;
  late int typeReport;
  late String userId;
  late String imgPosting;
  late String userImg;
  late String username;
  late String location;
  late String lat;
  late String long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['vote_up'] = voteUp;
    map['vote_down'] = voteDown;
    map['id'] = id;
    map['type_report'] = typeReport;
    map['user_id'] = userId;
    map['username'] = username;
    map['img_posting'] = imgPosting;
    map['user_img'] = userImg;
    map['location'] = location;
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }
}
