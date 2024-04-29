import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';

abstract class GetMoviesRepository {
  Future<PaginatedMoviesDto> call({
    String? query,
  });
}
