import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/episode/model/episode.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/episode/service/episode_service.dart';
import 'package:rick_and_morty_app/rick_and_morty/infraestructure/episode/episode_repository.dart';

class EpisodesViewModel with ChangeNotifier {
  final EpisodeService episodeService = EpisodeService(EpisodeRepository());
  final TextEditingController searchController = TextEditingController();

  int _numPages = 0;
  int get numPages => _numPages;

  int _currentePage = 1;
  int get currentePage => _currentePage;

  List<Episode> _episodesList = [];
  List<Episode> get episodesList => _episodesList;

  Future<void> getCharacters(int page) async {
    Either response = await episodeService.getEpisodes(index: page);

    if (response.isRight) {
      _episodesList = List<Episode>.from(
          response.right['results'].map((x) => Episode.fromJson(x)));
      _numPages = response.right['info']['pages'];
      _currentePage = page;
      notifyListeners();
    } else {
      _episodesList = [];
      _numPages = 0;
      notifyListeners();
    }
  }

  Future<void> searchEpisodes(int index) async {
    Either response = await episodeService.searchEpisodes(
        name: searchController.text, index: index);

    if (response.isRight) {
      _episodesList = List<Episode>.from(
          response.right['results'].map((x) => Episode.fromJson(x)));
      _numPages = response.right['info']['pages'];
      searchController.text.isEmpty ? _currentePage = 1 : _currentePage = index;
      notifyListeners();
    } else {
      _episodesList = [];
      _numPages = 0;
      notifyListeners();
    }
  }
}
