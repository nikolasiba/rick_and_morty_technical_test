import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/episode/model/episode.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/episodes/viewModel/episodes_vm.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';
import 'package:rick_and_morty_app/shared/widgets/custom_loading.dart';
import 'package:rick_and_morty_app/shared/widgets/custom_text_field.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final episodeViewModel = Provider.of<EpisodesViewModel>(context);
      episodeViewModel.getCharacters(1);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final episodeViewModel = Provider.of<EpisodesViewModel>(context);
    final sizePage = MediaQuery.of(context).size;

    final Debouncer onSearchDebouncer =
        Debouncer(delay: const Duration(milliseconds: 500));

    return Scaffold(
        backgroundColor: ConstColors.background,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text(
            'Episodes',
            style: TextStyle(
                color: ConstColors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                textEditingController: episodeViewModel.searchController,
                hintText: 'Search',
                onChanged: (value) async {
                  onSearchDebouncer(() => episodeViewModel.searchEpisodes(1));
                  // await Future.delayed(const Duration(milliseconds: 800),
                  //     () => episodeViewModel.searchEpisodes(1));
                },
              ),
            ),
            episodeViewModel.episodesList.isNotEmpty
                ? Flexible(
                    fit: FlexFit.tight,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: episodeViewModel.episodesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _customEpisodeCard(
                            episodeViewModel.episodesList[index]);
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'no episodes',
                      style: TextStyle(
                          color: ConstColors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
            SizedBox(
              height: sizePage.height * .05,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: episodeViewModel.numPages,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      CustomLoading(context, title: '');
                      episodeViewModel.searchController.text.isEmpty
                          ? await episodeViewModel.getCharacters(index + 1)
                          : await episodeViewModel.searchEpisodes(index + 1);
                      Future.delayed(const Duration(milliseconds: 500),
                          () => Navigator.pop(context));
                    },
                    child: Container(
                      height: sizePage.height * .2,
                      width: sizePage.width * .2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text('${index + 1}',
                            style: episodeViewModel.currentePage == index + 1
                                ? TextStyle(color: ConstColors.purple)
                                : TextStyle(color: ConstColors.greyUnknown)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _customEpisodeCard(Episode episode) {
    final sizePage = MediaQuery.of(context).size;
    final TextStyle primaryTextStyle =
        TextStyle(color: ConstColors.purple, fontWeight: FontWeight.bold);
    final TextStyle secondTextStyle =
        TextStyle(color: ConstColors.white, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: sizePage.height * .1,
        decoration: BoxDecoration(
          color: ConstColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: 'Nombre: ',
                    style: primaryTextStyle,
                    children: [
                  TextSpan(text: episode.name, style: secondTextStyle)
                ])),
            RichText(
                text: TextSpan(
                    text: 'Type: ',
                    style: primaryTextStyle,
                    children: [
                  TextSpan(text: episode.airDate, style: secondTextStyle)
                ])),
            RichText(
                text: TextSpan(
                    text: 'Dimension: ',
                    style: primaryTextStyle,
                    children: [
                  TextSpan(text: episode.episode, style: secondTextStyle)
                ])),
          ],
        ),
      ),
    );
  }
}
