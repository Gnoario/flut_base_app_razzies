import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/pages/list_movies/widgets/list_movies_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/models/dtos/pagination/pagination_dto.dart';
import '../../components/components.dart';
import 'list_movies_presenter.dart';

class ListMoviesPage extends StatefulWidget {
  const ListMoviesPage({super.key});

  @override
  createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  final presenter = Modular.get<ListMoviesPresenter>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentRoute: '/list-movies',
      child: Builder(
        builder: (context) {
          presenter.getMovies(presenter.currentPage!.number + 1);
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<bool>(
                    stream: presenter.isGetMoviesLoading,
                    builder: (context, snapshot) {
                      bool isLoading = snapshot.data ?? false;
                      return StreamBuilder<ResultPresentation>(
                        stream: presenter.movies,
                        builder: (context, snapshot) {
                          final movies = snapshot.data;
                          return StreamBuilder<String?>(
                            stream: presenter.yearError,
                            builder: (context, snapshot) {
                              final yearError = snapshot.data;
                              return ListMoviesDatatable(
                                source: movies?.payload ?? [],
                                onYearChanged: presenter.validateYear,
                                onWinnerChanged: presenter.setWinner,
                                isLoading: isLoading,
                                error: yearError,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<PaginationDto>(
                    stream: presenter.pagination,
                    builder: (context, snapshot) {
                      final pagination = snapshot.data;
                      return Pagination(
                        controller: presenter.paginationController,
                        page: presenter.currentPage?.number ?? 1,
                        total: pagination?.totalPages ??
                            presenter.currentPage?.totalPages ??
                            0,
                        onChanged: presenter.getMovies,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
