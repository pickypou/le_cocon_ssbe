// lib/services/network_service.dart
import 'package:http/http.dart' as http;

class NetworkService {
  // Définition de la méthode fetchPdf pour effectuer une requête HTTP GET
  Future<http.Response> fetchPdf(String url) async {
    final uri = Uri.parse(url); // Utilisez Uri.https si nécessaire
    return await http.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
    });
  }
}
