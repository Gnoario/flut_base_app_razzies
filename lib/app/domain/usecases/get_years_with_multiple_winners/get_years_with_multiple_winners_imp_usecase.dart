import 'package:flut_base_app_razzies/app/domain/models/dtos/yearly_winners_count_dto/yearly_winners_count_dto.dart';

import 'get_years_with_multiple_winners_usecase.dart';
import '../../repositories/get_years_with_multiple_winners/get_years_with_multiple_winners_repository.dart';

class GetYearsWithMultipleWinnersImpUsecase
    implements GetYearsWithMultipleWinnersUsecase {
  final GetYearsWithMultipleWinnersRepository
      _getYearsWithMultipleWinnersRepository;

  GetYearsWithMultipleWinnersImpUsecase(
    this._getYearsWithMultipleWinnersRepository,
  );

  @override
  Future<List<YearlyWinnersCountDto>> call() async {
    return await _getYearsWithMultipleWinnersRepository();
  }
}
