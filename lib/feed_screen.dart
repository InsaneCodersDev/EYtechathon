import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/models/post_model.dart';
import 'package:vaccinemgmt/shared/videoPlayer.dart';
import 'dart:io';
import 'globals.dart' as global;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String type = "Video";

bool loaded = false;

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Widget _buildPost(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
              padding: EdgeInsets.symmetric(vertical: 6),
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
                          child: Image.network(
                            posts[index].authorImageUrl,
                            height: 50.0,
                            width: 50.0,
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
                    child: posts[index].type == "photo"
                        ? Image.network(
                            posts[index].imageUrl,
                            width: double.infinity,
                          )
                        : VideoPlayer(posts[index].imageUrl),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 2),
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
                                  icon: Icon(FontAwesomeIcons.solidThumbsUp),
                                  color: Colors.teal[200],
                                  iconSize: 20.0,
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
                                  icon: Icon(FontAwesomeIcons.solidThumbsDown),
                                  color: Colors.teal[200],
                                  iconSize: 20.0,
                                  onPressed: () {},
                                ),
                                Text(
                                  posts[index].no_dislikes,
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
    print(global.tunneldomain.substring(8));
    var uri =
        new Uri.https(global.tunneldomain.substring(8), '/database/getposts');
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print("Refreshed");

    for (var post in jsonDecode(responseBody)) {
      posts.add(Post(
          authorName: post['username'],
          authorImageUrl: post['profile_url'],
          timeAgo: post['post_time'].toString(),
          imageUrl: post['image_url'],
          caption: post["caption"],
          no_likes: post["no_likes"].toString(),
          no_dislikes: post["no_dislikes"].toString(),
          type: post["type"].toString()));

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
