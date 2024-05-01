import 'dart:async';
import 'dart:ui';

import 'package:flut_base_app_razzies/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/domain/usecases/get_movies/get_movies_usecase.dart';
import 'package:flut_base_app_razzies/app/ui/components/pagination/pagination_controller.dart';

import '../../../domain/models/exceptions/exceptions.dart';
import '../../../ui/pages/list_movies/list_movies_presenter.dart';

class ListMoviesPresenterImpl implements ListMoviesPresenter {
  final GetMoviesUsecase _getMoviesUsecase;

  ListMoviesPresenterImpl(this._getMoviesUsecase);

  final StreamController<ResultPresentation> _moviesController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<PaginationDto> _paginationController =
      StreamController<PaginationDto>.broadcast();

  final StreamController<bool> _isGetMoviesLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<String?> _yearErrorController =
      StreamController<String?>.broadcast();

  @override
  int? year;

  @override
  bool? winner;

  @override
  PaginationDto? currentPage = PaginationDto(size: 15, number: 1);

  @override
  Stream<bool> get isGetMoviesLoading =>
      _isGetMoviesLoadingController.stream.asBroadcastStream();

  @override
  bool isValidYear = false;

  @override
  Stream<ResultPresentation> get movies =>
      _moviesController.stream.asBroadcastStream();

  @override
  Stream<String?> get yearError =>
      _yearErrorController.stream.asBroadcastStream();

  @override
  Stream<PaginationDto> get pagination =>
      _paginationController.stream.asBroadcastStream();

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _moviesController.close();
    _paginationController.close();
    _isGetMoviesLoadingController.close();
    _yearErrorController.close();
  }

  @override
  Future<void> getMovies(int page) async {
    try {
      _isGetMoviesLoadingController.add(true);
      final pagination = currentPage!.copyWith(
        number: page - 1,
        size: currentPage!.size,
      );
      _paginationController.add(pagination);
      final result = await _getMoviesUsecase(
        pagination: pagination,
        year: year,
        winner: winner,
      );
      if (currentPage?.totalPages != result.pagination.totalPages) {
        currentPage = result.pagination;
      }
      _paginationController.add(result.pagination);
      final resultPresentation = ResultPresentation(
        payload: result.toJsonMoviesList(),
      );
      _moviesController.add(resultPresentation);
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _moviesController.add(resultPresentation);
    } finally {
      _isGetMoviesLoadingController.add(false);
    }
  }

  @override
  validateYear(String? year) {
    if ((year ?? '').isEmpty) {
      paginationController?.moveTo(1);
      isValidYear = true;
      _yearErrorController.add(null);
      this.year = null;
      getMovies(1);
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

    paginationController?.moveTo(1);
    isValidYear = true;
    this.year = yearInt;
    _yearErrorController.add(null);
    getMovies(1);
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  setWinner(String? winner) {
    paginationController?.moveTo(1);
    bool? winnerParser = winner == 'true'
        ? true
        : winner == 'false'
            ? false
            : null;
    this.winner = winnerParser;
    getMovies(1);
  }

  @override
  PaginationController? paginationController = PaginationController();
}
