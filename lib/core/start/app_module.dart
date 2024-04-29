import 'package:flut_base_app_razzies/app/data/repositories/repositories.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_razzies/app/external/datasources/datasources.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    //services
    i.addLazySingleton<ClientHttps>(() async {
      return ClientHttps(
        interceptors: [
          ErrorHandleInterceptor(),
          HeadersInterceptors(),
          LoggersInterceptors(),
        ],
      );
    });

    //datasources
    i.addLazySingleton<GetMoviesImpDatasource>(() async {
      return GetMoviesImpDatasource(
        i(),
      );
    });
    i.addLazySingleton<GetYearsWithMultipleWinnersImpDatasource>(() async {
      return GetYearsWithMultipleWinnersImpDatasource(
        i(),
      );
    });
    i.addLazySingleton<GetStudiosWithWinCountImpDatasource>(() async {
      return GetStudiosWithWinCountImpDatasource(
        i(),
      );
    });
    i.addLazySingleton<GetMaxMinWinIntervalForProducersImpDatasource>(() async {
      return GetMaxMinWinIntervalForProducersImpDatasource(
        i(),
      );
    });
    i.addLazySingleton<GetWinnerPerYearImpDatasource>(() async {
      return GetWinnerPerYearImpDatasource(
        i(),
      );
    });

    //repositories
    i.addLazySingleton<GetMoviesImpRepository>(() async {
      return GetMoviesImpRepository(
        i(),
      );
    });
    i.addLazySingleton<GetYearsWithMultipleWinnersImpRepository>(() async {
      return GetYearsWithMultipleWinnersImpRepository(
        i(),
      );
    });
    i.addLazySingleton<GetStudiosWithWinCountImpRepository>(() async {
      return GetStudiosWithWinCountImpRepository(
        i(),
      );
    });
    i.addLazySingleton<GetMaxMinWinIntervalForProducersImpRepository>(() async {
      return GetMaxMinWinIntervalForProducersImpRepository(
        i(),
      );
    });
    i.addLazySingleton<GetWinnerPerYearImpRepository>(() async {
      return GetWinnerPerYearImpRepository(
        i(),
      );
    });

    //usecases
    i.addLazySingleton<GetMoviesImpUsecase>(() async {
      return GetMoviesImpUsecase(
        i(),
      );
    });
    i.addLazySingleton<GetYearsWithMultipleWinnersImpUsecase>(() async {
      return GetYearsWithMultipleWinnersImpUsecase(
        i(),
      );
    });
    i.addLazySingleton<GetStudiosWithWinCountImpUsecase>(() async {
      return GetStudiosWithWinCountImpUsecase(
        i(),
      );
    });
    i.addLazySingleton<GetMaxMinWinIntervalForProducersImpUsecase>(() async {
      return GetMaxMinWinIntervalForProducersImpUsecase(
        i(),
      );
    });
    i.addLazySingleton<GetWinnerPerYearImpUsecase>(() async {
      return GetWinnerPerYearImpUsecase(
        i(),
      );
    });
  }

  @override
  void routes(r) {}
}
