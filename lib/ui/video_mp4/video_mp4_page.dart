import 'package:firebase_storage/firebase_storage.dart';

class VideoMp4Page {
  final String videoPath = 'video/video.mp4';

  Future<String?> getVideoUrl() async {
    try {
      final ref = FirebaseStorage.instance.ref(videoPath);
      final url = await ref.getDownloadURL();
      print('URL de la vidéo récupérée : $url');
      return url;
    } catch (e) {
      print('Erreur lors de la récupération de l\'URL de la vidéo: $e');
      return null;
    }
  }
}
