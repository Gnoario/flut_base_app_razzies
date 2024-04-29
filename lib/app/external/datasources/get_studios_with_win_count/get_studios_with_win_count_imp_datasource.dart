import 'package:flut_base_app_razzies/app/domain/models/dtos/studio_win_count/studio_win_count_dto.dart';

import '../../../data/datasources/get_studios_with_win_count/get_studios_with_win_count_datasource.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';

class GetStudiosWithWinCountImpDatasource
    implements GetStudiosWithWinCountDatasource {
  final ClientHttps _clientHttps;

  GetStudiosWithWinCountImpDatasource(this._clientHttps);

  final _endpoint = '/movies?projection=studios-with-win-count';

  @override
  Future<List<StudioWinCountDto>> call() async {
    final result = await _clientHttps.get(_endpoint);
    final data = result.data as List;
    return data.map((e) => StudioWinCountDto.fromJson(e)).toList();
  }
}
