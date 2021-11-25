import 'package:flutter/material.dart';
import 'package:pokedextwo/provider/pokemon_provider.dart';
import 'package:pokedextwo/screens/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PokeDexApp());
}

class PokeDexApp extends StatelessWidget {
  const PokeDexApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return PokemonProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: PokemonListScreen(),
      ),
    );
  }
}
