import 'package:flut_base_app_razzies/app/domain/models/dtos/yearly_winners_count_dto/yearly_winners_count_dto.dart';

abstract class GetYearsWithMultipleWinnersDatasource {
  Future<List<YearlyWinnersCountDto>> call();
}
