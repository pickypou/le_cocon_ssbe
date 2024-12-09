import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../theme.dart';

class VideoMp4View extends StatefulWidget {
  @override
  VideoMp4ViewState createState() => VideoMp4ViewState();
}

class VideoMp4ViewState extends State<VideoMp4View> {
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
      showControls: false, // On masque les contrôles par défaut pour ajouter les nôtres
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
        title: Text(
          'Vidéo Personnalisée',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Conteneur vidéo avec dimensions ajustées
            Container(
              height: 300,
              color: Colors.transparent, // Suppression du fond noir
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9, // Ajuste la largeur
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            ),
            // Boutons de contrôle personnalisés
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.play_arrow, color:  theme.colorScheme.onSurface, size: 30),
                    onPressed: () {
                      _videoPlayerController.play();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.pause, color: theme.colorScheme.onPrimary, size: 30),
                    onPressed: () {
                      _videoPlayerController.pause();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.stop, color: theme.colorScheme.secondary, size: 30),
                    onPressed: () {
                      _videoPlayerController.seekTo(Duration.zero);
                      _videoPlayerController.pause();
                    },
                  ),
                ],
              ),
            ),
          ],
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
