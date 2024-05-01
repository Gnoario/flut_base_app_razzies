import 'package:flut_base_app_razzies/app/data/datasources/get_studios_with_win_count/get_studios_with_win_count_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_studios_with_win_count/get_studios_with_win_count_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_studios_with_win_count/get_studios_with_win_count_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_studios_with_win_count/get_studios_with_win_count_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_studios_with_win_count/get_studios_with_win_count_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/studio_win_count_mock.dart';
import 'get_studions_with_win_count_usecase_test.mocks.dart';

@GenerateMocks([GetStudiosWithWinCountDatasource])
void main() {
  late final GetStudiosWithWinCountDatasource datasource;
  late final GetStudiosWithWinCountRepository repository;
  late final GetStudiosWithWinCountUsecase usecase;
  late final StudioWinCountMock studioWinCountMock;

  setUpAll(() {
    datasource = MockGetStudiosWithWinCountDatasource();
    repository = GetStudiosWithWinCountImpRepository(datasource);
    usecase = GetStudiosWithWinCountImpUsecase(repository);
    studioWinCountMock = StudioWinCountMock();
  });

  group('Success Cases', () {
    test('Should return a list of StudioWinCountDto normally', () async {
      final studiosWinCount = studioWinCountMock.createList();
      when(
        datasource(),
      ).thenAnswer(
        (_) async => studiosWinCount,
      );

      final result = await usecase();

      expect(result, studiosWinCount);
    });

    test('Should return a list of StudioWinCountDto normally from json',
        () async {
      final studiosWinCount = studioWinCountMock.fromList(
        studioWinCountMock.createStudioWinCountListJson(),
      );
      when(
        datasource(),
      ).thenAnswer(
        (_) async => studiosWinCount,
      );

      final result = await usecase();

      expect(result, studiosWinCount);
    });
  });

  group('Throws cases', () {
    test('Should throw a HandledException when json conversion failed',
        () async {
      when(
        datasource(),
      ).thenAnswer(
        (_) async => studioWinCountMock.fromList(
          studioWinCountMock.createStudioWinCountListJsonWithError(),
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
      ).thenThrow(Exception());

      expect(
        () async => await usecase(),
        throwsA(isA<HandledGenericException>()),
      );
    });

    test('Should throw a HandledException', () async {
      when(
        datasource(),
      ).thenThrow(HandledException());

      expect(
        () async => await usecase(),
        throwsA(isA<HandledException>()),
      );
    });
  });
}
