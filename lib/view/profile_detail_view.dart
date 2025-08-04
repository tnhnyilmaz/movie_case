import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/bloc/auth/auth_bloc.dart';
import 'package:movie_case/bloc/movie/movie_bloc.dart';
import 'package:movie_case/bloc/movie/movie_event.dart';
import 'package:movie_case/bloc/movie/movie_state.dart';
import 'package:movie_case/components/appbar/botom_navigation.dart';
import 'package:movie_case/components/appbar/custom_appbar.dart';
import 'package:movie_case/components/profile_detay/movie_card.dart';
import 'package:movie_case/components/profile_detay/profile_info_row.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class ProfileDetailView extends StatefulWidget {
  const ProfileDetailView({super.key});

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/explorer');
          } else if (index == 1) {
            // Şu anki sayfa: ProfileDetailView, bir şey yapmaya gerek yok
          }
        },
      ),

      appBar: CustomAppbar(
        onPres: () {
          Navigator.pushReplacementNamed(context, '/explorer');
        },
        isOffer: true,
      ),
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          String userName = '';
          String userId = '';
          String photoUrl = '';

          if (state is AuthAuthenticated) {
            userName = state.userData.name;
            userId = state.userData.id;
            photoUrl = state.userData.photoUrl;
          }
          final displayPhotoUrl = photoUrl.isNotEmpty
              ? photoUrl
              : 'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg'; // Geçerli bir varsayılan URL ekleyin

          return BlocBuilder<MovieBloc, MovieState>(
            builder: (context, movieState) {
              if (movieState is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (movieState is FavoriteMoviesLoaded) {
                final movies = movieState.favoriteMovies;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        ProfileInfoRow(
                          userName: userName,
                          userId: userId,
                          photoUrl: displayPhotoUrl,
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.movis_like,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.55,
                                mainAxisSpacing: 16,
                              ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            print("movie poster:  ${movie.poster}");
                            final securePosterUrl = (movie.poster.isNotEmpty)
                                ? movie.poster.replaceFirst(
                                    'http://',
                                    'https://',
                                  )
                                : 'https://i.hizliresim.com/kesqtmz.png'; // varsayılan bir görsel

                            return MovieCard(
                              title: movie.title,
                              descr: "dsad",
                              poster: securePosterUrl,
                              // varsa göster
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (movieState is MovieError) {
                return Center(
                  child: Text(
                    "Hata: ${movieState.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.movie_not_load,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
