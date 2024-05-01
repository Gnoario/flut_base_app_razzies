import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/app/ui/pages/list_movies/widgets/winner_select_dropdown.dart';
import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListMoviesDatatable extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> source;
  final Function(String?) onYearChanged;
  final Function(String?) onWinnerChanged;
  final String? error;
  const ListMoviesDatatable({
    super.key,
    this.isLoading = false,
    required this.source,
    required this.onYearChanged,
    required this.onWinnerChanged,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDatatable(context);
  }

  List<DataTableHeader> _buildHeaders(BuildContext context) {
    final headerPadding = error != null
        ? context.spacer.all.xl.copyWith(top: 46, bottom: 46)
        : context.spacer.all.md;
    return [
      DataTableHeader(
        text: 'Id',
        value: 'id',
        sortable: true,
        additionalPadding: headerPadding,
        flex: 2,
        textAlign: TextAlign.center,
        sourceBuilder: (value, row) {
          return BaseText(
            text: value.toString(),
          );
        },
      ),
      DataTableHeader(
        text: 'Year',
        value: 'year',
        sortable: true,
        additionalPadding: context.spacer.all.xxs,
        flex: 2,
        title: (value) {
          return Column(
            children: [
              BaseText(
                text: value,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: context.spacer.value.xxs),
              SizedBox(
                height: 40,
                child: BasicField(
                  onChanged: onYearChanged,
                ),
              ),
              if (error != null)
                Padding(
                  padding: context.spacer.top.xxs,
                  child: BaseText(
                    text: error!,
                    color: context.appColors.brandSecondary.red,
                  ),
                ),
            ],
          );
        },
        textAlign: TextAlign.center,
        sourceBuilder: (value, row) {
          return BaseText(
            text: value.toString(),
          );
        },
      ),
      DataTableHeader(
        text: 'Title',
        value: 'title',
        sortable: true,
        additionalPadding: headerPadding,
        flex: 2,
        textAlign: TextAlign.center,
        sourceBuilder: (value, row) {
          return BaseText(
            text: value.toString(),
          );
        },
      ),
      DataTableHeader(
        text: 'Winner?',
        value: 'winner',
        sortable: true,
        additionalPadding: context.spacer.all.xxs,
        flex: 2,
        textAlign: TextAlign.center,
        title: (value) {
          return Column(
            children: [
              BaseText(
                text: value,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: context.spacer.value.xxs),
              SizedBox(
                height: 40,
                child: WinnerSelectDropdown(
                  onChanged: onWinnerChanged,
                ),
              ),
            ],
          );
        },
        sourceBuilder: (value, row) {
          return BaseText(
            text: value.toString(),
          );
        },
      ),
    ];
  }

  _buildDatatable(BuildContext context) {
    return Padding(
      padding: context.spacer.all.xxs,
      child: ResponsiveDatatable(
        isLoading: isLoading,
        cardConstraints: const BoxConstraints(),
        itemPadding: context.spacer.y.xxs,
        title: const BaseText(
          text: 'List movies',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        source: source,
        scrollController: ScrollController(),
        headers: _buildHeaders(context),
      ),
    );
  }
}
