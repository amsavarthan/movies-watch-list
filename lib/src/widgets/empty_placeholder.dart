import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 240),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset('assets/images/watching_movie.webp'),
              ),
              const SizedBox(height: 8),
              Text(
                'No Movies Yet!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const Text('Click on the + button to add a movie.'),
            ],
          ),
        ),
      ),
    );
  }
}
