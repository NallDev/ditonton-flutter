import 'package:about/about_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_playing_series/presentation/pages/now_playing_series_page.dart';
import 'package:popular_movies/presentation/pages/popular_movies_page.dart';
import 'package:popular_series/presentation/pages/popular_series_page.dart';
import 'package:search/presentation/page/search_page.dart';
import 'package:top_rated_movies/presentation/pages/top_rated_movies_page.dart';
import 'package:watchlist/presentation/page/watchlist_movies_page.dart';

import 'package:core/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:core/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:core/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';

import 'package:now_playing_movies/presentation/pages/now_playing_movies_page.dart';


class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
        context.read<PopularMoviesBloc>().add(FetchPopularMovies());
        context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
        context.read<NowPlayingSeriesBloc>().add(FetchNowPlayingSeries());
        context.read<PopularSeriesBloc>().add(FetchPopularSeries());
        context.read<TopRatedSeriesBloc>().add(FetchTopRatedSeries());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing Movies',
                onTap: () => Navigator.pushNamed(
                    context, NowPlayingMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingMoviesError) {
                    return Text('Failed: ${state.message}');
                  } else {
                    return Text('No Data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () => Navigator.pushNamed(
                    context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularMoviesError) {
                    return Text('Failed: ${state.message}');
                  } else {
                    return Text('No Data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedMoviesError) {
                    return Text('Failed: ${state.message}');
                  } else {
                    return Text('No Data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Now Playing Series',
                onTap: () => Navigator.pushNamed(
                    context, NowPlayingSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
                builder: (context, state) {
                  if (state is NowPlayingSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingSeriesHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingSeriesError) {
                    return Text('Failed: ${state.message}');
                  } else {
                    return Text('No Data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Series',
                onTap: () => Navigator.pushNamed(
                    context, PopularSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                builder: (context, state) {
                  if (state is PopularSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularSeriesHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularSeriesError) {
                    return Text('Failed: ${state.message}');
                  } else {
                    return Text('No Data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Series',
                onTap: () => Navigator.pushNamed(
                    context, "TopRatedSeriesPage.ROUTE_NAME"),
              ),
              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedSeriesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedSeriesError) {
                    return Text('Failed: ${state.message}');
                  } else {
                    return Text('No Data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "MovieDetailPage.ROUTE_NAME",
                  arguments: {
                    'id': movie.id,
                    'isSeries': movie.isSeries,
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
