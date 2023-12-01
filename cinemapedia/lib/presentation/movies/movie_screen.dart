import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(
                        movie: movie,
                      ),
                  childCount: 1))
        ],
      ),
      // body: Center(
      //   child: Text(movieId),
      // ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //         padding: const EdgeInsets.all(8),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             ClipRRect(
    //               borderRadius: BorderRadius.circular(20),
    //               child: Image.network(movie.posterPath,
    //                   width: size.width * 0.3, fit: BoxFit.cover),
    //             ),
    //             SizedBox(
    //               width: (size.width - 40) * 0.7,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 10, top: 5),
    //                     child: Text(
    //                       movie.title,
    //                       style: textStyle.titleLarge,
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text(
    //                       movie.overview,
    //                       style: textStyle.bodySmall,
    //                       textAlign: TextAlign.start,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ],
    //         )),
    //     Padding(
    //       padding: const EdgeInsets.all(8),
    //       child: Wrap(
    //         children: [
    //           ...movie.genreIds.map((gender) => Container(
    //                 margin: const EdgeInsets.only(right: 10),
    //                 child: Chip(
    //                   label: Text(gender),
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(20)),
    //                 ),
    //               ))
    //         ],
    //       ),
    //     ),
    //     _ActorsByMovie(movieId: movie.id.toString()),
    //     const SizedBox(
    //       height: 40,
    //     )
    //   ],
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleAndOverview(movie: movie, textStyle: textStyle, size:size ,),
        _Genres(movie: movie,),
        _ActorsByMovie(movieId: movie.id.toString())
      ],
    );
  }
}

class _Genres extends StatelessWidget {
  final Movie movie;

  const _Genres({
     required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map((gender) => Container(
              margin: const EdgeInsets.only( right: 10),
              child: Chip(
                label: Text( gender ),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  final Movie movie;
  final Size size;
  final TextTheme textStyle;

  const _TitleAndOverview({
    required this.movie, required this.size, required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
              ),
          ),

          const SizedBox(width: 10,),

          // Description

        SizedBox(
          width: (size.width - 40) * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title,style: textStyle.titleLarge,),
              Text(movie.overview),
              const SizedBox(height: 10,),
              MovieRating(voteAverage: movie.voteAverage),

              // Row(
              //   children: [
              //     const Text('Estreno:',style: TextStyle(fontWeight: FontWeight.bold),),
              //     const SizedBox(width: 5,),
              //     // Text(HumanFormats.shortDate(movie.releaseDate))
              //   ],
              // )
            ],
          ),
        )
        ],
      ), 
      );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      fit: BoxFit.cover,
                      width: 135,
                      height: 180,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) return const SizedBox();
                        return FadeInDown(child: child);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () async {
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              // .watch(localStorageRepositoryProvider)
              // .toogleFavorite(movie);
              // await Future.delayed(const Duration(milliseconds: 100));
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
                data: (isFavorite) => isFavorite
                    ? const Icon(Icons.favorite_outlined, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                error: (_, __) => throw UnimplementedError(),
                loading: () => const CircularProgressIndicator(strokeWidth: 2)))
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
          const _CustomGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.3],
            colors: [Colors.black54, Colors.transparent],
          ),
          const _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.8, 1.0],
            colors: [Colors.transparent, Colors.black54],
          ),
          const _CustomGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.4],
            colors: [Colors.black54, Colors.transparent],
          )
        ]),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {required this.begin,
      required this.end,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: begin, end: end, stops: stops, colors: colors))));
  }
}
