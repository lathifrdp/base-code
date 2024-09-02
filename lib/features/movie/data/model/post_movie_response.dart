class PostMovieResponse {
  String? status;
  String? data;
  String? info;

  PostMovieResponse({
    this.status,
    this.data,
    this.info,
  });

  factory PostMovieResponse.fromJson(Map<String, dynamic> json) =>
      PostMovieResponse(
        status: json["status"],
        data: json["data"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "info": info,
      };
}
