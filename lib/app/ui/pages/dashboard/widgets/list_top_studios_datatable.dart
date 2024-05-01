import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class ListTopStudiosDatatable extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> source;
  const ListTopStudiosDatatable({
    super.key,
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
        text: 'Name',
        value: 'name',
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
        text: 'Win Count',
        value: 'winCount',
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
        title: const BaseText(
          text: 'Top 3 studios with winners',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        source: source,
        isLoading: isLoading,
        scrollController: ScrollController(),
        headers: _buildHeaders(),
      ),
    );
  }
}
