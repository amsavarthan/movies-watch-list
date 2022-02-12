import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_watch_list/src/providers/movie_provider.dart';

class MovieDetailsForm extends StatelessWidget {
  const MovieDetailsForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieProvider>();
    final movie = provider.movie;
    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 16,
        children: <Widget>[
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: movie.name,
            keyboardType: TextInputType.text,
            onChanged: (value) => provider.updateMovie(name: value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a movie name';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Movie Name',
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: movie.directorName,
            keyboardType: TextInputType.name,
            onChanged: (value) => provider.updateMovie(directorName: value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the director\'s name';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Director Name',
            ),
          ),
        ],
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  const MySlider({
    Key? key,
  }) : super(key: key);

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _value = context.read<MovieProvider>().movie.lovedPercentage.toDouble();
    });
    final provider = context.read<MovieProvider>();
    final movie = provider.movie;
    return Wrap(
      runSpacing: 30,
      children: <Widget>[
        const Text(
          'How much did you liked the movie?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Slider(
          label: movie.lovedPercentage.toString(),
          value: _value,
          divisions: 10,
          onChanged: (value) {
            setState(() => _value = value);
            provider.updateMovie(lovedPercentage: value.toInt());
          },
          min: 0,
          max: 100,
        ),
      ],
    );
  }
}

class MovieImagePicker extends StatelessWidget {
  const MovieImagePicker({
    Key? key,
  }) : super(key: key);

  void openFilePicker(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Choose poster image',
      type: FileType.image,
    );
    if (result == null) return;
    final path = result.files.single.path ?? '';
    context.read<MovieProvider>().updateMovie(posterFilePath: path);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 26,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: context.watch<MovieProvider>().movie.posterFilePath.isEmpty
                  ? ElevatedButton(
                      onPressed: () => openFilePicker(context),
                      child: const Text("Choose a poster image"),
                    )
                  : OutlinedButton(
                      onPressed: () => openFilePicker(context),
                      child: const Text("Change poster image"),
                    ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 48),
          child: Visibility(
            visible:
                context.watch<MovieProvider>().movie.posterFilePath.isNotEmpty,
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              context
                                  .watch<MovieProvider>()
                                  .movie
                                  .posterFilePath,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            tooltip: 'Remove poster image',
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            onPressed: () => context
                                .read<MovieProvider>()
                                .updateMovie(posterFilePath: ''),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
