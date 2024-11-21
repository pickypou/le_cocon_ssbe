import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoMp4View extends StatefulWidget {
  @override
  _VideoMp4ViewState createState() => _VideoMp4ViewState();
}

class _VideoMp4ViewState extends State<VideoMp4View> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  final String videoUrl =
      "https://firebasestorage.googleapis.com/v0/b/le-cocon-ssbe-6a4d0.appspot.com/o/video%2Fvideo.mp4?alt=media&token=154c579d-52cb-48d2-a133-a0fdde7bbe68";

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
      placeholder: Center(child: CircularProgressIndicator()),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Une petite vidéo avec la participation de non adhérant', style: textStyleText(context),),
      ),
      body: Center(
        child: _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? Theme(
          data: Theme.of(context).copyWith(
            platform: TargetPlatform.iOS, // Utilise le style iOS qui n'a pas d'effet de focus visible
          ),
          child: Chewie(
            controller: _chewieController!,
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Chargement de la vidéo...'),
          ],
        ),
      ),
    );
  }
}