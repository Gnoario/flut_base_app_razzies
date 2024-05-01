import 'package:flut_base_app_razzies/app/data/repositories/repositories.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_razzies/app/external/datasources/datasources.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_page.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dashboard_presenter_spy.dart';

class AppModuleSpy extends Module {
  @override
  void binds(i) {
    //services
    i.addLazySingleton<ClientHttps>(() {
      return ClientHttps(
        interceptors: [
          ErrorHandleInterceptor(),
          HeadersInterceptors(),
          LoggersInterceptors(),
        ],
      );
    });

    //datasources
    i.addLazySingleton<GetMoviesDatasource>(GetMoviesImpDatasource.new);
    i.addLazySingleton<GetYearsWithMultipleWinnersDatasource>(
      GetYearsWithMultipleWinnersImpDatasource.new,
    );
    i.addLazySingleton<GetStudiosWithWinCountDatasource>(
      GetStudiosWithWinCountImpDatasource.new,
    );
    i.addLazySingleton<GetMaxMinWinIntervalForProducersDatasource>(
      GetMaxMinWinIntervalForProducersImpDatasource.new,
    );
    i.addLazySingleton<GetWinnerPerYearDatasource>(
      GetWinnerPerYearImpDatasource.new,
    );

    //repositories
    i.addLazySingleton<GetMoviesRepository>(
      GetMoviesImpRepository.new,
    );
    i.addLazySingleton<GetYearsWithMultipleWinnersRepository>(
      GetYearsWithMultipleWinnersImpRepository.new,
    );
    i.addLazySingleton<GetStudiosWithWinCountRepository>(
      GetStudiosWithWinCountImpRepository.new,
    );
    i.addLazySingleton<GetMaxMinWinIntervalForProducersRepository>(
      GetMaxMinWinIntervalForProducersImpRepository.new,
    );
    i.addLazySingleton<GetWinnerPerYearRepository>(
      GetWinnerPerYearImpRepository.new,
    );

    //usecases
    i.addLazySingleton<GetMoviesUsecase>(
      GetMoviesImpUsecase.new,
    );
    i.addLazySingleton<GetYearsWithMultipleWinnersUsecase>(
      GetYearsWithMultipleWinnersImpUsecase.new,
    );
    i.addLazySingleton<GetStudiosWithWinCountUsecase>(
      GetStudiosWithWinCountImpUsecase.new,
    );
    i.addLazySingleton<GetMaxMinWinIntervalForProducersUsecase>(
      GetMaxMinWinIntervalForProducersImpUsecase.new,
    );
    i.addLazySingleton<GetWinnerPerYearUsecase>(
      GetWinnerPerYearImpUsecase.new,
    );

    //presenters
    i.addLazySingleton<DashboardPresenter>(
      DashboardPresenterSpy.new,
      config: BindConfig(),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const DashboardPage());
  }
}
