// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flut_base_app_razzies/app/ui/components/text/base_text.dart';
import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';

import '../datatable_controller.dart';
import 'datatable_header.dart';

class ResponsiveDatatable extends StatefulWidget {
  final bool activateOnTapRow;
  final ScrollController? scrollController;
  final List<DataTableHeader> headers;
  final List<Map<String, dynamic>> source;
  final Widget? title;
  final List<Widget>? footers;
  final Widget? emptyWidget;
  final bool isLoading;
  final bool showFooterOnLoading;
  final bool commonMobileView;
  final bool autoSort;
  final bool rowCursor;
  final EdgeInsets rowPadding;
  final EdgeInsets itemPadding;
  final DataTableController? dataTableController;
  final bool showDivider;
  final BoxDecoration? cardDecoration;
  final BoxConstraints? cardConstraints;
  final EdgeInsets? containerPadding;

  const ResponsiveDatatable({
    super.key,
    required this.source,
    required this.headers,
    this.activateOnTapRow = false,
    this.emptyWidget,
    this.title,
    this.footers,
    this.isLoading = false,
    this.showFooterOnLoading = false,
    this.commonMobileView = false,
    this.autoSort = false,
    this.rowCursor = false,
    this.showDivider = true,
    this.rowPadding = const EdgeInsets.all(0),
    this.itemPadding = const EdgeInsets.all(16),
    this.scrollController,
    this.dataTableController,
    this.cardDecoration,
    this.cardConstraints,
    this.containerPadding,
  });

  @override
  createState() => _ResponsiveDatatableState();
}

class _ResponsiveDatatableState extends State<ResponsiveDatatable> {
  late DataTableController _dataTableController;

