import 'package:flutter/material.dart';

import '../models/pokemon_card.dart';
import '../utils.dart';
import '../widgets/card_collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PokemonCard>> pokemonCards;

  @override
  void initState() {
    super.initState();

    // Read and parse JSON that contains the card list
    pokemonCards = fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lambo Pokemon Collections',
        ),
        backgroundColor: Colors.orange[400],
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.account_circle_outlined),
          ),
        ],
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<List<PokemonCard>>(
            future: pokemonCards,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return CardCollection(pokemonCards: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber[700],
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokemon',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
