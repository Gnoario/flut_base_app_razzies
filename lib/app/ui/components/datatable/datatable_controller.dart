import 'package:flutter/material.dart';

class DataTableController extends ValueNotifier<DataTableValue> {
  final bool multipleExpand;

  DataTableController({
    int? expandedIndex,
    int? rowEditableIndex,
    List<int?>? expandedIndexes,
    this.multipleExpand = false,
  }) : super(
          DataTableValue(
            expandedIndexes: multipleExpand ? expandedIndexes : [expandedIndex],
            disabledEditableIndexes: [],
          ),
        );

  List<int?> get _indexesNotNull => value.expandedIndexes ?? [];

  int? get expandedIndex =>
      _indexesNotNull.isNotEmpty ? value.expandedIndexes!.first : null;

  List<int?>? get expandedIndexes => value.expandedIndexes;

  set expandedIndex(int? index) {
    value.expandedIndexes = [index];
    notifyListeners();
  }

  set expandedIndexes(List<int?>? indexes) {
    value.expandedIndexes = indexes;
    notifyListeners();
  }

  void setDisabledEditableIndex(int index) {
    if (!value.disabledEditableIndexes.contains(index)) {
      value.disabledEditableIndexes.add(index);
      notifyListeners();
    }
  }

  void removeDisabledEditableIndex(int index) {
    if (value.disabledEditableIndexes.contains(index)) {
      value.disabledEditableIndexes.remove(index);
      notifyListeners();
    }
  }

  bool containsIndex(int index) => _indexesNotNull.contains(index);

  void removeIndex(int index) {
    value.expandedIndexes?.remove(index);
    notifyListeners();
  }

  void addIndex(int index) {
    if (value.expandedIndexes != null && multipleExpand) {
      value.expandedIndexes?.add(index);
    } else {
      value.expandedIndexes = [index];
    }

    notifyListeners();
  }
}

class DataTableValue {
  List<int?>? expandedIndexes;
  List<int> disabledEditableIndexes;

  DataTableValue({
    this.expandedIndexes,
    this.disabledEditableIndexes = const [],
  });
}
