import 'package:flut_base_app_razzies/app/domain/models/dtos/studio_win_count/studio_win_count_dto.dart';

import '../../../domain/repositories/get_studios_with_win_count/get_studios_with_win_count_repository.dart';
import '../../datasources/get_studios_with_win_count/get_studios_with_win_count_datasource.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_generic_exception.dart';

class GetStudiosWithWinCountImpRepository
    implements GetStudiosWithWinCountRepository {
  final GetStudiosWithWinCountDatasource _getStudionsWithWinCountDatasource;

  GetStudiosWithWinCountImpRepository(this._getStudionsWithWinCountDatasource);

  @override
  Future<List<StudioWinCountDto>> call() async {
    try {
      return await _getStudionsWithWinCountDatasource();
    } on HandledException catch (_) {
      rethrow;
    } catch (e) {
      throw HandledGenericException();
    }
  }
}
