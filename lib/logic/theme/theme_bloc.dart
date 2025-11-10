import 'package:bloc/bloc.dart';
import 'package:countries_app/core/utils/preferences.dart';
import 'package:countries_app/logic/theme/theme_state';
import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  
  ThemeBloc() : super(ThemeState(isDarkTheme: Preferences.getIsDarkTheme() ?? false)) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) {
    final isDark = Preferences.getIsDarkTheme() ?? false;
    emit(ThemeState(isDarkTheme: isDark));
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final newTheme = !state.isDarkTheme;
    await Preferences.setIsDarkTheme(newTheme);
    emit(ThemeState(isDarkTheme: newTheme));
  }
}
