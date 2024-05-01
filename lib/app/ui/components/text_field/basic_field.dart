import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicField extends StatelessWidget {
  final Function(String?) onChanged;

  const BasicField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: const InputDecoration(
        labelText: 'Filter by year',
        border: OutlineInputBorder(),
      ),
    );
  }
}
