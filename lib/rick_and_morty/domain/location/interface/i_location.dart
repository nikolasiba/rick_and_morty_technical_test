import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

abstract class ILocation {
  Future<Either<NetworkException, dynamic>> getLocations({required int index});
  Future<Either<NetworkException, dynamic>> searchLocations({required int index , required String name});



}
