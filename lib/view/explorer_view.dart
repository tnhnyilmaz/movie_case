import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_case/bloc/movie/movie_bloc.dart';
import 'package:movie_case/bloc/movie/movie_event.dart';
import 'package:movie_case/bloc/movie/movie_state.dart';
import 'package:movie_case/components/appbar/botom_navigation.dart';
import 'package:movie_case/components/explorer/alert_dialog.dart';
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
    // Eğer state'de zaten film varsa tekrar yükleme yapma
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
                  child: const Center(child: Text("Film Bulanamadı")),
                ),
              );
            }

            // PageView ve NumberPagination'ı bir Stack içinde birleştir
            return Stack(
              children: [
                // 1. Film Listesini Gösteren PageView
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
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Text('Resim yüklenemedi')),
                        ),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 260,
                          right: 17,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    title: movie.title,
                                    movieId: movie.id,
                                  );
                                },
                              );
                            },
                            child: SizedBox(
                              width: 50,
                              height: 70,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    movie.isFav
                                        ? "assets/icons/hearts_icon.svg"
                                        : "assets/icons/hearts_icon_outline.svg",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 150,
                          left: 20,
                          right: 20,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Euclid Circular A',
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      movie.plot,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Euclid Circular A',
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                    const Text(
                                      "Daha Fazlası",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Euclid Circular A',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // 2. Sayfalama Kontrolü
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
          // Diğer durumlar için boş bir widget döndür
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
