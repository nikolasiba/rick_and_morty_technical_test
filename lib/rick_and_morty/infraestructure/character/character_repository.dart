import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/interface/i_character.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/network/network_api_service.dart';
import 'package:rick_and_morty_app/shared/utils/const.dart';

class CharacterRepository implements ICharacter {
  

  @override
  Future<Either<NetworkException, dynamic>> getCharactersPage(
      {required int index}) async {
    var apiService = NetworkApiService();
    String url;

    url = '${Constants.baseURL}${Constants.characterEndpoint}/?page=$index';

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }

  @override
  Future<Either<NetworkException, dynamic>> searchCharacters(
      {required String name, required int index}) async {
    var apiService = NetworkApiService();
    String url;

    url =
        '${Constants.baseURL}${Constants.characterEndpoint}/?name=$name&page=$index';

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }
}
