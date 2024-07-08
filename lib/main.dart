// import 'package:flutter/material.dart';
// import 'package:pokemonapi/models/pokemon.dart';
// import 'package:pokemonapi/services/pokemonService.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'API POKEMON :D',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PokemonListScreen(),
//     );
//   }
// }

// class PokemonListScreen extends StatefulWidget {
//   @override
//   _PokemonListScreenState createState() => _PokemonListScreenState();
// }

// class _PokemonListScreenState extends State<PokemonListScreen> {
//   late Future<List<Pokemon>> futurePokemons;
//   final PokemonService pokemonService = PokemonService();

//   @override
//   void initState() {
//     super.initState();
//     futurePokemons = pokemonService.fetchPokemons(10);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LISTA DE POKÉMONS'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Pokemon>>(
//           future: futurePokemons,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final pokemon = snapshot.data![index];
//                   return ListTile(
//                     leading: Image.network(pokemon.url),
//                     title: Text(pokemon.nombre),
                    
//                   );
//                 },
//               );
//             } else {
//               return Text('POKEMÓN NO ENCONTRADO!');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pokemonapi/models/book.dart';
import 'package:pokemonapi/services/bookService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Open Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(),
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<Book>> futureBooks;
  final BookService bookService = BookService();
  final TextEditingController _controller = TextEditingController();

  void searchBooks(String query) {
    setState(() {
      futureBooks = bookService.fetchBooks(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Library Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for a book',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchBooks(_controller.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: futureBooks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final book = snapshot.data![index];
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(book.coverUrl),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  book.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(book.authorName),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No books found');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}