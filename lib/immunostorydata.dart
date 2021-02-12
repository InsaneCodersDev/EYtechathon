import 'package:vaccinemgmt/models/immunostory_model.dart';
import 'package:vaccinemgmt/models/storyuser_model.dart';

final User user = User(
  name: '',
  profileImageUrl: '',
);
final List<Story> stories = [
  Story(
    url:
        'https://firebasestorage.googleapis.com/v0/b/eytechathon-insanecoders.appspot.com/o/POLIO.mp4?alt=media&token=bb239436-2ae1-4114-8936-d06dfa0fb441',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    // user: user,
  ),
  Story(
    url:
        'https://firebasestorage.googleapis.com/v0/b/eytechathon-insanecoders.appspot.com/o/SMALLPOX.mp4?alt=media&token=c41bb997-9067-45ab-a270-03947facd6fa',
    media: MediaType.video,
    // user: User(
    //   name: 'John Doe',
    //   profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
    // ),
    duration: const Duration(seconds: 0),
  ),
  // Story(
  //   url:
  //       'https://firebasestorage.googleapis.com/v0/b/eytechathon-insanecoders.appspot.com/o/3immunohistory.mp4?alt=media&token=6c3ea974-1754-4155-bc60-d5fc9db8978a',
  //   media: MediaType.video,
  //   duration: const Duration(seconds: 10),
  //   user: user,
  // ),
  // Story(
  //   url:
  //       'https://firebasestorage.googleapis.com/v0/b/eytechathon-insanecoders.appspot.com/o/3immunohistory.mp4?alt=media&token=689a6bc7-a2ad-4ecf-b04e-5b7b55c19341',
  //   media: MediaType.video,
  //   duration: const Duration(seconds: 10),
  //   user: user,
  // ),
  // Story(
  //   url:
  //       'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
  //   media: MediaType.video,
  //   duration: const Duration(seconds: 0),
  //   user: user,
  // ),
];
