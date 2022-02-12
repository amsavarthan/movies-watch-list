import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/providers/movie_list_provider.dart';
import 'package:movie_watch_list/src/services/firebase_service.dart';
import 'package:movie_watch_list/src/widgets/custom_fab.dart';
import 'package:movie_watch_list/src/widgets/empty_placeholder.dart';
import 'package:movie_watch_list/src/widgets/movies_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = context.watch<MoviesListProvier>().movies;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies List"),
        actions: [
          IconButton(
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure do you want to logout?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Logout'),
                    )
                  ],
                ),
              );
              if (ok == null || !ok) return;
              FirebaseService.signOutFromGoogle();
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          )
        ],
      ),
      body: movies.isEmpty ? const EmptyPlaceholder() : const MoviesList(),
      floatingActionButton: const CustomFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
