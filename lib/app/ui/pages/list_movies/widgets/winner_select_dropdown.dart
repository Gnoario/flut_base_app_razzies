import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flut_base_app_razzies/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';

class WinnerSelectDropdown extends StatelessWidget {
  final Function(String?) onChanged;
  const WinnerSelectDropdown({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<String>(
        onChanged: onChanged,
        items: const [
          DropdownMenuItem(
            child: Text('Yes/No'),
          ),
          DropdownMenuItem(
            value: 'true',
            child: BaseText(text: 'Yes'),
          ),
          DropdownMenuItem(
            value: 'false',
            child: BaseText(text: 'No'),
          ),
        ],
        decoration: InputDecoration(
          labelText: 'Yes/No',
          labelStyle: TextStyle(
            color: context.appColors.brandSecondary.black,
            fontSize: 14,
          ),
          border: const OutlineInputBorder(),
          contentPadding: context.spacer.x.xxs,
        ),
      ),
    );
  }
}
