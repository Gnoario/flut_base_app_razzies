import '../../../domain/models/dtos/awards_interval/awards_interval_dto.dart';
import '../../../domain/repositories/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_repository.dart';
import '../../datasources/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_datasource.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_generic_exception.dart';

class GetMaxMinWinIntervalForProducersImpRepository
    implements GetMaxMinWinIntervalForProducersRepository {
  final GetMaxMinWinIntervalForProducersDatasource
      _getMaxMinWinIntervalForProducersDatasource;

  GetMaxMinWinIntervalForProducersImpRepository(
    this._getMaxMinWinIntervalForProducersDatasource,
  );

  @override
  Future<AwardsIntervalDto> call() async {
    try {
      return await _getMaxMinWinIntervalForProducersDatasource();
    } on HandledException catch (_) {
      rethrow;
    } catch (e) {
      throw HandledGenericException();
    }
  }
}
