import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoPlayerPage extends StatefulWidget {
  final String videoId;
  final String title;

  const CourseVideoPlayerPage({super.key, required this.videoId, required this.title});

  @override
  State<CourseVideoPlayerPage> createState() => _CourseVideoPlayerPageState();
}

class _CourseVideoPlayerPageState extends State<CourseVideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
