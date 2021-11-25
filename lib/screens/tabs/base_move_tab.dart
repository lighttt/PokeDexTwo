import 'package:flutter/material.dart';
import 'package:pokedextwo/models/pokemon_model.dart';
import 'package:pokedextwo/pokemon_utils.dart';

class BaseMovesTab extends StatelessWidget {
  final PokemonModel selectedPokemon;

  const BaseMovesTab({Key key, this.selectedPokemon}) : super(key: key);

  Widget _buildItems({String title, int value}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            '$value',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87),
          ),
        ),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: value / 100,
            valueColor: AlwaysStoppedAnimation<Color>(
                PokemonUtils.getColor(selectedPokemon)),
            backgroundColor:
                PokemonUtils.getColor(selectedPokemon).withOpacity(0.2),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItems(title: "HP", value: selectedPokemon.hp),
        SizedBox(
          height: 10,
        ),
        _buildItems(title: "Attack", value: selectedPokemon.attack),
        SizedBox(
          height: 10,
        ),
        _buildItems(title: "Speed", value: selectedPokemon.speed),
        SizedBox(
          height: 10,
        ),
        _buildItems(title: "Defense", value: selectedPokemon.defense),
        SizedBox(
          height: 10,
        ),
        _buildItems(title: "Sp. Attack", value: selectedPokemon.specialAttack),
        SizedBox(
          height: 10,
        ),
        _buildItems(
            title: "Sp. Defense", value: selectedPokemon.specialDefense),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
