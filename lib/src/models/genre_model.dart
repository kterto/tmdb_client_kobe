class Genre {
  final String genre;
  final int id;

  Genre({this.genre, this.id});

  Genre.fromJson(Map<String, dynamic> json)
      : genre = json['name'].toString() ?? null,
        id = int.parse(json['id'].toString()) ?? null;

  @override
  toString() {
    return '''{
    id: ${this.id},
    genre: ${this.genre},
  }''';
  }
}
