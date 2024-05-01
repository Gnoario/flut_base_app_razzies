import 'package:flut_base_app_razzies/app/domain/models/dtos/pagination/pagination_dto.dart';

import 'movie_dto.dart';

class PaginatedMoviesDto {
  final PaginationDto pagination;
  final List<MovieDto> movies;

  PaginatedMoviesDto({
    required this.pagination,
    required this.movies,
  });

  factory PaginatedMoviesDto.fromJson(Map<String, dynamic> json) {
    final content = json['content'] as List;
    return PaginatedMoviesDto(
      pagination: PaginationDto.fromJson(json),
      movies: content
          .map<MovieDto>(
            (movie) => MovieDto.fromJson(
              movie,
            ),
          )
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJsonMoviesList() {
    return movies.map((e) => e.toJson()).toList();
  }
}
