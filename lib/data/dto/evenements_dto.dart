class EvenementDto {
  final String id;
  final String title;
  final String fileUrl;
  final String fileType;
  final DateTime publishDate;

  EvenementDto({required this.id, required this.title, required this.fileUrl, required this.fileType, required this.publishDate});

  factory EvenementDto.fromJson(Map<String, dynamic> json) {
    return EvenementDto(
        id: json['id'],
        title: json['title'],
        fileUrl:json['fileUrl'],
        fileType: json['fileType'],
        publishDate: json['publishDate']
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'title': title,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'publishDate': publishDate.toIso8601String(),
    };
  }
  @override
  String toString() {
    return 'EvenementDto{id: $id, title: $title, fileUrl: $fileUrl, fileType: $fileType, publishDate: $publishDate}';
  }
}