import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coba/features/movie/data/model/movie_payload.dart';
import 'package:coba/features/movie/data/model/movie_response.dart';
import 'package:coba/features/movie/data/repository/movie_repository.dart';
import 'package:meta/meta.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(GetMovieListLoading()) {
    on<GetMovieListRequest>((event, emit) async {
      await getMovieList(event, emit);
    });
  }

  MovieRepository repository = MovieRepository();
  MovieResponse response = MovieResponse();
  List<MovieModel> listMovie = [];

  final int size = 20;
  int page = 1;

  FutureOr<void> getMovieList(
    GetMovieListRequest event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      event.isLoadMore
          ? await _loadmoreMovies(event, emit)
          : await _getMoviesInit(event, emit);
    } catch (e) {
      emit(GetMovieListError(errorMessage: e.toString()));
    }
  }

  Future _getMoviesInit(
    GetMovieListRequest event,
    Emitter<MovieListState> emit,
  ) async {
    emit(GetMovieListLoading());
    page = 1;

    MoviePayload payload = MoviePayload();
    payload.page = page;
    payload.size = size;

    MovieResponse data = await repository.getMovie(payload);
    response = data;
    var list = data.data ?? [];
    listMovie = list;

    if (list.isNotEmpty) page += 1;
    emit(GetMovieListLoaded());
  }

  Future _loadmoreMovies(
    GetMovieListRequest event,
    Emitter<MovieListState> emit,
  ) async {
    emit(GetMovieListLoadMoreLoading());
    MoviePayload payload = MoviePayload();
    payload.page = page;
    payload.size = size;

    MovieResponse data = await repository.getMovie(payload);
    var list = data.data ?? [];

    if (list.isNotEmpty) {
      listMovie.addAll(list);
      page += 1;
    }
    emit(GetMovieListLoaded());
  }
}
