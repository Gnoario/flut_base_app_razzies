import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/components.dart';
import 'widgets/datatables.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final presenter = Modular.get<DashboardPresenter>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentRoute: '/',
      child: Builder(
        builder: (context) {
          _loadData();
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  StreamBuilder<bool>(
                    stream: presenter.isGetYearsWithMultipleWinnersLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      bool isLoading = snapshot.data ?? false;
                      return StreamBuilder<ResultPresentation>(
                        stream: presenter.yearsWithMultipleWinners,
                        builder: (context, snapshot) {
                          final yearsWithMultipleWinners = snapshot.data;

                          return ListMultipleWinnersDatatable(
                            isLoading: isLoading,
                            source: yearsWithMultipleWinners?.payload ?? [],
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: presenter.isGetStudiosWithWinCountLoading,
                    builder: (context, snapshot) {
                      bool isLoading = snapshot.data ?? false;
                      return StreamBuilder<ResultPresentation>(
                        stream: presenter.studiosWithWinCount,
                        builder: (context, snapshot) {
                          final studiosWithWinCount = snapshot.data;
                          List<Map<String, dynamic>> topThree = [];
                          if (studiosWithWinCount?.payload != null) {
                            const start = 0;
                            final end = studiosWithWinCount!.payload.length > 3
                                ? 3
                                : studiosWithWinCount.payload.length;
                            topThree = studiosWithWinCount.payload.sublist(
                              start,
                              end,
                            );
                          }
                          return ListTopStudiosDatatable(
                            isLoading: isLoading,
                            source: topThree,
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: presenter.isGetMaxMinWinIntervalForProducersLoading,
                    builder: (context, snapshot) {
                      bool isLoading = snapshot.data ?? false;
                      return StreamBuilder<ResultPresentation>(
                        stream: presenter.maxMinWinIntervalForProducers,
                        builder: (context, snapshot) {
                          final maxMinWinIntervalForProducers =
                              snapshot.data?.payload;

                          final max = maxMinWinIntervalForProducers?['max'];

                          final min = maxMinWinIntervalForProducers?['min'];
                          return Padding(
                            padding: context.spacer.all.xxs,
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 600, minHeight: 365),
                              padding: context.spacer.all.xxs,
                              decoration: BoxDecoration(
                                color: context.appColors.brand.primary,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: context.appColors.neutral.grey2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ListIntervalBetweenWinsDatatable(
                                    title:
                                        'Producers with longest interval between wins',
                                    subtitle: 'Maximum',
                                    isLoading: isLoading,
                                    source: max ?? [],
                                  ),
                                  ListIntervalBetweenWinsDatatable(
                                    subtitle: 'Minimum',
                                    isLoading: isLoading,
                                    source: min ?? [],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: presenter.isGetWinnerPerYearLoading,
                    builder: (context, snapshot) {
                      bool isLoading = snapshot.data ?? false;
                      return StreamBuilder<String?>(
                        stream: presenter.yearError,
                        builder: (context, snapshot) {
                          final yearError = snapshot.data;
                          return StreamBuilder<ResultPresentation>(
                            stream: presenter.winnerPerYear,
                            builder: (context, snapshot) {
                              final winnerPerYear = snapshot.data;
                              return ListMovieWinnersByYearDatatable(
                                isLoading: isLoading,
                                source: winnerPerYear?.payload ?? [],
                                onTap: () {
                                  presenter.getWinnerPerYear();
                                },
                                error: yearError,
                                onChanged: (value) {
                                  presenter.validateYear(value);
                                },
                              );
                            },
                          );
                        },
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

  _loadData() {
    presenter.getYearsWithMultipleWinners();
    presenter.getStudiosWithWinCount();
    presenter.getMaxMinWinIntervalForProducers();
  }
}
