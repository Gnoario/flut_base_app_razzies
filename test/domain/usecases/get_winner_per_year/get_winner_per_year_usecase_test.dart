import 'package:flut_base_app_razzies/app/data/datasources/get_winner_per_year/get_winner_per_year_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_winner_per_year/get_winner_per_year_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_winner_per_year/get_winner_per_year_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_winner_per_year/get_winner_per_year_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_winner_per_year/get_winner_per_year_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'get_winner_per_year_usecase_test.mocks.dart';

@GenerateMocks([GetWinnerPerYearDatasource])
void main() {
  late final GetWinnerPerYearDatasource datasource;
  late final GetWinnerPerYearRepository repository;
  late final GetWinnerPerYearUsecase usecase;

  setUp(() {
    datasource = MockGetWinnerPerYearDatasource();
    repository = GetWinnerPerYearImpRepository(datasource);
    usecase = GetWinnerPerYearImpUsecase(repository);
  });
}
