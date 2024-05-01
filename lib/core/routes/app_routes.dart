import 'package:flutter_modular/flutter_modular.dart';

class AppRoutes {
  static goToRoute(String route) async {
    return Modular.to.pushNamed(route);
  }

  static void pop<T extends Object>([T? result]) {
    if (result != null) {
      Modular.to.pop(result);
      return;
    }

    Modular.to.pop();
  }

  AppRoutes._();
}
