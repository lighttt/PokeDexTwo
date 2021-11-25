import 'package:flutter/material.dart';
import 'package:pokedextwo/provider/pokemon_provider.dart';
import 'package:pokedextwo/screens/pokemon_details_screen.dart';
import 'package:provider/provider.dart';

import '../pokemon_utils.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Favourites',
            style: TextStyle(fontSize: 26, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Consumer<PokemonProvider>(builder: (ctx, data, child) {
          final favourites = data.getFavouriteList();
          return favourites.isEmpty
              ? Center(
                  child: Text('Please add some favorite pokemons'),
                )
              : GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1.05,
                      mainAxisSpacing: 5),
                  itemCount: favourites.length,
                  itemBuilder: (ctx, index) {
                    final pokemon = favourites[index];
                    return Card(
                        elevation: 3,
                        color: PokemonUtils.getColor(pokemon),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PokemonDetailScreen(
                                      pokemonId: pokemon.id,
                                    )));
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '${pokemon.id}',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    )),
                                Text(
                                  '${pokemon.name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: pokemon.types
                                            .map((type) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4, vertical: 4),
                                                decoration: BoxDecoration(
                                                    color: PokemonUtils
                                                        .getColorType(type),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: Text(
                                                  type,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )))
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Image.network(
                                        pokemon.imageUrl,
                                        height: 100,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  });
        }));
  }
}
