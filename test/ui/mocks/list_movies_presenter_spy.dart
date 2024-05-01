import 'dart:async';

import 'package:flut_base_app_razzies/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/app/ui/pages/list_movies/list_movies_presenter.dart';
import 'package:mockito/mockito.dart';

class ListMoviesPresenterSpy extends Mock implements ListMoviesPresenter {
  bool validateYearCalled = false;
  bool setWinnerCalled = false;
  bool getMoviesCalled = false;

  @override
  Stream<bool> get isGetMoviesLoading =>
      _isGetMoviesLoadingController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get movies =>
      _moviesController.stream.asBroadcastStream();

  @override
  Stream<PaginationDto> get pagination =>
      _paginationController.stream.asBroadcastStream();

  @override
  Stream<String?> get yearError =>
      _yearErrorController.stream.asBroadcastStream();

  final StreamController<bool> _isGetMoviesLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<ResultPresentation> _moviesController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<PaginationDto> _paginationController =
      StreamController<PaginationDto>.broadcast();

  final StreamController<String?> _yearErrorController =
      StreamController<String?>.broadcast();

  @override
  int? year;

  @override
  bool? winner;

  @override
  PaginationDto? currentPage = PaginationDto(size: 15, number: 1);

  @override
  PaginationController? paginationController = PaginationController();

  @override
  bool isValidYear = false;

  @override
  Future<void> getMovies(int page) {
    getMoviesCalled = true;
    return super.noSuchMethod(Invocation.method(#getMovies, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  @override
  validateYear(String? year) {
    validateYearCalled = true;
    getMovies(1);
    return super.noSuchMethod(Invocation.method(#getWinnerPerYear, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  @override
  setWinner(String? winner) {
    setWinnerCalled = true;
    getMovies(1);
    return super.noSuchMethod(Invocation.method(#setWinner, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  emitMovies(ResultPresentation result) {
    _moviesController.add(result);
  }

  emitPagination(PaginationDto pagination) {
    _paginationController.add(pagination);
  }

  emitIsGetMoviesLoading(bool isLoading) {
    _isGetMoviesLoadingController.add(isLoading);
  }

  emitYearError(String? error) {
    _yearErrorController.add(error);
  }

  emitYear(int year) {
    this.year = year;
  }

  emitWinner(bool winner) {
    this.winner = winner;
  }

  @override
  void dispose() {
    _moviesController.close();
    _paginationController.close();
    _isGetMoviesLoadingController.close();
    _yearErrorController.close();
  }
}
