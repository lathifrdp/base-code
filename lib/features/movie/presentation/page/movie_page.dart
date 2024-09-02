import 'package:cached_network_image/cached_network_image.dart';
import 'package:coba/core/common/assets.dart';
import 'package:coba/core/common/logger.dart';
import 'package:coba/core/theme/style.dart';
import 'package:coba/features/movie/bloc/movie_list/movie_list_bloc.dart';
import 'package:coba/features/movie/presentation/widget/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _scrollController = ScrollController();
  late MovieListBloc bloc;

  @override
  void initState() {
    bloc = MovieListBloc();
    bloc.add(GetMovieListRequest());
    super.initState();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      Logger.print('LOADMORE');
      bloc.add(GetMovieListRequest(isLoadMore: true));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        title: Text(
          'Movies',
          style: TextStyle(color: Styles().color.primary),
        ),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetMovieListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetMovieListError) {
            return Center(child: Text(state.errorMessage ?? "-"));
          }

          return buildList(context, state);
        },
      ),
    );
  }

  Widget buildList(BuildContext context, Object? state) {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(GetMovieListRequest());
      },
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          return _handleScrollNotification(notification);
        },
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            CachedNetworkImage(
              height: 200,
              imageUrl:
                  'https://image.tmdb.org/t/p/original/5ScPNT6fHtfYJeWBajZciPV3hEL.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              placeholder: (context, url) => Image.asset(
                Assets.placeholderWide,
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => Image.asset(
                Assets.placeholderWide,
                fit: BoxFit.fill,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Popular Movies',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                color: Styles().color.divider,
                thickness: 6,
              ),
              itemCount: bloc.listMovie.length,
              itemBuilder: (context, index) {
                var data = bloc.listMovie[index];

                return MovieItem(
                  index: index,
                  title: data.title ?? '-',
                  desc: data.description ?? '-',
                  date: data.createdDate,
                  imageUrl: data.poster ?? '-',
                  onTap: () {
                    //nav ke detail
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
