import 'package:flutter/material.dart';

class DataTableHeader {
  final String text;

  final String value;
  final bool sortable;
  bool show;
  final TextAlign textAlign;
  final int flex;
  final Widget Function(dynamic value, Map<String, dynamic> row)? sourceBuilder;
  final Widget Function(dynamic value)? title;
  final EdgeInsets? additionalPadding;

  DataTableHeader({
    required this.text,
    required this.value,
    this.title,
    this.textAlign = TextAlign.center,
    this.sortable = false,
    this.show = true,
    this.flex = 1,
    this.sourceBuilder,
    this.additionalPadding,
  });

  factory DataTableHeader.fromMap(Map<String, dynamic> map) => DataTableHeader(
        text: map['text'],
        value: map['value'],
        title: map['title'],
        sortable: map['sortable'],
        show: map['show'],
        textAlign: map['textAlign'],
        flex: map['flex'],
        sourceBuilder: map['sourceBuilder'],
        additionalPadding: map['additionalPadding'],
      );
  Map<String, dynamic> toMap() => {
        "text": text,
        "value": value,
        'title': title,
        "sortable": sortable,
        "show": show,
        "textAlign": textAlign,
        "flex": flex,
        "sourceBuilder": sourceBuilder,
        "additionalPadding": additionalPadding,
      };
}
