import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VideoMp4Page {
  final String videoPath = 'video/video.mp4';

  Future<String?> getVideoUrl() async {
    try {
      final ref = FirebaseStorage.instance.ref(videoPath);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'URL de la vidéo: $e');
      return null;
    }
  }
}
