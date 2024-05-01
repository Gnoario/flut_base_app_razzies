import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class ListMovieWinnersByYearDatatable extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> source;
  final Function() onTap;
  final Function(String?) onChanged;
  final String? error;
  const ListMovieWinnersByYearDatatable({
    super.key,
    this.isLoading = false,
    required this.source,
    required this.onTap,
    required this.onChanged,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDatatable(context);
  }

  List<DataTableHeader> _buildHeaders() {
    return [
      DataTableHeader(
        text: 'Id',
        value: 'id',
        sortable: true,
        flex: 2,
        textAlign: TextAlign.left,
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
        flex: 2,
        textAlign: TextAlign.left,
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
        flex: 2,
        textAlign: TextAlign.left,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BaseText(
              text: 'List movie winners by year',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            Padding(
              padding: context.spacer.x.xxs +
                  context.spacer.top.xs +
                  (error != null ? EdgeInsets.zero : context.spacer.bottom.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: BasicField(
                            onChanged: onChanged,
                          ),
                        ),
                        SizedBox(width: context.spacer.value.xs),
                        FloatingActionButton(
                          heroTag: null,
                          mini: true,
                          backgroundColor:
                              context.appColors.brandSecondary.blue,
                          onPressed: onTap,
                          child: Icon(
                            Icons.search,
                            color: context.appColors.brand.primary,
                          ),
                        ),
                      ],
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
              ),
            ),
          ],
        ),
        source: source,
        scrollController: ScrollController(),
        headers: _buildHeaders(),
      ),
    );
  }
}
