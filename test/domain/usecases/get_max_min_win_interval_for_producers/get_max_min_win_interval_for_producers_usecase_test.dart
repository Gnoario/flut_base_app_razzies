import 'package:flut_base_app_razzies/app/data/datasources/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/awards_interval_mock.dart';
import 'get_max_min_win_interval_for_producers_usecase_test.mocks.dart';

@GenerateMocks([GetMaxMinWinIntervalForProducersDatasource])
void main() {
  late final GetMaxMinWinIntervalForProducersDatasource datasource;
  late final GetMaxMinWinIntervalForProducersRepository repository;
  late final GetMaxMinWinIntervalForProducersUsecase usecase;
  late final AwardsIntervalMock awardsIntervalMock;

  setUpAll(() {
    datasource = MockGetMaxMinWinIntervalForProducersDatasource();
    repository = GetMaxMinWinIntervalForProducersImpRepository(datasource);
    usecase = GetMaxMinWinIntervalForProducersImpUsecase(repository);
    awardsIntervalMock = AwardsIntervalMock();
  });

  group('Success Cases', () {
    test('Should return a AwardsIntervalDto normally', () async {
      final awardsMock = awardsIntervalMock.create();
      when(datasource()).thenAnswer((_) async => awardsMock);
      final result = await usecase();
      expect(result, awardsMock);
    });

    test('Should return a AwardsIntervalDto normally from json', () async {
      final awardsMock = awardsIntervalMock.fromJson(
        awardsIntervalMock.createAwardsIntervalJson(),
      );
      when(datasource()).thenAnswer((_) async => awardsMock);
      final result = await usecase();
      expect(result, awardsMock);
    });
  });

  group('Throws Cases', () {
    test('Should throw a HandledException when json conversion failed',
        () async {
      when(
        datasource(),
      ).thenAnswer(
        (_) async => awardsIntervalMock.fromJson(
          awardsIntervalMock.createAwardsIntervalDtoJsonWithError(),
        ),
      );

      expect(
        () async => await usecase(),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException when something goes wrong',
        () async {
      when(datasource()).thenThrow(Exception());
      expect(
          () async => await usecase(), throwsA(isA<HandledGenericException>()));
    });

    test('Should throw a HandledException when something goes wrong', () async {
      when(datasource()).thenThrow(HandledException());
      expect(() async => await usecase(), throwsA(isA<HandledException>()));
    });
  });
}
