import 'package:coba/core/client/client.dart';
import 'package:coba/core/common/endpoint.dart';
import 'package:coba/features/movie/data/model/movie_payload.dart';
import 'package:coba/features/movie/data/model/movie_response.dart';
import 'package:coba/features/movie/data/model/post_movie_response.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class MovieRepository {
  Dio dio = Client().dio;
  late Response response;

  //Get Movie
  Future<MovieResponse> getMovie(MoviePayload payload) async {
    try {
      response = await dio.get(
        Endpoint.movie,
        queryParameters: payload.toJsonPaging(),
      );
      var responseData = response.data;
      MovieResponse result = MovieResponse.fromJson(responseData);
      return result;
    } on DioException catch (e) {
      throw e.message ?? "-";
    }
  }

  //Post Movie
  Future<PostMovieResponse> postMovie(MoviePayload payload) async {
    try {
      if (payload.poster == null) {
        FormData formData = FormData.fromMap(
            {"title": payload.title, "description": payload.description});
        response = await dio.post(Endpoint.movie, data: formData);
        var responseData = response.data;
        PostMovieResponse result = PostMovieResponse.fromJson(responseData);
        return result;
      } else {
        var fileName = basename(payload.poster!.path);
        FormData formData = FormData.fromMap({
          "title": payload.title,
          "description": payload.description,
          "poster": await MultipartFile.fromFile(payload.poster!.path,
              filename: fileName)
        });

        response = await dio.post(
          Endpoint.movie,
          data: formData,
        );
        var responseData = response.data;
        PostMovieResponse result = PostMovieResponse.fromJson(responseData);
        return result;
      }
    } on DioException catch (e) {
      throw e.message ?? "-";
    }
  }
}
