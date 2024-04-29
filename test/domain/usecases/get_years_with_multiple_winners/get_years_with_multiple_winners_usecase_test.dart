import 'package:flut_base_app_razzies/app/data/datasources/get_years_with_multiple_winners/get_years_with_multiple_winners_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_years_with_multiple_winners/get_years_with_multiple_winners_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_years_with_multiple_winners/get_years_with_multiple_winners_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_years_with_multiple_winners/get_years_with_multiple_winners_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_years_with_multiple_winners/get_years_with_multiple_winners_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'get_years_with_multiple_winners_usecase_test.mocks.dart';

@GenerateMocks([GetYearsWithMultipleWinnersDatasource])
void main() {
  late final GetYearsWithMultipleWinnersDatasource datasource;
  late final GetYearsWithMultipleWinnersRepository repository;
  late final GetYearsWithMultipleWinnersUsecase usecase;

  setUpAll(() {
    datasource = MockGetYearsWithMultipleWinnersDatasource();
    repository = GetYearsWithMultipleWinnersImpRepository(datasource);
    usecase = GetYearsWithMultipleWinnersImpUsecase(repository);
  });

  group('Success Cases', () {});
}
