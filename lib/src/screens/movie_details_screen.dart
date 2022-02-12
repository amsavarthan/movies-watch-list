import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/widgets/movie_details_form.dart';
import 'package:provider/provider.dart';
import 'package:movie_watch_list/src/models/movie.dart';
import 'package:movie_watch_list/src/providers/movie_provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    Key? key,
    this.movie,
  }) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(movie: movie),
      builder: (context, _) {
        return _MovieDetailsScreen(movie: movie);
      },
    );
  }
}

class _MovieDetailsScreen extends StatelessWidget {
  _MovieDetailsScreen({
    Key? key,
    this.movie,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie == null ? 'Add Movie' : 'Edit Movie'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Done',
            onPressed: () {
              final movie = context.read<MovieProvider>().movie;
              if (_formKey.currentState!.validate()) {
                if (movie.posterFilePath.isNotEmpty) {
                  Navigator.pop(context, movie);
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please choose a poster image to continue'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Wrap(
            runSpacing: 36,
            children: <Widget>[
              MovieDetailsForm(formKey: _formKey),
              const MySlider(),
              const MovieImagePicker()
            ],
          ),
        ),
      ),
    );
  }
}
