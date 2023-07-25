import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/location/interface/i_location.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';

class LocationService {
  final ILocation iLocation;

  LocationService(this.iLocation);

  Future<Either<NetworkException, dynamic>> getLocations() {
    return iLocation.getLocations();
  }
}
