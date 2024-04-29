import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';

abstract class GetMoviesDatasource {
  Future<PaginatedMoviesDto> call({
    String? query,
  });
}
