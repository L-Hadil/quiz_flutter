import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quiz_advanced/core/themes/app_themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light());

  void toggleTheme() {
    if (state is LightThemeState) {
      emit(ThemeState.dark());
    } else {
      emit(ThemeState.light());
    }
  }

  void setLightTheme() {
    emit(ThemeState.light());
  }

  void setDarkTheme() {
    emit(ThemeState.dark());
  }

  void setCustomTheme(ThemeData themeData) {
    emit(CustomThemeState(themeData: themeData));
  }
}
