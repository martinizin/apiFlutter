class Pokemon{
  final String nombre;
  final String url;

  Pokemon({ required this.nombre, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      nombre: json['name'],
      url: json['sprites']['front_default'],
    );
  }

}