import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

abstract class IEpisode {
  Future<Either<NetworkException, dynamic>> getEpisodes({required int index});
  Future<Either<NetworkException, dynamic>> searchEpisodes(
      {required String name, required int index});
}
