import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoPlay;

  const VideoItem({
    Key? key,
    required this.videoPlayerController,
    required this.looping,
    required this.autoPlay,
  }) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  ChewieController? chewieController;

  void _initPlayer() async {
    await widget.videoPlayerController.initialize();
    setState(() {
      chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        allowFullScreen: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: false,
        allowedScreenSleep: false,
        showOptions: false,
        showControls: true,
        showControlsOnInitialize: true,
        autoInitialize: false,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    widget.videoPlayerController.dispose();
    chewieController?.pause();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chewieController == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Chewie(
                controller: chewieController!,
              ),
            ),
          );
  }
}
