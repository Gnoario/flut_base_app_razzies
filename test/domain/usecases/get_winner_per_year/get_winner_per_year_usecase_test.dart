import 'package:flut_base_app_razzies/app/data/datasources/get_winner_per_year/get_winner_per_year_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_winner_per_year/get_winner_per_year_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';
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

    test('Should return a MovieDto normally from json', () async {
      final movieMock = mock.fromJson(
        mock.createMovieJson(),
      );
      final year = mock.createRandomYear();
      when(
        datasource(year: year),
      ).thenAnswer(
        (_) async => movieMock,
      );

      final result = await usecase(year: year);

      expect(result, movieMock);
    });

    test('Should send the correct year param to the datasource', () async {
      final year = mock.createRandomYear();
      when(
        datasource(
          year: year,
        ),
      ).thenAnswer(
        (_) async => mock.createMovieMock(),
      );

      await usecase(
        year: year,
      );

      var expectedResult = year;
      verify(
        datasource(year: expectedResult),
      ).called(1);
    });
  });

  group('Throws Cases', () {
    test('Should throw a HandledException when json conversion failed',
        () async {
      final year = mock.createRandomYear();
      when(
        datasource(
          year: year,
        ),
      ).thenAnswer(
        (_) async => mock.fromJson(
          mock.createMovieJsonWithError(),
        ),
      );

      expect(
        () async => await usecase(year: year),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException when something goes wrong',
        () async {
      final year = mock.createRandomYear();
      when(datasource(year: year)).thenThrow(Exception());
      expect(() async => await usecase(year: 2021),
          throwsA(isA<HandledGenericException>()));
    });

    test('Should throw a HandledException when something goes wrong', () async {
      final year = mock.createRandomYear();
      when(datasource(year: year)).thenThrow(HandledException());
      expect(
        () async => await usecase(year: year),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });
  });
}
