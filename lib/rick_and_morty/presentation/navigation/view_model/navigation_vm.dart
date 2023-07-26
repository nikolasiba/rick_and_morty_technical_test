import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/characters/view/character_pg.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/episodes/view/episodes_pg.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/locations/view/locations_pg.dart';

class NavigationViewModel with ChangeNotifier {
  int _pageOption = 0;
  int get pageOption => _pageOption;

  final pages = [
    const CharactersPage(),
    const LocationsPage(),
    const EpisodesPage()
  ];

  void changeOption(int value) {
    _pageOption = value;
    notifyListeners();
  }

  Widget selectPage() {
    switch (_pageOption) {
      case 0:
        return const CharactersPage();
      case 1:
        return const LocationsPage();
      case 2:
        return const EpisodesPage();

      default:
        return const Center(
          child: Text('hola mundo'),
        );
    }
  }
}
