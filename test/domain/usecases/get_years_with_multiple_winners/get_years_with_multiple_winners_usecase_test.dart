import 'package:flut_base_app_razzies/app/data/datasources/get_years_with_multiple_winners/get_years_with_multiple_winners_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_years_with_multiple_winners/get_years_with_multiple_winners_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_years_with_multiple_winners/get_years_with_multiple_winners_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_years_with_multiple_winners/get_years_with_multiple_winners_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_years_with_multiple_winners/get_years_with_multiple_winners_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/yearly_winners_count_mock.dart';
import 'get_years_with_multiple_winners_usecase_test.mocks.dart';

@GenerateMocks([GetYearsWithMultipleWinnersDatasource])
void main() {
  late final GetYearsWithMultipleWinnersDatasource datasource;
  late final GetYearsWithMultipleWinnersRepository repository;
  late final GetYearsWithMultipleWinnersUsecase usecase;
  late final YearlyWinnersCountMock yearlyWinnersCountMock;

  setUpAll(() {
    datasource = MockGetYearsWithMultipleWinnersDatasource();
    repository = GetYearsWithMultipleWinnersImpRepository(datasource);
    usecase = GetYearsWithMultipleWinnersImpUsecase(repository);
    yearlyWinnersCountMock = YearlyWinnersCountMock();
  });

  group('Success Cases', () {
    test('Should return a list of YearlyWinnersCountDto normally', () async {
      final winnersCount = yearlyWinnersCountMock.createList();
      when(
        datasource(),
      ).thenAnswer(
        (_) async => winnersCount,
      );

      final result = await usecase();

      expect(result, winnersCount);
    });

    test('Should return a list of YearlyWinnersCountDto normally from json',
        () async {
      final winnersCount = yearlyWinnersCountMock.fromList(
        yearlyWinnersCountMock.createYearlyWinnersCountListJson(),
      );
      when(
        datasource(),
      ).thenAnswer(
        (_) async => winnersCount,
      );

      final result = await usecase();

      expect(result, winnersCount);
    });
  });

  group('Throw cases', () {
    test('Should throw a HandledException when json conversion failed',
        () async {
      when(
        datasource(),
      ).thenAnswer(
        (_) async => yearlyWinnersCountMock.fromList(
          yearlyWinnersCountMock.createYearlyWinnersCountListJsonWithError(),
        ),
      );

      expect(
        () async => await usecase(),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException', () async {
      when(
        datasource(),
      ).thenThrow(
        Exception(),
      );

      expect(
        () async => await usecase(),
        throwsA(isA<HandledGenericException>()),
      );
    });

    test('Should throw a HandledException', () async {
      when(
        datasource(),
      ).thenThrow(
        HandledException(),
      );

      expect(
        () async => await usecase(),
        throwsA(isA<HandledException>()),
      );
    });
  });
}
