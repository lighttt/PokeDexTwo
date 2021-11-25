import 'package:flutter/material.dart';
import 'package:pokedextwo/pokemon_utils.dart';
import 'package:pokedextwo/provider/pokemon_provider.dart';
import 'package:pokedextwo/screens/favourite_screen.dart';
import 'package:pokedextwo/screens/pokemon_details_screen.dart';
import 'package:pokedextwo/screens/pokemon_search_delegate.dart';
import 'package:provider/provider.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key key}) : super(key: key);

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  bool _isInit = true;
  Future _fetchData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _fetchData =
          Provider.of<PokemonProvider>(context, listen: false).getPokemonList();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'PokeDex',
          style: TextStyle(fontSize: 26, color: Colors.black),
        ),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                showSearch(context: context, delegate: PokemonSearchDelegate());
              }),
          IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => FavouriteScreen()));
              }),
        ],
      ),
      body: FutureBuilder(
        future: _fetchData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<PokemonProvider>(builder: (ctx, data, child) {
                  return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1.05,
                          mainAxisSpacing: 5),
                      itemCount: 50,
                      itemBuilder: (ctx, index) {
                        final pokemon = data.pokemonList[index];
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
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
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
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                        color: PokemonUtils
                                                            .getColorType(type),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white)),
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
                });
        },
      ),
    );
  }
}
