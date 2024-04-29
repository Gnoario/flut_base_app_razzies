import '../../models/dtos/movie/movie_dto.dart';
import 'get_winner_per_year_usecase.dart';
import '../../repositories/get_winner_per_year/get_winner_per_year_repository.dart';

class GetWinnerPerYearImpUsecase implements GetWinnerPerYearUsecase {
  final GetWinnerPerYearRepository _getWinnerPerYearRepository;

  GetWinnerPerYearImpUsecase(this._getWinnerPerYearRepository);

  @override
  Future<MovieDto> call({
    required int year,
  }) async {
    return await _getWinnerPerYearRepository(
      year: year,
    );
  }
}
