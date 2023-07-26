import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/model/character.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/service/character_service.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/character/character_repository.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';

class CharacterViewModel with ChangeNotifier {
  final CharacterService characterService =
      CharacterService(CharacterRepository());

  final TextEditingController searchController = TextEditingController();

  int _numPages = 0;
  int get numPages => _numPages;

  int _currentePage = 1;
  int get currentePage => _currentePage;

  List<Character> _characterList = [];
  List<Character> get characterList => _characterList;

  Future<void> getCharactersPage(int page) async {
    Either response = await characterService.getCharactersPage(index: page);

    if (response.isRight) {
      _characterList = List<Character>.from(
          response.right['results'].map((x) => Character.fromJson(x)));
      _numPages = response.right['info']['pages'];
      _currentePage = page;
      notifyListeners();
    } else {
      _characterList = [];
      _numPages = 0;
      notifyListeners();
    }
  }

  Future<void> searchCharacters(int index) async {
    Either response = await characterService.searchCharacters(
        name: searchController.text, index: index);

    if (response.isRight) {
      _characterList = List<Character>.from(
          response.right['results'].map((x) => Character.fromJson(x)));
      _numPages = response.right['info']['pages'];
      searchController.text.isEmpty ? _currentePage = 1 : _currentePage = index;
      notifyListeners();
    } else {
      _characterList = [];
      _numPages = 0;
      notifyListeners();
    }
  }

  validateStatus(String status) {
    return status == 'Dead'
        ? ConstColors.red
        : status == 'Alive'
            ? ConstColors.green
            : ConstColors.greyUnknown;
  }
}
