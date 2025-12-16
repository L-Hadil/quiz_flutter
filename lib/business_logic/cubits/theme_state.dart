part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;
  const ThemeState(this.themeData);

  @override
  List<Object?> get props => [themeData];

  factory ThemeState.light() => LightThemeState();
  factory ThemeState.dark() => DarkThemeState();
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(AppThemes.lightTheme);
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(AppThemes.darkTheme);
}

class CustomThemeState extends ThemeState {
  CustomThemeState({required ThemeData themeData}) : super(themeData);
}
