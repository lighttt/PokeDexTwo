import 'package:flutter/material.dart';
import 'package:pokedextwo/provider/pokemon_provider.dart';
import 'package:pokedextwo/screens/pokemon_details_screen.dart';
import 'package:provider/provider.dart';

class PokemonSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {}

  @override
  Widget buildLeading(BuildContext context) {}

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Center(
            child: Text('Search through the PokeDex'),
          )
        : Consumer<PokemonProvider>(builder: (ctx, data, child) {
            final searchList = data.getSearchList(query);
            return searchList.isEmpty
                ? Center(
                    child: Text('Sorry, the pokemon with $query doesnot exist'),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    itemCount: searchList.length,
                    itemBuilder: (ctx, index) {
                      final pokemon = searchList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PokemonDetailScreen(
                                    pokemonId: pokemon.id,
                                  )));
                        },
                        leading: Image.network(
                          pokemon.imageUrl,
                          height: 80,
                        ),
                        title: Text(pokemon.name),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 1.5,
                      );
                    },
                  );
          });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Center(
            child: Text('Search through the PokeDex'),
          )
        : Consumer<PokemonProvider>(builder: (ctx, data, child) {
            final searchList = data.getSearchList(query);
            return searchList.isEmpty
                ? Center(
                    child: Text(
                        'Sorry, the pokemon with \'$query\' doesnot exist'),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    itemCount: searchList.length,
                    itemBuilder: (ctx, index) {
                      final pokemon = searchList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PokemonDetailScreen(
                                    pokemonId: pokemon.id,
                                  )));
                        },
                        leading: Image.network(
                          pokemon.imageUrl,
                          height: 80,
                        ),
                        title: Text(pokemon.name),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 1.5,
                      );
                    },
                  );
          });
  }
}
