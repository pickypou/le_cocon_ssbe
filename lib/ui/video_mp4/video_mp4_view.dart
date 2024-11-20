import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'video_mp4_page.dart';

class VideoMp4View extends StatefulWidget {
  const VideoMp4View({Key? key}) : super(key: key);

  @override
  _VideoMp4ViewState createState() => _VideoMp4ViewState();
}

class _VideoMp4ViewState extends State<VideoMp4View> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    try {
      final videoPage = VideoMp4Page();
      final videoUrl = await videoPage.getVideoUrl();

      if (videoUrl != null) {
        _videoPlayerController = VideoPlayerController.network(videoUrl);
        await _videoPlayerController!.initialize();

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: false, // Désactive la lecture automatique
          looping: false, // Désactive la lecture en boucle
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );

        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('URL de la vidéo non disponible');
      }
    } catch (e) {
      print('Erreur lors du chargement de la vidéo : $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _chewieController != null
          ? AspectRatio(
        aspectRatio: _chewieController!.aspectRatio ?? 16 / 9,
        child: Chewie(controller: _chewieController!),
      )
          : Center(child: Text('Erreur lors du chargement de la vidéo')),
    );
  }
}