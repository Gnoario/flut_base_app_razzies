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

    //repositories
    i.addLazySingleton<GetMoviesImpRepository>(() async {
      return GetMoviesImpRepository(
        i(),
      );
    });

    //usecases
    i.addLazySingleton<GetMoviesImpUsecase>(() async {
      return GetMoviesImpUsecase(
        i(),
      );
    });
  }

  @override
  void routes(r) {}
}