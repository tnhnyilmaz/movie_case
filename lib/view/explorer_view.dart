import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/bloc/movie/movie_bloc.dart';
import 'package:movie_case/bloc/movie/movie_event.dart';
import 'package:movie_case/bloc/movie/movie_state.dart';
import 'package:movie_case/components/appbar/botom_navigation.dart';
import 'package:movie_case/components/explorer/bottom_gradient.dart';
import 'package:movie_case/components/explorer/fav_container.dart';
import 'package:movie_case/components/explorer/language_button.dart';
import 'package:movie_case/components/explorer/movie_text_detail.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:number_pagination/number_pagination.dart';

class ExplorerView extends StatefulWidget {
  const ExplorerView({super.key});

  @override
  State<ExplorerView> createState() => _ExplorerViewState();
}

class _ExplorerViewState extends State<ExplorerView> {
  @override
  void initState() {
    super.initState();
    if (context.read<MovieBloc>().state is! MovieLoaded) {
      context.read<MovieBloc>().add(const FetchMovies(page: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieError) {
            return Center(child: Text("Hata: ${state.message}"));
          } else if (state is MovieLoaded) {
            if (state.movies.isEmpty) {
              return Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.not_found_movie),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    final securePosterUrl = movie.poster.replaceFirst(
                      'http://',
                      'https://',
                    );

                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          securePosterUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Text(
                              AppLocalizations.of(context)!.not_found_image,
                            ),
                          ),
                        ),
                        Positioned(bottom: 0, child: BottomGradient()),
                        Positioned(
                          bottom: 260,
                          right: 17,
                          child: FavContainer(movie: movie),
                        ),
                        Positioned(
                          bottom: 150,
                          left: 20,
                          right: 20,
                          child: MovieTextDetail(movie: movie),
                        ),
                      ],
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 95.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: NumberPagination(
                      onPageChanged: (pageNumber) {
                        context.read<MovieBloc>().add(
                          FetchMovies(page: pageNumber),
                        );
                      },
                      totalPages: state.totalPages,
                      currentPage: state.currentPage,
                      buttonRadius: 8,
                      sectionSpacing: 2,
                      selectedButtonColor: Colors.white,
                      selectedNumberColor: Colors.black,
                      buttonSelectedBorderColor: Colors.white,
                      controlButtonColor: Colors.white.withOpacity(0.1),
                      buttonUnSelectedBorderColor: Colors.white.withOpacity(
                        0.2,
                      ),
                      unSelectedButtonColor: Colors.white.withOpacity(0.2),
                      controlButtonSize: const Size(30, 30),
                      numberButtonSize: const Size(30, 30),
                    ),
                  ),
                ),
                LanguageButton(),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigation(
                    currentIndex: 0,
                    onTabSelected: (p0) {},
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
