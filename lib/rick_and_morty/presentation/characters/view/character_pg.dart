import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/model/character.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/characters/view_model/character_vm.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/characters/widgets/character_description.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';
import 'package:rick_and_morty_app/shared/widgets/custom_loading.dart';
import 'package:rick_and_morty_app/shared/widgets/custom_text_field.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final characterViewModel = Provider.of<CharacterViewModel>(context);
      characterViewModel.getCharactersPage(1);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterViewModel = Provider.of<CharacterViewModel>(context);
    final sizePage = MediaQuery.of(context).size;
    final Debouncer onSearchDebouncer =
        Debouncer(delay: const Duration(milliseconds: 500));
    return Scaffold(
        backgroundColor: ConstColors.background,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text(
            'Characters',
            style: TextStyle(
                color: ConstColors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                textEditingController: characterViewModel.searchController,
                hintText: 'Search',
                onChanged: (value) async {
                  onSearchDebouncer(
                      () => characterViewModel.searchCharacters(1));
                  // await Future.delayed(const Duration(milliseconds: 800),
                  //     () => characterViewModel.searchCharacters(1));
                },
              ),
            ),
            characterViewModel.characterList.isNotEmpty
                ? Flexible(
                    fit: FlexFit.tight,
                    child: ListView.builder(
                      itemCount: characterViewModel.characterList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _customCharacter(
                            characterViewModel.characterList[index]);
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'there are no characters',
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
                itemCount: characterViewModel.numPages,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      CustomLoading(context, title: '');
                      characterViewModel.searchController.text.isEmpty
                          ? await characterViewModel
                              .getCharactersPage(index + 1)
                          : await characterViewModel
                              .searchCharacters(index + 1);
                      Future.delayed(const Duration(milliseconds: 500),
                          () => Navigator.pop(context));
                    },
                    child: Container(
                      height: sizePage.height * .2,
                      width: sizePage.width * .2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: characterViewModel.currentePage == index + 1
                              ? TextStyle(color: ConstColors.purple)
                              : TextStyle(color: ConstColors.greyUnknown),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _customCharacter(Character character) {
    final characterViewModel = Provider.of<CharacterViewModel>(context);
    final sizePage = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CharacterDescription(character: character)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ConstColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                Image.network(
                  character.image,
                  height: sizePage.height * .2,
                  width: sizePage.width * .4,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(width: sizePage.width * .02),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: sizePage.width * .45,
                        child: Text(
                          character.name,
                          style: TextStyle(
                              color: ConstColors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: characterViewModel
                                .validateStatus(character.status),
                            radius: 5,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            character.status,
                            style: TextStyle(
                                color: ConstColors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        character.species,
                        style: TextStyle(
                            color: ConstColors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      Text(
                        character.location.name,
                        style: TextStyle(color: ConstColors.greyUnknown),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
