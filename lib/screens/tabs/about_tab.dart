import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedextwo/models/pokemon_model.dart';

class AboutTab extends StatelessWidget {
  final PokemonModel selectedPokemon;

  const AboutTab({Key key, this.selectedPokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedPokemon.description,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        ),
        SizedBox(
          height: 20,
        ),
        Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Height',
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      selectedPokemon.height,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Weight',
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      selectedPokemon.weight,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              'Gender',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            SizedBox(
              width: 50,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.mars,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  selectedPokemon.malePercentage,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.venus,
                  color: Colors.pink,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  selectedPokemon.femalePercentage,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
