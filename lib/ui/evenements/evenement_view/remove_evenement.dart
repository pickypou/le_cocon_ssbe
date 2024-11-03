import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> deleteThumbnail() async {
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/thumbnail.png';

  try {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    debugPrint("Erreur lors de la suppression de la miniature : $e");
  }
}
