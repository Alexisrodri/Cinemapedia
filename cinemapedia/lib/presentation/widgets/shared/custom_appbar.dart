import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/delegates/search_movies_delegate.dart';
import 'package:cinemapedia/presentation/providers/provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final textsStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_filter_outlined, color: colors.primary),
            const SizedBox(width: 5),
            Text(
              'Cinemapedia',
              style: textsStyle,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  final movieRepository = ref.read(movieRepositoryProvider);
                  showSearch(
                      context: context,
                      delegate: SearchMovieDelegate(
                          searchMovies: movieRepository.searchMovies));
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
