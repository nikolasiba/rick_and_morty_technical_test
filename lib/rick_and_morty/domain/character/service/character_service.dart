import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/interface/i_character.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

class CharacterService {
  final ICharacter iCharacter;

  CharacterService(this.iCharacter);

  Future<Either<NetworkException, dynamic>> getCharactersPage(
      {required int index}) {
    return iCharacter.getCharactersPage(index: index);
  }

  Future<Either<NetworkException, dynamic>> searchCharacters(
      {required String name, required int index}) {
    return iCharacter.searchCharacters(name: name, index: index);
  }
}
