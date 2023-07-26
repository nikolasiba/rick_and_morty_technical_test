import 'package:either_dart/either.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/location/interface/i_location.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/error/network_error.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/data/remote/network/network_api_service.dart';
import 'package:rick_and_morty_app/shared/utils/const.dart';

class LocationRepository implements ILocation {
  @override
  Future<Either<NetworkException, dynamic>> getLocations(
      {required int index}) async {
    var apiService = NetworkApiService();
    String url;

    url = '${Constants.baseURL}${Constants.locationEndpoint}/?page=$index';

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }

  @override
  Future<Either<NetworkException, dynamic>> searchLocations(
      {required int index, required String name}) async {
    var apiService = NetworkApiService();
    String url;

    url =
        '${Constants.baseURL}${Constants.locationEndpoint}/?page=$index&name=$name';

    Either<NetworkException, dynamic> response =
        await apiService.getResponse(url);

    return response;
  }
}
