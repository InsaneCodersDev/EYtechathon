class Post {
  String authorName;
  String authorImageUrl;
  String timeAgo;
  String imageUrl;
  String caption;
  String no_likes;
  String no_dislikes;
  String type;

  Post(
      {this.authorName,
      this.authorImageUrl,
      this.timeAgo,
      this.imageUrl,
      this.caption,
      this.no_likes,
      this.no_dislikes,
      this.type});
}

List<Post> posts = [];

final List<String> stories = [
  'assets/images/user0.jpg',
  'assets/images/user1.jpg',
  'assets/images/user2.jpg',
  'assets/images/user3.jpg',
  'assets/images/user5.png',
  'assets/images/user6.png',
  'assets/images/user7.png',
  'assets/images/user4.png',
];
