import '../../models/dtos/movie/movie_dto.dart';

abstract class GetWinnerPerYearUsecase {
  Future<MovieDto> call({
    required int year,
  });
}
