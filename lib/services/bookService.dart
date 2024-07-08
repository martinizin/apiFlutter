import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemonapi/models/book.dart';

class BookService {
  final String apiUrl = "https://openlibrary.org/search.json";

  Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$query&limit=10'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['docs'].take(10).toList();
      List<Book> books = data.map((book) => Book.fromJson(book)).toList();
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
}