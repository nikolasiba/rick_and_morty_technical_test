import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/domain/character/model/character.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/characters/view_model/character_vm.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';

class CharacterDescription extends StatelessWidget {
  const CharacterDescription({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final characterViewModel = Provider.of<CharacterViewModel>(context);

    return Scaffold(
        backgroundColor: ConstColors.background,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: ConstColors.background,
            ),
          ),
          backgroundColor: ConstColors.purple,
          title: Text(
            'Character description',
            style: TextStyle(color: ConstColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(character.image)),
                ),
              ),
              _customText('Name', character.name),
              Row(
                children: [
                  _customText('Status', character.status),
                  const SizedBox(width: 4),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor:
                        characterViewModel.validateStatus(character.status),
                  ),
                ],
              ),
              _customText('Specie', character.species),
              _customText('Gender', character.gender),
              _customText('Location', character.location.name),
              _customText('Origin', character.origin.name),
              _customText('Episodes', character.episode.length.toString()),
              _customText(
                  'Created', character.created.toString().substring(0, 10)),
            ],
          ),
        ));
  }

  Widget _customText(String text, String expand) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(
              text: '$text:  ',
              style: TextStyle(
                  color: ConstColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              children: [
            TextSpan(
              text: expand,
              style: TextStyle(
                  color: ConstColors.purple,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }
}
