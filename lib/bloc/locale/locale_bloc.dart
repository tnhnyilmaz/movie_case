import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_event.dart';
import 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(const Locale("en"))) {
    on<ChangeLocale>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', event.locale.languageCode);
      emit(LocaleState(event.locale));
    });

    _loadSavedLocale(); // dil daha önce seçilmiş mi diye kontrol et
  }

  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('languageCode');

    if (langCode != null) {
      add(ChangeLocale(Locale(langCode)));
    }
  }
  
}
