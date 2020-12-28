import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vaccinemgmt/models/post_model.dart';
import 'package:vaccinemgmt/screens/view_post_screen.dart';
import 'dart:io';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool loaded = false;
  Widget _buildPost(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        // height: 510.0,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage(posts[index].authorImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      posts[index].authorName,
                      style: TextStyle(
                        color: Colors.teal[200],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(posts[index].timeAgo,
                        style: TextStyle(
                          color: Colors.teal[200],
                        )),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.teal[200],
                      onPressed: () => print('More'),
                    ),
                  ),
                  InkWell(
                    onDoubleTap: () => print('Like post'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewPostScreen(
                            post: posts[index],
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      posts[index].imageUrl,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Text(
                      "Description: " + posts[index].caption,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  color: Colors.teal[200],
                                  iconSize: 30.0,
                                  onPressed: () => print('Like post'),
                                ),
                                Text(
                                  posts[index].no_likes,
                                  style: TextStyle(
                                    color: Colors.teal[200],
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  color: Colors.teal[200],
                                  iconSize: 30.0,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewPostScreen(
                                          post: posts[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  posts[index].no_comments,
                                  style: TextStyle(
                                    color: Colors.teal[200],
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          color: Colors.teal[200],
                          iconSize: 30.0,
                          onPressed: () => print('Save post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImmunogramPosts() async {
    posts = [];
    loaded = true;
    var httpClient = new HttpClient();
    var uri = new Uri.https('330551e5b394.ngrok.io', '/database/getposts');
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print("Refreshed");
    for (var post in jsonDecode(responseBody)) {
      posts.add(Post(
          authorName: post['username'],
          authorImageUrl: 'assets/images/post0.jpg',
          timeAgo: post['post_time'].toString(),
          imageUrl: post['image_url'],
          caption: post["caption"],
          no_likes: post["no_likes"].toString(),
          no_comments: post["comments"].length.toString()));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    loaded ? null : _getImmunogramPosts();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: RefreshIndicator(
        onRefresh: () async {
          _getImmunogramPosts();
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Immunogram',
                      style: TextStyle(
                        color: Colors.teal[200],
                        fontFamily: 'Satisfy',
                        fontSize: 32.0,
                        inherit: false,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return SizedBox(width: 10.0);
                  }
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[200],
                          // offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 60.0,
                          width: 60.0,
                          image: AssetImage(stories[index - 1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            for (var i = posts.length - 1; i >= 0; i--) _buildPost(i)
          ],
        ),
      ),
    );
  }
}
