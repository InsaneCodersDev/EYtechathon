import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

VideoPlayerController _controller;
YoutubePlayerController _ycontroller;

class VideoPlayer extends StatefulWidget {
  String videourl;
  String type;
  VideoPlayer(this.videourl, this.type);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  Future<void> _initializeVideoPlayerFuture;
  void initState() {
    _controller = VideoPlayerController.network(widget.videourl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    _ycontroller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videourl),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mutes the video
      _controller.setVolume(1.0);

      // Plays the video once the widget is build and loaded.
      _controller.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("Type: " + widget.type);
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: widget.type.compareTo("youtube") == 0
            ? YoutubePlayer(
                controller: _ycontroller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.teal,
                  handleColor: Colors.teal[200],
                ),
              )
            : BetterPlayer.network(
                widget.videourl,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                ),
              ),
      ),
    );
  }
}
