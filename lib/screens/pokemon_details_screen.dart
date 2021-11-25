import 'package:flutter/material.dart';
import 'package:pokedextwo/pokemon_utils.dart';
import 'package:pokedextwo/provider/pokemon_provider.dart';
import 'package:pokedextwo/screens/tabs/about_tab.dart';
import 'package:pokedextwo/screens/tabs/base_move_tab.dart';
import 'package:pokedextwo/screens/tabs/evolutions_tab.dart';
import 'package:provider/provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String pokemonId;

  const PokemonDetailScreen({Key key, this.pokemonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPokemon = Provider.of<PokemonProvider>(context, listen: false)
        .getPokemonById(pokemonId);
    return Scaffold(
      backgroundColor: PokemonUtils.getColor(selectedPokemon),
      appBar: AppBar(
        backgroundColor: PokemonUtils.getColor(selectedPokemon),
        elevation: 0,
        actions: [
          Consumer<PokemonProvider>(
            builder: (ctx, data, child) {
              return IconButton(
                  icon: selectedPokemon.isFavourite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  iconSize: 28,
                  onPressed: () {
                    data.toggleFavourite(selectedPokemon.id);
                  });
            },
          )
        ],
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedPokemon.name,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        selectedPokemon.id,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: selectedPokemon.types
                        .map((type) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                                color: PokemonUtils.getColorType(type),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white)),
                            child: Text(
                              type,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )))
                        .toList(),
                  ),
                  Image.network(
                    selectedPokemon.imageUrl,
                    height: 220,
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey.shade700,
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(
                      text: 'About',
                    ),
                    Tab(
                      text: 'Evolutions',
                    ),
                    Tab(
                      text: 'Base Moves',
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: AboutTab(
                      selectedPokemon: selectedPokemon,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: EvolutionsTab(
                      selectedPokemon: selectedPokemon,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: BaseMovesTab(
                      selectedPokemon: selectedPokemon,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
