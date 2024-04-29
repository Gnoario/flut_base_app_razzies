import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/movie_dto.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/pagination/pagination_dto.dart';

class PaginatedMoviesMock {
  PaginatedMoviesDto create() {
    return PaginatedMoviesDto(
      pagination: createPaginationMock(),
      movies: List<MovieDto>.generate(
        faker.randomGenerator.integer(10),
        (index) => _createMovieMock(),
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

  MovieDto _createMovieMock() {
    return MovieDto(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.word(),
      year: createRandomYear(),
      winner: createRandomWinner(),
      producers: List<String>.generate(
        faker.randomGenerator.integer(10),
        (index) => faker.person.name(),
      ),
      studios: List<String>.generate(
        faker.randomGenerator.integer(10),
        (index) => faker.company.name(),
      ),
    );
  }

  Map<String, dynamic> createPaginationJson() {
    return {
      'number': faker.randomGenerator.integer(10),
      'size': faker.randomGenerator.integer(10),
      'totalElements': faker.randomGenerator.integer(10),
      'totalPages': faker.randomGenerator.integer(10),
    };
  }

  Map<String, dynamic> createMovieJson() {
    return {
      'id': faker.randomGenerator.integer(100),
      'title': faker.lorem.word(),
      'year': createRandomYear(),
      'winner': createRandomWinner(),
      'producers': List<String>.generate(
        faker.randomGenerator.integer(10),
        (index) => faker.person.name(),
      ),
      'studios': List<String>.generate(
        faker.randomGenerator.integer(10),
        (index) => faker.company.name(),
      ),
    };
  }

  Map<String, dynamic> createPaginatedMoviesJson() {
    final pagination = createPaginationJson();
    return {
      'content': List<Map<String, dynamic>>.generate(
        faker.randomGenerator.integer(10),
        (index) => createMovieJson(),
      ).toList(),
      ...pagination,
    };
  }

  Map<String, dynamic> createPaginatedMoviesJsonWithError() {
    return {
      'content': List<Map<String, dynamic>>.generate(
        faker.randomGenerator.integer(10),
        (index) => createMovieJson(),
      ).toList(),
    };
  }
}
