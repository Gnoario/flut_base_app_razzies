import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/movie_dto.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/pagination/pagination_dto.dart';

import 'movie_mock.dart';

class PaginatedMoviesMock {
  final MovieMock _moviesMock = MovieMock();
  PaginatedMoviesDto create() {
    return PaginatedMoviesDto(
      pagination: createPaginationMock(),
      movies: List<MovieDto>.generate(
        faker.randomGenerator.integer(10),
        (index) => _moviesMock.createMovieMock(),
      ),
    );
  }

  PaginationDto createPaginationMock() {
    return PaginationDto(
      number: faker.randomGenerator.integer(10),
      size: faker.randomGenerator.integer(10),
      totalElements: faker.randomGenerator.integer(10),
      totalPages: faker.randomGenerator.integer(10),
    );
  }

  PaginatedMoviesDto fromJson(Map<String, dynamic> json) {
    return PaginatedMoviesDto.fromJson(json);
  }

  int createRandomYear() {
    return faker.randomGenerator.integer(min: 1950, 2024);
  }

  bool createRandomWinner() {
    return faker.randomGenerator.boolean();
  }

  Map<String, dynamic> createPaginationJson() {
    return {
      'number': faker.randomGenerator.integer(10),
      'size': faker.randomGenerator.integer(10),
      'totalElements': faker.randomGenerator.integer(10),
      'totalPages': faker.randomGenerator.integer(10),
    };
  }

  Map<String, dynamic> createPaginatedMoviesJson() {
    final pagination = createPaginationJson();
    return {
      'content': List<Map<String, dynamic>>.generate(
        faker.randomGenerator.integer(10),
        (index) => _moviesMock.createMovieJson(),
      ).toList(),
      ...pagination,
    };
  }

  Map<String, dynamic> createPaginatedMoviesJsonWithError() {
    return {
      'content': List<Map<String, dynamic>>.generate(
        faker.randomGenerator.integer(10),
        (index) => _moviesMock.createMovieJson(),
      ).toList(),
    };
  }

  List<Map<String, dynamic>> createMoviesJson() {
    return List<Map<String, dynamic>>.generate(
      faker.randomGenerator.integer(10, min: 1),
      (index) => _moviesMock.createMovieJson(),
    );
  }
}
