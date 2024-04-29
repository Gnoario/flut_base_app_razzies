class MovieDto {
  final int id;
  final String title;
  final int year;
  final bool winner;
  final List<String> studios;
  final List<String> producers;

  MovieDto({
    required this.id,
    required this.title,
    required this.year,
    required this.winner,
    required this.studios,
    required this.producers,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      winner: json['winner'],
      studios: List<String>.from(json['studios']),
      producers: List<String>.from(json['producers']),
    );
  }
}
