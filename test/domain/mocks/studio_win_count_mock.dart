import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/models/dtos/studio_win_count/studio_win_count_dto.dart';

class StudioWinCountMock {
  StudioWinCountDto create() {
    return StudioWinCountDto(
      name: faker.company.name(),
      winCount: faker.randomGenerator.integer(99),
    );
  }

  List<StudioWinCountDto> createList() {
    return List.generate(
      faker.randomGenerator.integer(10),
      (index) => create(),
    );
  }

  StudioWinCountDto _fromJson(Map<String, dynamic> json) {
    return StudioWinCountDto.fromJson(json);
  }

  List<StudioWinCountDto> fromList(List<Map<String, dynamic>> json) {
    final list = json as List;
    return list.map((e) => _fromJson(e)).toList();
  }

  Map<String, dynamic> _createStudioWinCountJson() {
    return {
      'name': faker.company.name(),
      'winCount': faker.randomGenerator.integer(99),
    };
  }

  Map<String, dynamic> _createStudioWinCountJsonWithError() {
    return {
      'winCount': faker.randomGenerator.integer(99),
    };
  }

  List<Map<String, dynamic>> createStudioWinCountListJson() {
    return List.generate(
      faker.randomGenerator.integer(10),
      (index) => _createStudioWinCountJson(),
    );
  }

  List<Map<String, dynamic>> createStudioWinCountListJsonWithError() {
    return List.generate(
      faker.randomGenerator.integer(10),
      (index) => _createStudioWinCountJsonWithError(),
    );
  }
}
