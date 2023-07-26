import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/characters/view_model/character_vm.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/episodes/viewModel/episodes_vm.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/locations/view_model/locations_vm.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/navigation/view/navigation_pg.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/navigation/view_model/navigation_vm.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
        ChangeNotifierProvider(create: (_) => CharacterViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => EpisodesViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ConstColors.purple),
          useMaterial3: true,
        ),
        home: const NavigationPage(),
      ),
    );
  }
}
