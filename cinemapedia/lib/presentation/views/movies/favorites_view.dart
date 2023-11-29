import 'package:cinemapedia/presentation/providers/provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesFavorites = ref.watch(favoriteMoviesProvider).values.toList();

    if (moviesFavorites.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border,size: 50,color: colors.primary,),
            Text('Aun no tienes',style: TextStyle(fontSize: 30,color: colors.primary),),
            const Text('Peliculas favoritas',style: TextStyle(fontSize: 20,color: Colors.black54),),
            const SizedBox(height: 20,),
            FilledButton.tonal(
              onPressed:() =>  context.go('/home/0'),
              child: const Text('Agrega a favoritos'))
          ],
        ),
      );
    }

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Favorites'),
        // ),
        body: MovieMansory(
      movies: moviesFavorites,
      loadNextPage: loadNextPage,
    ));
  }
}
