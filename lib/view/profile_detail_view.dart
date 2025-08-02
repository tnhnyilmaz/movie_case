import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/bloc/auth/auth_bloc.dart';
import 'package:movie_case/components/appbar/botom_navigation.dart';
import 'package:movie_case/components/appbar/custom_appbar.dart';
import 'package:movie_case/components/profile_detay/movie_card.dart';
import 'package:movie_case/components/profile_detay/profile_info_row.dart';

class ProfileDetailView extends StatefulWidget {
  const ProfileDetailView({super.key});

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> movies = [
      {"ad": "Film 1", "desc": "desc1"},
      {"ad": "Film 2", "desc": "desc2"},
      {"ad": "Film 3", "desc": "desc3"},
      {"ad": "Film 4", "desc": "desc4"},
      {"ad": "Film 5", "desc": "desc5"},
      {"ad": "Film 6", "desc": "desc6"},
      {"ad": "Film 7", "desc": "desc7"},
      {"ad": "Film 8", "desc": "desc8"},
    ];

    return Scaffold(
      appBar: CustomAppbar(onPres: () {}),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: currentIndex, onTabSelected: (int ) {  },),
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
            print(photoUrl);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ProfileInfoRow(
                    userName: userName,
                    userId: userId,
                    photoUrl: photoUrl,
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Beğenidiğim Filmler",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Euclid Circular A',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.55,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(
                        title: movie["ad"],
                        descr: movie["desc"],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
