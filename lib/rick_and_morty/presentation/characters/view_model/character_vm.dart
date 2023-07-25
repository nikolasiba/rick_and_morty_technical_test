import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/model/character.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/service/character_service.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/character/character_repository.dart';

class CharacterViewModel with ChangeNotifier {
  final CharacterService characterService =
      CharacterService(CharacterRepository());

  int _numPages = 0;
  int get numPages => _numPages;

  List<Character> _characterList = [];
  List<Character> get characterList => _characterList;

  Future<void> getCharacters() async {
    Either response = await characterService.getCharacters();

    if (response.isRight) {
      _characterList = List<Character>.from(
          response.right['results'].map((x) => Character.fromJson(x)));
      _numPages = response.right['info']['pages'];
      notifyListeners();
    }
  }
}
