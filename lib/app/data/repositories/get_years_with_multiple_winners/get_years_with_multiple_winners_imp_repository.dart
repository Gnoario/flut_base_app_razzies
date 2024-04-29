import 'package:flut_base_app_razzies/app/domain/models/dtos/yearly_winners_count_dto/yearly_winners_count_dto.dart';
import '../../../domain/repositories/get_years_with_multiple_winners/get_years_with_multiple_winners_repository.dart';
import '../../datasources/get_years_with_multiple_winners/get_years_with_multiple_winners_datasource.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_generic_exception.dart';

class GetYearsWithMultipleWinnersImpRepository
    implements GetYearsWithMultipleWinnersRepository {
  final GetYearsWithMultipleWinnersDatasource
      _getYearsWithMultipleWinnersDatasource;

  GetYearsWithMultipleWinnersImpRepository(
    this._getYearsWithMultipleWinnersDatasource,
  );

  @override
  Future<List<YearlyWinnersCountDto>> call() async {
    try {
      return await _getYearsWithMultipleWinnersDatasource();
    } on HandledException catch (_) {
      rethrow;
    } catch (e) {
      throw HandledGenericException();
    }
  }
}
