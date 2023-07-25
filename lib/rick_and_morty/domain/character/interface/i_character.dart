import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

abstract class ICharacter {
  Future<Either<NetworkException, dynamic>> getCharacters();
}
