// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:vaccinemgmt/models/comment_model.dart';
// import 'package:vaccinemgmt/models/post_model.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class ViewPostScreen extends StatefulWidget {
//   final Post post;

//   ViewPostScreen({this.post});

//   @override
//   _ViewPostScreenState createState() => _ViewPostScreenState();
// }

// class _ViewPostScreenState extends State<ViewPostScreen> {
//   bool loading = false;
//   Future<dynamic> _getAadharData(String commentor_id, int index) async {
//     loading = false;
//     Map data = {"commentor_id": commentor_id};
//     String body = json.encode(data);
//     http.Response response = await http.post(
//         "https://a5cee1d469e8.ngrok.io/database/getaadhar",
//         headers: {"Content-Type": "application/json; charset=UTF-8"},
//         body: body);
//     // var responseBody = await response.transform(utf8.decoder).join();
//     print("Print New");
//     var responseBody = jsonDecode(response.body);
//     print("Comment Data: " + responseBody[0].toString());
//     widget.post.commentors.add(responseBody[0]["name"].toString());
//     print(widget.post.commentors[index]);

//     widget.post.image_urls.add(responseBody[0]["image_url"].toString());
//     print(widget.post.image_urls[index]);
//     setState(() {});
//   }

//   Widget _buildComment(int index) {
//     _getAadharData(widget.post.comments[index]["commentor_id"], index);
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: ListTile(
//         leading: Container(
//           width: 50.0,
//           height: 50.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 offset: Offset(0, 2),
//                 blurRadius: 6.0,
//               ),
//             ],
//           ),
//           child: CircleAvatar(
//             child: ClipOval(
//               child: Image.network(
//                 widget.post.image_urls == null
//                     ? widget.post.authorImageUrl
//                     : widget.post.image_urls[index],
//                 height: 50.0,
//                 width: 50.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         title: Text(
//           widget.post.commentors == null
//               ? widget.post.authorName
//               : widget.post.commentors[index],
//           style: TextStyle(
//             color: Colors.teal[200],
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(
//           widget.post.comments[index]["comment"],
//           style: TextStyle(
//             color: Colors.teal[200],
//           ),
//         ),
//         trailing: IconButton(
//           icon: Icon(
//             Icons.favorite_border,
//             color: Colors.teal[200],
//           ),
//           color: Colors.teal[200],
//           onPressed: () => print('Like comment'),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       body: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(top: 40.0),
//               width: double.infinity,
//               height: 600.0,
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10.0),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: <Widget>[
//                             IconButton(
//                               icon: Icon(Icons.arrow_back),
//                               iconSize: 30.0,
//                               color: Colors.teal[200],
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.8,
//                               child: ListTile(
//                                 leading: Container(
//                                   width: 50.0,
//                                   height: 50.0,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black45,
//                                         offset: Offset(0, 2),
//                                         blurRadius: 6.0,
//                                       ),
//                                     ],
//                                   ),
//                                   child: CircleAvatar(
//                                     child: ClipOval(
//                                       child: Image.network(
//                                         widget.post.authorImageUrl,
//                                         height: 50.0,
//                                         width: 50.0,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 title: Text(
//                                   widget.post.authorName,
//                                   style: TextStyle(
//                                     color: Colors.teal[200],
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   widget.post.timeAgo,
//                                   style: TextStyle(
//                                     color: Colors.teal[200],
//                                   ),
//                                 ),
//                                 trailing: IconButton(
//                                   icon: Icon(Icons.more_horiz),
//                                   color: Colors.teal[200],
//                                   onPressed: () => print('More'),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         InkWell(
//                           onDoubleTap: () => print('Like post'),
//                           child: Container(
//                             margin: EdgeInsets.all(10.0),
//                             child: Image.network(
//                               widget.post.imageUrl,
//                             ),
//                             width: double.infinity,
//                             height: 400.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black45,
//                                   offset: Offset(0, 5),
//                                   blurRadius: 8.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       IconButton(
//                                         icon: Icon(Icons.favorite_border),
//                                         color: Colors.teal[200],
//                                         iconSize: 30.0,
//                                         onPressed: () => print('Like post'),
//                                       ),
//                                       Text(
//                                         widget.post.no_likes,
//                                         style: TextStyle(
//                                           fontSize: 14.0,
//                                           color: Colors.teal[200],
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(width: 20.0),
//                                   Row(
//                                     children: <Widget>[
//                                       IconButton(
//                                         icon: Icon(Icons.chat),
//                                         color: Colors.teal[200],
//                                         iconSize: 30.0,
//                                         onPressed: () {
//                                           print('Chat');
//                                         },
//                                       ),
//                                       Text(
//                                         widget.post.no_comments,
//                                         style: TextStyle(
//                                           fontSize: 14.0,
//                                           color: Colors.teal[200],
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.bookmark_border),
//                                 color: Colors.teal[200],
//                                 iconSize: 30.0,
//                                 onPressed: () => print('Save post'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Container(
//               width: double.infinity,
//               height: 600.0,
//               decoration: BoxDecoration(
//                 color: Colors.grey[900], /////COMMENTS CARD
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30.0),
//                   topRight: Radius.circular(30.0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   for (var i = widget.post.comments.length - 1; i >= 0; i--)
//                     _buildComment(i)
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: Transform.translate(
//         offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
//         child: Container(
//           height: 100.0,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 topRight: Radius.circular(30.0),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black45,
//                   offset: Offset(0, -2),
//                   blurRadius: 6.0,
//                 ),
//               ],
//               color: Colors.grey[900]),
//           child: Padding(
//             padding: EdgeInsets.all(12.0),
//             child: TextField(
//               style: TextStyle(color: Colors.teal[200]),
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: EdgeInsets.all(20.0),
//                 hintText: 'Add a comment',
//                 hintStyle: TextStyle(color: Colors.teal[200]),
//                 prefixIcon: Container(
//                   margin: EdgeInsets.all(11.0),
//                   width: 48.0,
//                   height: 48.0,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.teal[200],
//                         offset: Offset(0, 2),
//                         blurRadius: 6.0,
//                       ),
//                     ],
//                   ),
//                   child: CircleAvatar(
//                     child: ClipOval(
//                       child: Image.network(
//                         widget.post.authorImageUrl,
//                         height: 48.0,
//                         width: 48.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 suffixIcon: Container(
//                   margin: EdgeInsets.only(right: 4.0),
//                   width: 70.0,
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     color: Colors.teal[200],
//                     onPressed: () => print('Post comment'),
//                     child: Icon(
//                       Icons.send,
//                       size: 25.0,
//                       color: Colors.grey[900],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
