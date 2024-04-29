class PaginationDto {
  final int totalPages;
  final int totalElements;
  final int number;
  final int size;

  PaginationDto({
    required this.totalPages,
    required this.totalElements,
    required this.number,
    required this.size,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      number: json['number'],
      size: json['size'],
    );
  }
}
