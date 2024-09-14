import 'package:core/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movies';

  @override
  _NowPlayingMoviesPageState createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if(mounted) {
        context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          builder: (context, state) {
            if (state is NowPlayingMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingMoviesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Text('No Data');
            }
          },
        ),
      ),
    );
  }
}
