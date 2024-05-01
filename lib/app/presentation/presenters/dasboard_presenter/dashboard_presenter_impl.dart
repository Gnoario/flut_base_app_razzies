import 'dart:async';
import 'dart:ui';

import 'package:flut_base_app_razzies/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_presenter.dart';

class DashboardPresenterImpl implements DashboardPresenter {
  final GetYearsWithMultipleWinnersUsecase _getYearsWithMultipleWinnersUsecase;
  final GetStudiosWithWinCountUsecase _getStudiosWithWinCountUsecase;
  final GetMaxMinWinIntervalForProducersUsecase
      _getMaxMinWinIntervalForProducersUsecase;
  final GetWinnerPerYearUsecase _getWinnerPerYearUsecase;

  DashboardPresenterImpl(
    this._getYearsWithMultipleWinnersUsecase,
    this._getStudiosWithWinCountUsecase,
    this._getMaxMinWinIntervalForProducersUsecase,
    this._getWinnerPerYearUsecase,
  );

  @override
  Stream<bool> get isGetMaxMinWinIntervalForProducersLoading =>
      _getMaxMinWinIntervalForProducersLoadingController.stream
          .asBroadcastStream();

  @override
  Stream<bool> get isGetStudiosWithWinCountLoading =>
      _getStudiosWithWinCountLoadingController.stream.asBroadcastStream();

  @override
  Stream<bool> get isGetWinnerPerYearLoading =>
      _getWinnerPerYearLoadingController.stream.asBroadcastStream();

  @override
  Stream<bool> get isGetYearsWithMultipleWinnersLoading =>
      _getYearsWithMultipleWinnersLoadingController.stream.asBroadcastStream();

  @override
  bool isValidYear = false;

  @override
  Stream<String?> get yearError =>
      _yearErrorController.stream.asBroadcastStream();

  @override
  int? year;

  @override
  Stream<ResultPresentation> get maxMinWinIntervalForProducers =>
      _maxMinWinIntervalForProducersController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get studiosWithWinCount =>
      _studiosWithWinCountController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get winnerPerYear =>
      _winnerPerYearController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get yearsWithMultipleWinners =>
      _yearsWithMultipleWinnersController.stream.asBroadcastStream();

  final StreamController<bool>
      _getMaxMinWinIntervalForProducersLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> _getStudiosWithWinCountLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> _getWinnerPerYearLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> _getYearsWithMultipleWinnersLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<String?> _yearErrorController =
      StreamController<String?>.broadcast();

  final StreamController<ResultPresentation>
      _maxMinWinIntervalForProducersController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation> _studiosWithWinCountController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation> _winnerPerYearController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation>
      _yearsWithMultipleWinnersController =
      StreamController<ResultPresentation>.broadcast();

  @override
  void dispose() {
    _getMaxMinWinIntervalForProducersLoadingController.close();
    _getStudiosWithWinCountLoadingController.close();
    _getWinnerPerYearLoadingController.close();
    _getYearsWithMultipleWinnersLoadingController.close();
    _yearErrorController.close();
    _maxMinWinIntervalForProducersController.close();
    _studiosWithWinCountController.close();
    _winnerPerYearController.close();
    _yearsWithMultipleWinnersController.close();
  }

  @override
  Future<void> getMaxMinWinIntervalForProducers() async {
    try {
      _getMaxMinWinIntervalForProducersLoadingController.add(true);
      final result = await _getMaxMinWinIntervalForProducersUsecase();
      final resultPresentation = ResultPresentation(payload: result.toJson());
      _maxMinWinIntervalForProducersController.add(resultPresentation);
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _maxMinWinIntervalForProducersController.add(resultPresentation);
    } finally {
      _getMaxMinWinIntervalForProducersLoadingController.add(false);
    }
  }

  @override
  Future<void> getStudiosWithWinCount() async {
    try {
      _getStudiosWithWinCountLoadingController.add(true);
      final result = await _getStudiosWithWinCountUsecase();
      final resultPresentation = ResultPresentation(
        payload: result.map((e) => e.toJson()).toList(),
      );
      _studiosWithWinCountController.add(resultPresentation);
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _studiosWithWinCountController.add(resultPresentation);
    } finally {
      _getStudiosWithWinCountLoadingController.add(false);
    }
  }

  @override
  Future<void> getWinnerPerYear() async {
    try {
      if (!isValidYear) {
        final resultPresentation = ResultPresentation(
          success: false,
          message: 'Invalid year',
        );
        _yearErrorController.add('Year is required');
        _winnerPerYearController.add(resultPresentation);
        return;
      }
      _getWinnerPerYearLoadingController.add(true);
      final result = await _getWinnerPerYearUsecase(year: year!);
      final resultPresentation = ResultPresentation(payload: [
        result.toJson(),
      ]);
      _winnerPerYearController.add(resultPresentation);
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _winnerPerYearController.add(resultPresentation);
    } finally {
      _getWinnerPerYearLoadingController.add(false);
    }
  }

  @override
  Future<void> getYearsWithMultipleWinners() async {
    try {
      _getYearsWithMultipleWinnersLoadingController.add(true);
      final result = await _getYearsWithMultipleWinnersUsecase();
      final resultPresentation = ResultPresentation(
        payload: result.map((e) => e.toJson()).toList(),
      );
      _yearsWithMultipleWinnersController.add(resultPresentation);
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _yearsWithMultipleWinnersController.add(resultPresentation);
    } finally {
      _getYearsWithMultipleWinnersLoadingController.add(false);
    }
  }

  @override
  Future<void> validateYear(String? year) async {
    if ((year ?? '').isEmpty) {
      isValidYear = false;
      _yearErrorController.add('Year is required');
      return;
    }

    final yearInt = int.tryParse(year!);
    if (yearInt == null) {
      isValidYear = false;
      _yearErrorController.add('Year must be a number');
      return;
    }

    if (yearInt < 1927 || yearInt > DateTime.now().year) {
      isValidYear = false;
      _yearErrorController.add(
        'Year must be between 1927 and ${DateTime.now().year}',
      );
      return;
    }

    isValidYear = true;
    this.year = yearInt;
    _yearErrorController.add(null);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
