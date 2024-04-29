class YearlyWinnersCountDto {
  final int year;
  final int winnerCount;
  YearlyWinnersCountDto({
    required this.year,
    required this.winnerCount,
  });

  factory YearlyWinnersCountDto.fromJson(Map<String, dynamic> json) {
    return YearlyWinnersCountDto(
      year: json['year'],
      winnerCount: json['winnerCount'],
    );
  }
}
