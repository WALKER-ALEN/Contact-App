import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeChanger extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void switcher() {
    state = !state;
  }
}

final themeProvider =
    NotifierProvider<ThemeChanger, bool>(() => ThemeChanger());
