import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class ListIntervalBetweenWinsDatatable extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool isLoading;
  final List<Map<String, dynamic>> source;
  const ListIntervalBetweenWinsDatatable({
    super.key,
    this.title,
    this.subtitle,
    this.isLoading = false,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDatatable(context);
  }

  List<DataTableHeader> _buildHeaders() {
    return [
      DataTableHeader(
        text: 'Producer',
        value: 'producer',
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
        text: 'Interval',
        value: 'interval',
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
        text: 'Previous Year',
        value: 'previousWin',
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
        text: 'Following Year',
        value: 'followingWin',
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
        cardDecoration: const BoxDecoration(),
        cardConstraints: const BoxConstraints(),
        containerPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              BaseText(
                text: title!,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            if (subtitle != null) ...[
              BaseText(
                text: subtitle!,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ]
          ],
        ),
        source: source,
        scrollController: ScrollController(),
        headers: _buildHeaders(),
      ),
    );
  }
}
