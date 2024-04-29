import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
      title: 'Razzies',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
    );
  }
}
