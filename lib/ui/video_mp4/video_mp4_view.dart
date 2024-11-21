import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoMp4View extends StatefulWidget {
  @override
  _VideoMp4ViewState createState() => _VideoMp4ViewState();
}

class _VideoMp4ViewState extends State<VideoMp4View> {
  late VideoPlayerController _controller;
  bool _isFullScreen = false; // Flag pour gérer le plein écran

  final String videoUrl =
      "https://firebasestorage.googleapis.com/v0/b/le-cocon-ssbe-6a4d0.appspot.com/o/video%2Fvideo.mp4?alt=media&token=154c579d-52cb-48d2-a133-a0fdde7bbe68";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Vidéo
            if (_controller.value.isInitialized)
              SizedBox(
                height: 400, // Hauteur maximale de la vidéo
                width: 450, // Largeur maximale (ajustable si nécessaire)
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            else
              CircularProgressIndicator(),

            SizedBox(height: 5),

            // Boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Passer en plein écran ou revenir à la taille normale
                      _isFullScreen = !_isFullScreen;
                    });
                  },
                  child: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isFullScreen
          ? null
          : BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Vidéo en cours",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
    );
  }
}
