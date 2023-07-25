import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/episode/interface/i_episode.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

class EpisodeService {
  final IEpisode iEpisode;

  EpisodeService(this.iEpisode);

  Future<Either<NetworkException, dynamic>> getEpisodes() {
    return iEpisode.getEpisodes();
  }
}
