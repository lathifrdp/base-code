import 'package:coba/features/movie/presentation/page/movie_page.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String moviePage = '/';
}

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.moviePage: (context) => const MoviePage(),
};
