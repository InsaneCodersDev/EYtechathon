import 'package:vaccinemgmt/models/comment_model.dart';

class Post {
  String authorName;
  String authorImageUrl;
  String timeAgo;
  String imageUrl;
  String caption;
  String no_likes;
  String no_dislikes;

  Post({
    this.authorName,
    this.authorImageUrl,
    this.timeAgo,
    this.imageUrl,
    this.caption,
    this.no_likes,
    this.no_dislikes,
  });
}

List<Post> posts = [];

final List<String> stories = [
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
  'assets/images/user4.png',
  'assets/images/user0.png',
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
];