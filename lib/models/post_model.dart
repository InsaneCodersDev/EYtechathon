class Post {
  String authorName;
  String authorImageUrl;
  String timeAgo;
  String imageUrl;

  Post({
    this.authorName,
    this.authorImageUrl,
    this.timeAgo,
    this.imageUrl,
  });
}

final List<Post> posts = [
  Post(
    authorName: 'Janhavi Zarapkar',
    authorImageUrl: 'assets/images/post0.jpg',
    timeAgo: '5 min',
    imageUrl: 'assets/images/post0.jpg',
  ),
  // Post(
  //   authorName: 'Janhavi Zarapkar',
  //   authorImageUrl: 'assets/images/post1.jpg',
  //   timeAgo: '10 min',
  //   imageUrl: 'assets/images/post1.jpg',
  // ),
  Post(
    authorName: 'Mohnish Nathani',
    authorImageUrl: 'assets/images/post2.jpg',
    timeAgo: '10 min',
    imageUrl: 'assets/images/post2.jpg',
  ),
  Post(
    authorName: 'Girish Salunke',
    authorImageUrl: 'assets/images/post3.jpg',
    timeAgo: '10 min',
    imageUrl: 'assets/images/post3.jpg',
  ),
  Post(
    authorName: 'Oveshahmed Patel',
    authorImageUrl: 'assets/images/post4.jpg',
    timeAgo: '10 min',
    imageUrl: 'assets/images/post4.jpg',
  ),
];

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
