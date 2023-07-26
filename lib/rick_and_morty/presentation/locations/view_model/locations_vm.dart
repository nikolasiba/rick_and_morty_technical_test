import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/location/model/location.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/location/service/location_service.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/location/location_repository.dart';

class LocationViewModel with ChangeNotifier {
  final LocationService locationService = LocationService(LocationRepository());
  TextEditingController searchController = TextEditingController();

  int _numPages = 0;
  int get numPages => _numPages;

  int _currentePage = 1;
  int get currentePage => _currentePage;

  List<Location> _locationsList = [];
  List<Location> get locationListList => _locationsList;

  Future<void> getCharacters(int page) async {
    Either response = await locationService.getLocations(index: page);

    if (response.isRight) {
      _locationsList = List<Location>.from(
          response.right['results'].map((x) => Location.fromJson(x)));
      _numPages = response.right['info']['pages'];
      _currentePage = page;
      notifyListeners();
    } else {
      _locationsList = [];
      _numPages = 0;
      notifyListeners();
    }
  }

  Future<void> searchLocations(int index) async {
    Either response = await locationService.searchLocations(
        name: searchController.text, index: index);

    if (response.isRight) {
      _locationsList = List<Location>.from(
          response.right['results'].map((x) => Location.fromJson(x)));
      _numPages = response.right['info']['pages'];
      searchController.text.isEmpty ? _currentePage = 1 : _currentePage = index;
      notifyListeners();
    } else {
      _locationsList = [];
      _numPages = 0;
      notifyListeners();
    }
  }
}
