import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/movie_dto.dart';

class MovieMock {
  MovieDto createMovieMock() {
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

  int createRandomYear() {
    return faker.randomGenerator.integer(min: 1950, 2024);
  }

  bool createRandomWinner() {
    return faker.randomGenerator.boolean();
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

  MovieDto fromJson(Map<String, dynamic> json) {
    return MovieDto.fromJson(json);
  }

  Map<String, dynamic> createMovieJsonWithError() {
    return {
      'title': faker.lorem.word(),
      'year': createRandomYear(),
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
}
