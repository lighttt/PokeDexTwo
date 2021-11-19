import 'package:flutter/material.dart';
import 'package:pokedextwo/screens/pokemon_list_screen.dart';

void main() {
  runApp(PokeDexApp());
}

class PokeDexApp extends StatelessWidget {
  const PokeDexApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: PokemonListScreen(),
    );
  }
}