  @override
  void initState() {
    super.initState();
    _dataTableController = widget.dataTableController ?? DataTableController();

    _dataTableController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.dataTableController == null) _dataTableController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.cardConstraints ??
          const BoxConstraints(maxWidth: 600, minHeight: 365),
      padding: widget.containerPadding ?? context.spacer.all.xs,
      decoration: widget.cardDecoration ??
          BoxDecoration(
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
          if (widget.title != null)
            Container(
              padding: context.spacer.all.xxxs,
              decoration: _defaultDecoration,
              child: Row(
                children: [
                  Expanded(child: widget.title!),
                ],
              ),
            ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: context.appColors.neutral.grey3,
              ),
            ),
            child: Builder(
              builder: (_) {
                if (MediaQuery.of(context).size.width < 700) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          if (widget.isLoading) const LinearProgressIndicator(),
                          ...mobileList(),
                        ],
                      ),
                      if (widget.footers != null && widget.isLoading == false)
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [...widget.footers!],
                          ),
                        )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      if (widget.headers.isNotEmpty) desktopHeader(),
                      if (widget.isLoading) const LinearProgressIndicator(),
                      if (widget.source.isNotEmpty) desktopListBuilder(),
                      if (widget.source.isEmpty)
                        widget.emptyWidget ?? const SizedBox(),
                      if (widget.footers != null &&
                          (widget.showFooterOnLoading || !widget.isLoading))
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [...widget.footers!],
                          ),
                        )
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> mobileList() {
    BoxDecoration rowDecoration = _defaultDecoration;

    List<Widget> widgets = [];
    for (var index = 0; index < widget.source.length; index++) {
      if (index % 2 == 0) {
        rowDecoration = _defaultDecoration;
      } else {
        rowDecoration = _defaultDecoration;
      }

      final data = widget.source[index];
      widgets.add(Container(
        decoration: rowDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!widget.commonMobileView)
              ...widget.headers
                  .where((header) => header.show == true)
                  .toList()
                  .map(
                (header) {
                  List<String> headers = [];
                  Map<String, dynamic> sourceCopy = data;
                  String resultSource = '';

                  if (header.value.contains(".")) {
                    headers = header.value.split(".");
                    for (int i = 0; i < headers.length; i++) {
                      try {
                        sourceCopy = sourceCopy[headers[i]];
                      } catch (e) {
                        resultSource = sourceCopy[headers[i]];
                      }
                    }
                  }
                  return Container(
                    padding: const EdgeInsets.all(11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: BaseText(
                            text: header.text,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Flexible(
                          child: header.sourceBuilder != null
                              ? header.sourceBuilder!(data[header.value], data)
                              : BaseText(
                                  text:
                                      "${resultSource.isEmpty ? data[header.value] : resultSource}",
                                  textAlign: TextAlign.end,
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ));
    }
    return widgets;
  }

  static Alignment headerAlignSwitch(TextAlign? textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  Widget desktopHeader() {
    final headerDecoration = _defaultDecoration;
    return Container(
      decoration: headerDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.headers.where((header) => header.show == true).map(
            (header) {
              return _expandedHeader(header);
            },
          ),
        ],
      ),
    );
  }

  Widget _expandedHeader(DataTableHeader header) {
    return Expanded(
      flex: header.flex,
      child: _clickableHeader(header),
    );
  }

  Widget _clickableHeader(DataTableHeader header) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.neutral.grey1,
        border: header.text != widget.headers.last.text
            ? Border(
                right: BorderSide(
                  color: context.appColors.neutral.grey2,
                ),
              )
            : null,
      ),
      child: InkWell(
        mouseCursor: header.value.isNotEmpty ? null : MouseCursor.defer,
        hoverColor: header.value.isNotEmpty ? null : Colors.transparent,
        splashColor: header.value.isNotEmpty ? null : Colors.transparent,
        highlightColor: header.value.isNotEmpty ? null : Colors.transparent,
        onTap: header.sortable && header.value.isNotEmpty
            ? () {
                _dataTableController.expandedIndexes = null;

                setState(() {
                  _sortAutoColumn = header.value;
                  List<Map<String, dynamic>> sourceFiltered = [];
                  sourceFiltered.addAll(widget.source);
                  _sortAutoAscending = !_sortAutoAscending;

                  if (_sortAutoAscending) {
                    try {
                      sourceFiltered.sort((a, b) => b["$_sortAutoColumn"]
                          .toString()
                          .compareTo(a["$_sortAutoColumn"].toString()));
                    } catch (e) {
                      debugPrint(
                          "with autoSort enabled, the header cannot contain '.'");
                    }
                  } else {
                    try {
                      sourceFiltered.sort((a, b) => a["$_sortAutoColumn"]
                          .toString()
                          .compareTo(b["$_sortAutoColumn"].toString()));
                    } catch (e) {
                      debugPrint(
                          "with autoSort enabled, the header cannot contain '.'");
                    }
                  }
                  widget.source.clear();
                  widget.source.addAll(sourceFiltered);
                });
              }
            : null,
        child: _headerDefaultItem(header),
      ),
    );
  }

  Widget _headerDefaultItem(
    DataTableHeader header,
  ) {
    return Container(
      padding:
          widget.itemPadding + (header.additionalPadding ?? EdgeInsets.zero),
      alignment: headerAlignSwitch(header.textAlign),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          BaseText(
            text: header.text,
            textAlign: header.textAlign,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopItem({
    required DataTableHeader header,
    required Map<String, dynamic> data,
  }) {
    return Expanded(
      flex: header.flex,
      child: _desktopItem(
        header: header,
        data: data,
      ),
    );
  }

  Widget _desktopItem({
    required DataTableHeader header,
    required Map<String, dynamic> data,
  }) {
    List<String> headers = [];
    Map<String, dynamic> sourceCopy = data;
    String resultSource = '';
    bool showRightBorder = header.text != widget.headers.last.text;
    if (header.value.contains(".")) {
      headers = header.value.split(".");
      for (int i = 0; i < headers.length; i++) {
        try {
          sourceCopy = sourceCopy[headers[i]];
        } catch (e) {
          resultSource = sourceCopy[headers[i]];
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: showRightBorder
            ? Border(
                right: BorderSide(
                  color: context.appColors.neutral.grey2,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          widget.itemPadding.left,
          widget.itemPadding.top,
          0,
          widget.itemPadding.bottom,
        ),
        child: Builder(
          builder: (context) {
            return BaseText(
              text: resultSource.isEmpty
                  ? data[header.value].toString()
                  : resultSource,
              textAlign: header.textAlign,
            );
          },
        ),
      ),
    );
  }

  Widget desktopListBuilder() {
    BoxDecoration rowDecoration = _defaultDesktopRowDecoration;

    List<Widget> children = [];

    widget.source.asMap().forEach((index, value) {
      if (!(index % 2 == 0)) {
        rowDecoration = _defaultDesktopRowDecoration;
      } else {
        rowDecoration = _defaultDesktopRowAltDecoration;
      }
      final data = widget.source[index];

      children.add(
        Container(
          key: PageStorageKey(data),
          decoration: rowDecoration,
          child: desktopRow(data: data, index: index),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  Widget desktopRow({
    required Map<String, dynamic> data,
    required int index,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              mouseCursor: (widget.rowCursor || widget.activateOnTapRow)
                  ? null
                  : MouseCursor.defer,
              onTap: widget.activateOnTapRow
                  ? () {
                      if (_dataTableController.containsIndex(index)) {
                        _dataTableController.removeIndex(index);
                      } else {
                        _dataTableController.addIndex(index);
                      }
                    }
                  : null,
              child: Padding(
                padding: widget.rowPadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...widget.headers.where((header) => header.show).map(
                          (header) => _buildDesktopItem(
                            header: header,
                            data: data,
                          ),
                        ),
                  ],
                ),
              ),
            ),
            if (widget.showDivider && widget.source.isNotEmpty)
              Divider(
                color: context.appColors.neutral.grey2,
                height: 2,
              ),
          ],
        ),
      ],
    );
  }

  BoxDecoration get _defaultDecoration => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.appColors.neutral.grey2,
          ),
        ),
      );

  BoxDecoration get _defaultDesktopRowAltDecoration => BoxDecoration(
        color: context.appColors.brand.primary,
      );

  BoxDecoration get _defaultDesktopRowDecoration => BoxDecoration(
        color: context.appColors.neutral.grey1,
      );

  String? _sortAutoColumn;
  bool _sortAutoAscending = true;
}
