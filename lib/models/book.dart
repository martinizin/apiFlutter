
class Book {
  final String title;
  final String authorName;
  final String coverUrl;

  Book({required this.title, required this.authorName, required this.coverUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No title available',
      authorName: json['author_name'] != null ? json['author_name'][0] : 'No author available',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : 'https://via.placeholder.com/150',
    );
  }
}