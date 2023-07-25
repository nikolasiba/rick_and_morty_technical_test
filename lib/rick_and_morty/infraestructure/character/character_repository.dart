import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/interface/i_character.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/network/network_api_service.dart';
import 'package:rick_and_morty_app/shared/utils/const.dart';

class CharacterRepository implements ICharacter {
  @override
  Future<Either<NetworkException, dynamic>> getCharacters() async {
    var apiService = NetworkApiService();
    String url;

    url = Constants.baseURL + Constants.characterEndpoint;

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }
}
