import 'dart:async';
import 'dart:ui';

import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:mockito/mockito.dart';

class DashboardPresenterSpy extends Mock implements DashboardPresenter {
  bool getWinnerPerYearCalled = false;

  bool getYearsWithMultipleWinnersCalled = false;

  bool getMaxMinWinIntervalForProducersCalled = false;

  bool getStudiosWithWinCountCalled = false;

  bool validateYearCalled = false;

  @override
  Stream<bool> get isGetMaxMinWinIntervalForProducersLoading =>
      getMaxMinWinIntervalForProducersLoadingController.stream
          .asBroadcastStream();

  @override
  Stream<bool> get isGetStudiosWithWinCountLoading =>
      getStudiosWithWinCountLoadingController.stream.asBroadcastStream();

  @override
  Stream<bool> get isGetWinnerPerYearLoading =>
      getWinnerPerYearLoadingController.stream.asBroadcastStream();

  @override
  Stream<bool> get isGetYearsWithMultipleWinnersLoading =>
      getYearsWithMultipleWinnersLoadingController.stream.asBroadcastStream();

  @override
  bool isValidYear = false;

  @override
  Stream<String?> get yearError =>
      yearErrorController.stream.asBroadcastStream();

  @override
  int? year;

  @override
  Stream<ResultPresentation> get maxMinWinIntervalForProducers =>
      maxMinWinIntervalForProducersController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get studiosWithWinCount =>
      studiosWithWinCountController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get winnerPerYear =>
      winnerPerYearController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get yearsWithMultipleWinners =>
      yearsWithMultipleWinnersController.stream.asBroadcastStream();

  final StreamController<bool>
      getMaxMinWinIntervalForProducersLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> getStudiosWithWinCountLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> getWinnerPerYearLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> getYearsWithMultipleWinnersLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<String?> yearErrorController =
      StreamController<String?>.broadcast();

  final StreamController<ResultPresentation>
      maxMinWinIntervalForProducersController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation> studiosWithWinCountController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation> winnerPerYearController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation>
      yearsWithMultipleWinnersController =
      StreamController<ResultPresentation>.broadcast();

  @override
  Future<void> getWinnerPerYear() {
    getWinnerPerYearCalled = true;
    return super.noSuchMethod(Invocation.method(#getWinnerPerYear, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  @override
  Future<void> getYearsWithMultipleWinners() {
    getYearsWithMultipleWinnersCalled = true;
    return super.noSuchMethod(Invocation.method(#getWinnerPerYear, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  @override
  Future<void> getMaxMinWinIntervalForProducers() {
    getMaxMinWinIntervalForProducersCalled = true;
    return super.noSuchMethod(Invocation.method(#getWinnerPerYear, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  @override
  Future<void> getStudiosWithWinCount() {
    getStudiosWithWinCountCalled = true;
    return super.noSuchMethod(Invocation.method(#getWinnerPerYear, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  @override
  Future<void> validateYear(String? year) {
    validateYearCalled = true;
    return super.noSuchMethod(Invocation.method(#getWinnerPerYear, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  emitMaxMinWinIntervalForProducersLoading(bool isLoading) =>
      getMaxMinWinIntervalForProducersLoadingController.add(isLoading);

  emitStudiosWithWinCountLoading(bool isLoading) =>
      getStudiosWithWinCountLoadingController.add(isLoading);

  emitWinnerPerYearLoading(bool isLoading) =>
      getWinnerPerYearLoadingController.add(isLoading);

  emitYearsWithMultipleWinnersLoading(bool isLoading) =>
      getYearsWithMultipleWinnersLoadingController.add(isLoading);

  emitYearError(String? error) => yearErrorController.add(error);

  emitMaxMinWinIntervalForProducers(ResultPresentation result) =>
      maxMinWinIntervalForProducersController.add(result);

  emitStudiosWithWinCount(ResultPresentation result) =>
      studiosWithWinCountController.add(result);

  emitWinnerPerYear(ResultPresentation result) =>
      winnerPerYearController.add(result);

  emitYearsWithMultipleWinners(ResultPresentation result) =>
      yearsWithMultipleWinnersController.add(result);

  emitLoadings({loading = true}) {
    emitMaxMinWinIntervalForProducersLoading(loading);
    emitStudiosWithWinCountLoading(loading);
    emitWinnerPerYearLoading(loading);
    emitYearsWithMultipleWinnersLoading(loading);
  }

  @override
  void dispose() {
    getMaxMinWinIntervalForProducersLoadingController.close();
    getStudiosWithWinCountLoadingController.close();
    getWinnerPerYearLoadingController.close();
    getYearsWithMultipleWinnersLoadingController.close();
    yearErrorController.close();
    maxMinWinIntervalForProducersController.close();
    studiosWithWinCountController.close();
    winnerPerYearController.close();
    yearsWithMultipleWinnersController.close();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
