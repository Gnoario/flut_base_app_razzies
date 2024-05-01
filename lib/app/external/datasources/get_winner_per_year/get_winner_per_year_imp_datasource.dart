import '../../../data/datasources/get_winner_per_year/get_winner_per_year_datasource.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';

import '../../../domain/models/dtos/movie/movie_dto.dart';

class GetWinnerPerYearImpDatasource implements GetWinnerPerYearDatasource {
  final ClientHttps _clientHttps;

  GetWinnerPerYearImpDatasource(this._clientHttps);

  final _endpoint = '/movies?winner=true';

  @override
  Future<MovieDto> call({
    required int year,
  }) async {
    final result = await _clientHttps.get('$_endpoint&year=$year');
    final data = result.data as List;
    return MovieDto.fromJson(data.first);
  }
}
