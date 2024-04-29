import 'package:flut_base_app_razzies/app/data/datasources/get_studios_with_win_count/get_studios_with_win_count_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_studios_with_win_count/get_studios_with_win_count_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_studios_with_win_count/get_studios_with_win_count_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_studios_with_win_count/get_studios_with_win_count_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_studios_with_win_count/get_studios_with_win_count_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

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
    repository = GetStudionsWithWinCountImpRepository(datasource);
    usecase = GetStudionsWithWinCountImpUsecase(repository);
    studioWinCountMock = StudioWinCountMock();
  });
}
