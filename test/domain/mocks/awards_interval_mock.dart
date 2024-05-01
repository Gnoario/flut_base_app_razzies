import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/awards_interval/awards_interval_dto.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/producer_awards_interval/producer_awards_interval_dto.dart';

class AwardsIntervalMock {
  AwardsIntervalDto create() {
    return AwardsIntervalDto(
      max: List<ProducerAwardsIntervalDto>.generate(
        faker.randomGenerator.integer(10),
        (index) => createProducerAwardsIntervalMock(),
      ),
      min: List<ProducerAwardsIntervalDto>.generate(
        faker.randomGenerator.integer(10),
        (index) => createProducerAwardsIntervalMock(),
      ),
    );
  }

  ProducerAwardsIntervalDto createProducerAwardsIntervalMock() {
    return ProducerAwardsIntervalDto(
      producer: faker.person.name(),
      interval: faker.randomGenerator.integer(20),
      previousWin: createRandomYear(),
      followingWin: createRandomYear(),
    );
  }

  int createRandomYear() {
    return faker.randomGenerator.integer(min: 1950, 2024);
  }

  AwardsIntervalDto fromJson(Map<String, dynamic> json) {
    final max = json['max'] as List;
    final min = json['min'] as List;
    return AwardsIntervalDto(
      max: max.map((e) => ProducerAwardsIntervalDto.fromJson(e)).toList(),
      min: min.map((e) => ProducerAwardsIntervalDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> createProducerAwardsIntervalJson() {
    return {
      'producer': faker.person.name(),
      'interval': faker.randomGenerator.integer(20),
      'previousWin': createRandomYear(),
      'followingWin': createRandomYear(),
    };
  }

  Map<String, dynamic> createAwardsIntervalJson() {
    return {
      'max': List.generate(
        faker.randomGenerator.integer(
          10,
          min: 1,
        ),
        (index) => createProducerAwardsIntervalJson(),
      ).toList(),
      'min': List.generate(
        faker.randomGenerator.integer(
          10,
          min: 1,
        ),
        (index) => createProducerAwardsIntervalJson(),
      ).toList(),
    };
  }

  Map<String, dynamic> createProducerAwardsIntervalDtoJsonWithError() {
    return {
      'producer': faker.person.name(),
      'interval': faker.randomGenerator.integer(20),
      'previousWin': createRandomYear(),
    };
  }

  Map<String, dynamic> createAwardsIntervalDtoJsonWithError() {
    return {
      'max': List.generate(
        faker.randomGenerator.integer(10),
        (index) => createProducerAwardsIntervalDtoJsonWithError(),
      ).toList(),
      'min': List.generate(
        faker.randomGenerator.integer(10),
        (index) => createProducerAwardsIntervalDtoJsonWithError(),
      ).toList(),
    };
  }
}
