import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';

import '../../models/dtos/pagination/pagination_dto.dart';
import 'get_movies_usecase.dart';
import '../../repositories/get_movies/get_movies_repository.dart';

class GetMoviesImpUsecase implements GetMoviesUsecase {
  final GetMoviesRepository _getMoviesRepository;

  GetMoviesImpUsecase(this._getMoviesRepository);

  @override
  Future<PaginatedMoviesDto> call({
    required PaginationDto pagination,
    int? year,
    bool? winner,
  }) async {
    return await _getMoviesRepository(
      query: _buildQuery(pagination, year, winner),
    );
  }

  _buildQuery(PaginationDto pagination, int? year, bool? winner) {
    final query =
        StringBuffer('?page=${pagination.number}&size=${pagination.size}');
    if (year != null) {
      query.write('&year=$year');
    }
    if (winner != null) {
      query.write('&winner=$winner');
    }
    return query.toString();
  }
}
