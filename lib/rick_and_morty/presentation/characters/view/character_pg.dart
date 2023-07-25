import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/characters/view_model/character_vm.dart';

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
      characterViewModel.getCharacters();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterViewModel = Provider.of<CharacterViewModel>(context);
    final sizePage = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Personajes'),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: ListView.builder(
              itemCount: characterViewModel.characterList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: sizePage.height * .4,
                    width: sizePage.width * .4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white)),
                    child: Column(
                      children: [
                        Text(
                          characterViewModel.characterList[index].name,
                          style: const TextStyle(color: Colors.yellow),
                        ),
                        Image.network(
                          characterViewModel.characterList[index].image,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: sizePage.height * .05,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: characterViewModel.numPages,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: sizePage.height * .2,
                  width: sizePage.width * .2,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.yellow),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
