import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';

import '../../../domain/repositories/get_movies/get_movies_repository.dart';
import '../../datasources/get_movies/get_movies_datasource.dart';

class GetMoviesImpRepository implements GetMoviesRepository {
  final GetMoviesDatasource _getMoviesDatasource;

  GetMoviesImpRepository(this._getMoviesDatasource);

  @override
  Future<PaginatedMoviesDto> call({
    String? query,
  }) async {
    try {
      return await _getMoviesDatasource(
        query: query,
      );
    } on HandledException catch (_) {
      rethrow;
    } catch (e) {
      throw HandledGenericException();
    }
  }
}
