import 'dart:io';

class MoviePayload {
  int? size;
  int? page;
  String? title;
  String? description;
  File? poster;

  MoviePayload({
    this.size,
    this.page,
    this.title,
    this.description,
    this.poster,
  });

  factory MoviePayload.fromJson(Map<String, dynamic> json) => MoviePayload(
        size: json["size"],
        page: json["page"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "page": page,
        "title": title,
        "description": description,
      };

  Map<String, dynamic> toJsonPaging() => {
        "size": size,
        "page": page,
      };
}
