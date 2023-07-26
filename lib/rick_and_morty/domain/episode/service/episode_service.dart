import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/episode/interface/i_episode.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

class EpisodeService {
  final IEpisode iEpisode;

  EpisodeService(this.iEpisode);

  Future<Either<NetworkException, dynamic>> getEpisodes({required int index}) {
    return iEpisode.getEpisodes(index: index);
  }

  Future<Either<NetworkException, dynamic>> searchEpisodes(
      {required String name, required int index}) {
    return iEpisode.searchEpisodes(name: name, index: index);
  }
}
