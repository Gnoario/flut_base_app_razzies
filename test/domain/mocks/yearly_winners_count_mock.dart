import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/yearly_winners_count_dto/yearly_winners_count_dto.dart';

class YearlyWinnersCountMock {
  YearlyWinnersCountDto create() {
    return YearlyWinnersCountDto(
      year: createRandomYear(),
      winnerCount: faker.randomGenerator.integer(99),
    );
  }

  List<YearlyWinnersCountDto> createList() {
    return List.generate(
      faker.randomGenerator.integer(10, min: 1),
      (index) => create(),
    );
  }

  int createRandomYear() {
    return faker.randomGenerator.integer(min: 1950, 2024);
  }

  YearlyWinnersCountDto _fromJson(Map<String, dynamic> json) {
    return YearlyWinnersCountDto.fromJson(json);
  }

  List<YearlyWinnersCountDto> fromList(List<Map<String, dynamic>> json) {
    final list = json as List;
    return list.map((e) => _fromJson(e)).toList();
  }

  Map<String, dynamic> _createYearlyWinnersCountJson() {
    return {
      'year': createRandomYear(),
      'winnerCount': faker.randomGenerator.integer(99),
    };
  }

  Map<String, dynamic> _createYearlyWinnersCountJsonWithError() {
    return {
      'winnerCount': faker.randomGenerator.integer(99),
    };
  }

  List<Map<String, dynamic>> createYearlyWinnersCountListJson() {
    return List.generate(
      faker.randomGenerator.integer(10, min: 1),
      (index) => _createYearlyWinnersCountJson(),
    );
  }

  List<Map<String, dynamic>> createYearlyWinnersCountListJsonWithError() {
    return List.generate(
      faker.randomGenerator.integer(10),
      (index) => _createYearlyWinnersCountJsonWithError(),
    );
  }
}
