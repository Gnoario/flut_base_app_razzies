import 'package:flut_base_app_razzies/app/data/datasources/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_datasource.dart';
import 'package:flut_base_app_razzies/app/data/repositories/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_imp_repository.dart';
import 'package:flut_base_app_razzies/app/domain/repositories/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_repository.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_imp_usecase.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'get_max_min_win_interval_for_producers_usecase_test.mocks.dart';

@GenerateMocks([GetMaxMinWinIntervalForProducersDatasource])
void main() {
  late final GetMaxMinWinIntervalForProducersDatasource datasource;
  late final GetMaxMinWinIntervalForProducersRepository repository;
  late final GetMaxMinWinIntervalForProducersUsecase usecase;

  setUpAll(() {
    datasource = MockGetMaxMinWinIntervalForProducersDatasource();
    repository = GetMaxMinWinIntervalForProducersImpRepository(datasource);
    usecase = GetMaxMinWinIntervalForProducersImpUsecase(repository);
  });
}
