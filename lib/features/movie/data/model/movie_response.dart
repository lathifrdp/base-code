class MovieResponse {
  String? status;
  List<MovieModel>? data;
  dynamic info;

  MovieResponse({
    this.status,
    this.data,
    this.info,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MovieModel>.from(
                json["data"]!.map((x) => MovieModel.fromJson(x))),
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "info": info,
      };
}

class MovieModel {
  int? id;
  String? title;
  String? description;
  String? poster;
  DateTime? createdDate;

  MovieModel({
    this.id,
    this.title,
    this.description,
    this.poster,
    this.createdDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        poster: json["poster"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "poster": poster,
        "created_date": createdDate?.toIso8601String(),
      };
}
