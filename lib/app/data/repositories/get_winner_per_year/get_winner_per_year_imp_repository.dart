import '../../../domain/models/dtos/movie/movie_dto.dart';
import '../../../domain/repositories/get_winner_per_year/get_winner_per_year_repository.dart';
import '../../datasources/get_winner_per_year/get_winner_per_year_datasource.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_generic_exception.dart';

class GetWinnerPerYearImpRepository implements GetWinnerPerYearRepository {
  final GetWinnerPerYearDatasource _getWinnerPerYearDatasource;

  GetWinnerPerYearImpRepository(this._getWinnerPerYearDatasource);

  @override
  Future<MovieDto> call({
    required int year,
  }) async {
    try {
      return await _getWinnerPerYearDatasource(
        year: year,
      );
    } on HandledException catch (_) {
      rethrow;
    } catch (e) {
      throw HandledGenericException();
    }
  }
}
