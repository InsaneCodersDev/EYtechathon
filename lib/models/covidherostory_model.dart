import 'package:meta/meta.dart';
import 'package:vaccinemgmt/models/storyuser_model.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  // final User user;

  const Story({
    @required this.url,
    @required this.media,
    @required this.duration,
    // @required this.user,
  });
}
