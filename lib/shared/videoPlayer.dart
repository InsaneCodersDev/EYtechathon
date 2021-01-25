import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';

VideoPlayerController _controller;

class VideoPlayer extends StatefulWidget {
  String videourl;
  VideoPlayer(String videourl);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  Future<void> _initializeVideoPlayerFuture;
  void initState() {
    _controller = VideoPlayerController.network(widget.videourl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mutes the video
      _controller.setVolume(0.0);

      // Plays the video once the widget is build and loaded.
      _controller.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
              child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: BetterPlayer.network(
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
              betterPlayerConfiguration: BetterPlayerConfiguration(
                aspectRatio: 1 / 1,
              ),
            ),
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
