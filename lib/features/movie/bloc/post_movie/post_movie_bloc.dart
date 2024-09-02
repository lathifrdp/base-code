import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_movie_event.dart';
part 'post_movie_state.dart';

class PostMovieBloc extends Bloc<PostMovieEvent, PostMovieState> {
  PostMovieBloc() : super(PostMovieInitial()) {
    on<PostMovieEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
