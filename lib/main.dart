// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_case/bloc/auth/auth_bloc.dart';
import 'package:movie_case/bloc/locale/locale_bloc.dart';
import 'package:movie_case/bloc/locale/locale_state.dart';
import 'package:movie_case/bloc/movie/movie_bloc.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/repositories/auth_repository.dart';
import 'package:movie_case/repositories/movie_repository.dart';
import 'package:movie_case/view/explorer_view.dart';
import 'package:movie_case/view/profile_detail_view.dart';
import 'package:movie_case/view/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // SharedPreferences için gerekli
  final movieRepository = MovieRepository();
  final authRepository = AuthRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(create: (_) => movieRepository),
        RepositoryProvider<AuthRepository>(create: (_) => authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocaleBloc>(
            create: (_) => LocaleBloc(), // SharedPreferences içinde çalışıyor
          ),
          BlocProvider<MovieBloc>(
            create: (context) =>
                MovieBloc(RepositoryProvider.of<MovieRepository>(context)),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Euclid Circular A',
              ),
              titleMedium: TextStyle(
                color: Colors
                    .white, // Colors.white.withOpacity(0.75) yerine bu daha iyi görünebilir.
                fontSize: 13,
                fontFamily: 'Euclid Circular A',
              ),
            ),
          ),
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale("en", ""), Locale("tr", "")],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const RootPage(),
            '/explorer': (context) => const ExplorerView(),
            '/profile': (context) => const ProfileDetailView(),
          },
        );
      },
    );
  }
}
