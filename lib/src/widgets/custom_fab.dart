import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/models/movie.dart';
import 'package:movie_watch_list/src/providers/movie_list_provider.dart';
import 'package:movie_watch_list/src/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    Key? key,
  }) : super(key: key);

  static const double fabSize = 56;

  @override
  Widget build(BuildContext context) {
    const circleFabBorder = CircleBorder();

    return OpenContainer<Movie>(
      openBuilder: (context, action) => const MovieDetailsScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      closedColor: Theme.of(context).floatingActionButtonTheme.backgroundColor!,
      closedShape: circleFabBorder,
      closedElevation: 10,
      onClosed: (result) {
        if (result == null) return;
        context.read<MoviesListProvier>().addItem(result);
      },
      closedBuilder: (context, openContainer) => Tooltip(
        message: 'Add Movie',
        child: InkWell(
          customBorder: circleFabBorder,
          onTap: openContainer,
          child: const SizedBox(
            height: fabSize,
            width: fabSize,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
