import 'package:flutter/material.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    title: Text(movies[position].title),
                    subtitle: Text('Released: ' +
                        movies[position].releaseDate +
                        ' - Vote: ' +
                        movies[position].voteAverage.toString()),
                  ));
            }));
  }
}
