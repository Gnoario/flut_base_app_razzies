class StudioWinCountDto {
  final String name;
  final int winCount;
  StudioWinCountDto({
    required this.name,
    required this.winCount,
  });

  factory StudioWinCountDto.fromJson(Map<String, dynamic> json) {
    return StudioWinCountDto(
      name: json['name'],
      winCount: json['winCount'],
    );
  }
}
