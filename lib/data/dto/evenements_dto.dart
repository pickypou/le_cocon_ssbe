class EvenementDto {
  final String id;
  final String title;
  final String fileUrl;
  final String fileType;
  final DateTime publishDate;
  final String? thumbnailUrl; // Ajout du champ thumbnailUrl

  EvenementDto({
    required this.id,
    required this.title,
    required this.fileUrl,
    required this.fileType,
    required this.publishDate,
    this.thumbnailUrl, // Ajout du paramètre thumbnailUrl
  });

  factory EvenementDto.fromJson(Map<String, dynamic> json) {
    return EvenementDto(
      id: json['id'],
      title: json['title'],
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
      publishDate: DateTime.parse(json['publishDate']),
      thumbnailUrl: json['thumbnailUrl'], // Récupération de thumbnailUrl
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'publishDate': publishDate.toIso8601String(),
      'thumbnailUrl': thumbnailUrl, // Ajout de thumbnailUrl
    };
  }

  @override
  String toString() {
    return 'EvenementDto{id: $id, title: $title, fileUrl: $fileUrl, fileType: $fileType, publishDate: $publishDate, thumbnailUrl: $thumbnailUrl}';
  }
}
