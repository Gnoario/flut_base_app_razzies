import 'package:flut_base_app_razzies/app/data/datasources/get_winner_per_year/get_winner_per_year_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_winner_per_year/get_winner_per_year_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_winner_per_year/get_winner_per_year_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_winner_per_year/get_winner_per_year_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_winner_per_year/get_winner_per_year_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/movie_mock.dart';
import 'get_winner_per_year_usecase_test.mocks.dart';

@GenerateMocks([GetWinnerPerYearDatasource])
void main() {
  late final GetWinnerPerYearDatasource datasource;
  late final GetWinnerPerYearRepository repository;
  late final GetWinnerPerYearUsecase usecase;
  late final MovieMock mock;

  setUpAll(() {
    datasource = MockGetWinnerPerYearDatasource();
    repository = GetWinnerPerYearImpRepository(datasource);
    usecase = GetWinnerPerYearImpUsecase(repository);
    mock = MovieMock();
  });

  group('Success Cases', () {
    test('Should return a MovieDto normally', () async {
      final movieMock = mock.createMovieMock();
      when(datasource(year: 2021)).thenAnswer((_) async => movieMock);
      final result = await usecase(year: 2021);
      expect(result, movieMock);
    });
  });
}
