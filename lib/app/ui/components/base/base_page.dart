import 'package:flut_base_app_razzies/app/ui/components/text/base_text.dart';
import 'package:flut_base_app_razzies/core/routes/app_routes.dart';
import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flut_base_app_razzies/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final String currentRoute;
  const BasePage({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BaseText(
          text: 'Frontend Flutter Test',
          color: context.appColors.brand.primary,
          fontSize: 18,
        ),
        backgroundColor: context.appColors.neutral.grey6,
      ),
      body: isResponsiveMode ? _buildColumn() : _buildRow(),
    );
  }

  _buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildChildren(),
    );
  }

  _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildChildren(),
    );
  }

  _buildChildren() {
    return [
      Expanded(
        child: Container(
          padding: context.spacer.y.xs,
          height: double.infinity,
          width: double.infinity,
          color: context.appColors.brandSecondary.secondary,
          child: _buildOptions(),
        ),
      ),
      Expanded(
        flex: 6,
        child: widget.child,
      )
    ];
  }

  _buildOptions() {
    return Column(
      mainAxisAlignment: isResponsiveMode
          ? MainAxisAlignment.spaceAround
          : MainAxisAlignment.start,
      children: [
        _buildOption(
          title: 'Dashboard',
          route: '/',
        ),
        SizedBox(height: context.spacer.value.xs),
        _buildOption(
          title: 'List',
          route: '/list-movies',
        ),
      ],
    );
  }

  _buildOption({required String title, required String route}) {
    return Flexible(
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          titleAlignment: ListTileTitleAlignment.center,
          title: Padding(
            padding: isResponsiveMode
                ? context.spacer.bottom.xs
                : context.spacer.left.xs,
            child: BaseText(
              text: title,
              textAlign: isResponsiveMode ? TextAlign.center : TextAlign.start,
              color: widget.currentRoute == route
                  ? context.appColors.brandSecondary.greyBlue
                  : null,
            ),
          ),
          onTap: () {
            if (widget.currentRoute != route) {
              AppRoutes.goToRoute(route);
            }
          },
        ),
      ),
    );
  }

  bool get isResponsiveMode =>
      ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTablet(context);
}
