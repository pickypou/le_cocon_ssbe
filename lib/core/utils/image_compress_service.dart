import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressService {
  // Fonction pour compresser des images de type XFile ou File
  static Future<List<File?>> compressImages(List<XFile> images) async {
    List<File?> compressedImages = [];

    for (var image in images) {
      // Convertir XFile en File
      File file = File(image.path);

      final String filePath = file.absolute.path;

      // Générer un chemin de sortie
      final String outPath = '${filePath.substring(0, filePath.lastIndexOf('/'))}/compressed_${filePath.split('/').last}';

      // Compresser l'image
      var compressedImage = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, // Chemin de l'image d'origine
        outPath, // Chemin où l'image compressée sera sauvegardée
        quality: 85, // Qualité de compression
      );

      compressedImages.add(compressedImage as File?);
    }

    return compressedImages;
  }
}
