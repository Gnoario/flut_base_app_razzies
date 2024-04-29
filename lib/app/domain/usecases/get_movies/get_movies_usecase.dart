import 'package:flut_base_app_razzies/app/domain/models/dtos/movie/paginated_movies_dto.dart';

import '../../models/dtos/pagination/pagination_dto.dart';

abstract class GetMoviesUsecase {
  Future<PaginatedMoviesDto> call({
    required PaginationDto pagination,
    int? year,
    bool? winner,
  });
}
