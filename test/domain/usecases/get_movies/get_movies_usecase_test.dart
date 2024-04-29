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

  group('Success Cases', () {
    test('Should return a PaginatedMoviesDto normally', () async {
      final moviesMock = paginatedMoviesMock.create();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer((_) async => moviesMock);

      final result = await usecase(
        pagination: paginatedMoviesMock.createPaginationMock(),
        year: paginatedMoviesMock.createRandomYear(),
        winner: paginatedMoviesMock.createRandomWinner(),
      );

      expect(result, moviesMock);
    });

    test('Should return a PaginatedMoviesDto normally from json', () async {
      final moviesMock = paginatedMoviesMock.fromJson(
        paginatedMoviesMock.createPaginatedMoviesJson(),
      );
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => moviesMock,
      );

      final result = await usecase(
        pagination: paginatedMoviesMock.createPaginationMock(),
        year: paginatedMoviesMock.createRandomYear(),
        winner: paginatedMoviesMock.createRandomWinner(),
      );

      expect(result, moviesMock);
    });

    test('Should send the correct queries to the datasource', () async {
      final year = paginatedMoviesMock.createRandomYear();
      final winner = paginatedMoviesMock.createRandomWinner();
      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
        year: year,
        winner: winner,
      );

      var expectedQuery =
          '?page=${pagination.number}&size=${pagination.size}&year=$year&winner=$winner';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test(
        'Should send the correct pagination and year queries to the datasource',
        () async {
      final year = paginatedMoviesMock.createRandomYear();
      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
        year: year,
      );

      var expectedQuery =
          '?page=${pagination.number}&size=${pagination.size}&year=$year';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test(
        'Should send the correct pagination and winner queries to the datasource',
        () async {
      final winner = paginatedMoviesMock.createRandomWinner();
      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
        winner: winner,
      );

      var expectedQuery =
          '?page=${pagination.number}&size=${pagination.size}&winner=$winner';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test('Should send the correct pagination query to the datasource',
        () async {
      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
      );

      var expectedQuery = '?page=${pagination.number}&size=${pagination.size}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });
  });

  group('Throws Cases', () {
    test('Should return a HandledException when json conversion failed',
        () async {
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.fromJson(
          paginatedMoviesMock.createPaginatedMoviesJsonWithError(),
        ),
      );

      expect(
        () async => await usecase(
          pagination: paginatedMoviesMock.createPaginationMock(),
          year: paginatedMoviesMock.createRandomYear(),
          winner: paginatedMoviesMock.createRandomWinner(),
        ),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException', () async {
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenThrow(Exception());

      expect(
        () async => await usecase(
          pagination: paginatedMoviesMock.createPaginationMock(),
          year: paginatedMoviesMock.createRandomYear(),
          winner: paginatedMoviesMock.createRandomWinner(),
        ),
        throwsA(isA<HandledGenericException>()),
      );
    });

    test('Should throw a HandledException', () async {
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenThrow(HandledException());

      expect(
        () async => await usecase(
          pagination: paginatedMoviesMock.createPaginationMock(),
          year: paginatedMoviesMock.createRandomYear(),
          winner: paginatedMoviesMock.createRandomWinner(),
        ),
        throwsA(isA<HandledException>()),
      );
    });
  });
}
