import 'dart:async';

import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class DashboardPresenter implements Disposable, Listenable {
  Stream<bool> get isGetYearsWithMultipleWinnersLoading;
  Stream<bool> get isGetStudiosWithWinCountLoading;
  Stream<bool> get isGetMaxMinWinIntervalForProducersLoading;
  Stream<bool> get isGetWinnerPerYearLoading;
  int? get year;
  bool get isValidYear;
  Stream<String?> get yearError;
  Stream<ResultPresentation> get yearsWithMultipleWinners;
  Stream<ResultPresentation> get studiosWithWinCount;
  Stream<ResultPresentation> get maxMinWinIntervalForProducers;
  Stream<ResultPresentation> get winnerPerYear;

  Future<void> getYearsWithMultipleWinners();
  Future<void> getStudiosWithWinCount();
  Future<void> getMaxMinWinIntervalForProducers();
  Future<void> getWinnerPerYear();
  validateYear(String? year);
}
