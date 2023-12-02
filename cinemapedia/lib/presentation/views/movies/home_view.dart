import 'package:cinemapedia/presentation/providers/provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(getUpcomingProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    // final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedProvider);
    final moviesUpcoming = ref.watch(getUpcomingProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.only(left: 10),
          centerTitle: false,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppbar(),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: nowPlayingMovies.length,
            //     itemBuilder: (context, index) {
            //       final movie = nowPlayingMovies[index];
            //       return ListTile(
            //         title: Text(movie.title),
            //       );
            //     },
            //   ),
            // )
            MoviesSlideshow(movies: moviesSlideShow),

            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'lunes 20',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: moviesUpcoming,
              title: 'Proximamente',
              subTitle: 'En este mes',
              loadNextPage: () {
                ref.read(getUpcomingProvider.notifier).loadNextPage();
              },
            ),
            // MovieHorizontalListview(
            //   movies: popularMovies,
            //   title: 'Populares',
            //   // subTitle: 'En este mes',
            //   loadNextPage: () {
            //     ref.read(popularMoviesProvider.notifier).loadNextPage();
            //   },
            // ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              subTitle: 'Desde siempre',
              loadNextPage: () {
                ref.read(topRatedProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(
              height: 25,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
  
  @override
  bool get wantKeepAlive => true;
}
