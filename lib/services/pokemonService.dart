import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemonapi/models/pokemon.dart';

class PokemonService {
  final String apiUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<List<Pokemon>> fetchPokemons(int limit) async {
    final response = await http.get(Uri.parse('$apiUrl?limit=$limit'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      List<Pokemon> pokemons = [];

      for (var item in data) {
        final pokemonDetailResponse = await http.get(Uri.parse(item['url']));
        if (pokemonDetailResponse.statusCode == 200) {
          pokemons.add(Pokemon.fromJson(json.decode(pokemonDetailResponse.body)));
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}