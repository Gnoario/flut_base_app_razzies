class PaginationDto {
  final int? totalPages;
  final int? totalElements;
  final int number;
  final int size;

  PaginationDto({
    this.totalPages,
    this.totalElements,
    required this.number,
    required this.size,
  });

  PaginationDto copyWith({
    int? totalPages,
    int? totalElements,
    int? number,
    int? size,
  }) {
    return PaginationDto(
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      number: number ?? this.number,
      size: size ?? this.size,
    );
  }

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      number: json['number'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPages': totalPages,
      'totalElements': totalElements,
      'number': number,
      'size': size,
    };
  }
}
