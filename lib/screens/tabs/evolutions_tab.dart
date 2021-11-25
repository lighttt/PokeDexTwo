import 'package:flutter/material.dart';
import 'package:pokedextwo/models/pokemon_model.dart';
import 'package:pokedextwo/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

class EvolutionsTab extends StatefulWidget {
  final PokemonModel selectedPokemon;

  const EvolutionsTab({Key key, this.selectedPokemon}) : super(key: key);

  @override
  _EvolutionsTabState createState() => _EvolutionsTabState();
}

class _EvolutionsTabState extends State<EvolutionsTab> {
  List<PokemonModel> _evolutions = [];

  Widget _buildEvolution(
      PokemonModel firstPokemon, PokemonModel secondPokemon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            children: [
              Image.network(
                firstPokemon.imageUrl,
                height: 100,
              ),
              Text(firstPokemon.name),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Icon(Icons.arrow_forward),
              Text(
                secondPokemon.evolveLevel,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image.network(
                secondPokemon.imageUrl,
                height: 100,
              ),
              Text(secondPokemon.name),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final evolutions = widget.selectedPokemon.evolutions;
    evolutions.forEach((id) {
      final pokemon = Provider.of<PokemonProvider>(context, listen: false)
          .getPokemonById(id);
      _evolutions.add(pokemon);
    });
  }

  List<Widget> _buildEvolutionsList() {
    if (_evolutions.length < 2) {
      return [Center(child: Text('No evolutions available.'))];
    }
    return Iterable<int>.generate(_evolutions.length - 1)
        .map((index) =>
            _buildEvolution(_evolutions[index], _evolutions[index + 1]))
        .expand((widget) => [widget, Divider()])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildEvolutionsList(),
    );
  }
}
