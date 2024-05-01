import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/movie_dto.dart';

abstract class GetWinnerPerYearRepository {
  Future<MovieDto> call({
    required int year,
  });
}
