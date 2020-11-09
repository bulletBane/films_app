import 'package:flutter/material.dart';
import 'package:http_films_app/movie_detail.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  String result;
  HttpHelper helper;
  int moviesCount;
  List movies;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (BuildContext context, int position) {
              if (movies[position].posterPath != null) {
                image = NetworkImage(iconBase + movies[position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => MovieDetail(movies[position]));

                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies[position].title),
                    subtitle: Text('Released: ' +
                        movies[position].releaseDate +
                        ' - Vote: ' +
                        movies[position].voteAverage.toString()),
                  ));
            }));
  }
}
