import 'package:flut_base_app_razzies/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ListMoviesPresenter implements Disposable, Listenable {
  Stream<bool> get isGetMoviesLoading;
  Stream<ResultPresentation> get movies;
  Stream<PaginationDto> get pagination;
  Stream<String?> get yearError;
  int? year;
  bool? winner;
  PaginationDto? currentPage;
  PaginationController? paginationController;
  bool get isValidYear;

  Future<void> getMovies(int page);
  validateYear(String? year);
  setWinner(String? winner);
}
