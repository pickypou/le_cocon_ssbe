import 'package:http/http.dart' as http;

class NetworkService {
  Future<http.Response> fetchPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching PDF: $e');
    }
  }
}