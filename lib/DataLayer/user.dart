class User {
  final String name;
  final String zomatoHandle;
  final String profileUrl;
  final String profileImage;

  User.fromJson(json)
      : name = json['name'].toString(),
        zomatoHandle = json['zomato_handle'].toString(),
        profileUrl = json['profile_url'].toString(),
        profileImage = json['profile_image'].toString();
}
