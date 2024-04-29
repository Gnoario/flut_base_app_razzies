import '../../../data/datasources/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_datasource.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';

import '../../../domain/models/dtos/awards_interval/awards_interval_dto.dart';

class GetMaxMinWinIntervalForProducersImpDatasource
    implements GetMaxMinWinIntervalForProducersDatasource {
  final ClientHttps _clientHttps;

  GetMaxMinWinIntervalForProducersImpDatasource(this._clientHttps);

  final _endpoint = '/movies?projection=max-min-win-interval-for-producers';

  @override
  Future<AwardsIntervalDto> call() async {
    final result = await _clientHttps.get(_endpoint);
    return AwardsIntervalDto.fromJson(result.data);
  }
}
