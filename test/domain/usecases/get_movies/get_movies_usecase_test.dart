import 'package:flut_base_app_razzies/app/data/datasources/get_movies/get_movies_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/repositories.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_movies/get_movies_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/paginated_movies_mock.dart';
import 'get_movies_usecase_test.mocks.dart';

@GenerateMocks([GetMoviesDatasource])
void main() {
  late final GetMoviesDatasource datasource;
  late final GetMoviesRepository repository;
  late final GetMoviesUsecase usecase;
  late final PaginatedMoviesMock paginatedMoviesMock;

  setUpAll(() {
    datasource = MockGetMoviesDatasource();
    repository = GetMoviesImpRepository(datasource);
    usecase = GetMoviesImpUsecase(repository);
    paginatedMoviesMock = PaginatedMoviesMock();
  });
}
