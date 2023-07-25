import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/navigation/view/navigation_pg.dart';
import 'package:rick_and_morty_app/rick_and_morty/presentation/navigation/view_model/navigation_vm.dart';

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
        ChangeNotifierProvider(create: (_) =>  NavigationViewModel()),

      ],
      child: MaterialApp(
      
        title: 'Rick and Morty Demo',
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NavigationPage(),
      ),
    );
  }
}


