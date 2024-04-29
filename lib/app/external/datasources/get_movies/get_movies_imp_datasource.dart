import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';

import '../../../data/datasources/get_movies/get_movies_datasource.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';

class GetMoviesImpDatasource implements GetMoviesDatasource {
  final ClientHttps _clientHttps;

  GetMoviesImpDatasource(this._clientHttps);

  final _endpoint = '/movies';

  @override
  Future<PaginatedMoviesDto> call({
    String? query,
  }) async {
    final result = await _clientHttps.get('$_endpoint$query');

    return PaginatedMoviesDto.fromJson(result.data);
  }
}
