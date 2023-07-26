import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/episode/interface/i_episode.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/network/network_api_service.dart';
import 'package:rick_and_morty_app/shared/utils/const.dart';

class EpisodeRepository implements IEpisode {
  @override
  Future<Either<NetworkException, dynamic>> getEpisodes(
      {required int index}) async {
    var apiService = NetworkApiService();
    String url;

    url = '${Constants.baseURL}${Constants.episodeEndpoint}/?page=$index';

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }

  @override
  Future<Either<NetworkException, dynamic>> searchEpisodes(
      {required String name, required int index}) async {
    var apiService = NetworkApiService();
    String url;

    url =
        '${Constants.baseURL}${Constants.episodeEndpoint}/?name=$name&page=$index';

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }
}
