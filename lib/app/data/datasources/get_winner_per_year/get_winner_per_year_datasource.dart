import '../../../domain/models/dtos/movie/movie_dto.dart';

abstract class GetWinnerPerYearDatasource {
  Future<MovieDto> call({
    required int year,
  });
}
