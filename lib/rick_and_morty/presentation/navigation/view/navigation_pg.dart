import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/navigation/view_model/navigation_vm.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = Provider.of<NavigationViewModel>(context);
    return Scaffold(
      body: navigationViewModel.selectPage(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => navigationViewModel.changeOption(index),
          currentIndex: navigationViewModel.pageOption,
          
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: 'Personajes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: 'Personajes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: 'Personajes'),
          ]),
    );
  }
}
