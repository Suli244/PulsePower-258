import 'package:flutter/material.dart';
import 'package:pulsepower_258/style/app_text_styles.dart';
import 'package:pulsepower_258/style/app_colors.dart';

class CustomAppBarPulsePower extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarPulsePower({
    this.title,
    this.icon,
    this.titleWidget,
    this.centerTitle = true,
    this.actions,
    this.iconColor,
    this.backgroundColor,
    Key? key,
    this.titleTextStyle,
  }) : super(key: key);
  final String? title;
  final Widget? icon;
  final Widget? titleWidget;
  final bool centerTitle;
  final List<Widget>? actions;
  final TextStyle? titleTextStyle;
  final Color? iconColor;
  final Color? backgroundColor;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? Text(title ?? ''),
      titleTextStyle: titleTextStyle ??
          AppTextStylesPulsePower.s21W600(color: Colors.white),
      backgroundColor: backgroundColor ?? AppColorsPulsePower.color1C1C1C,
      elevation: 0,
      centerTitle: centerTitle,
      iconTheme: IconThemeData(
        color: iconColor ?? Colors.white,
      ),
      leading: icon,
      actions: actions,
    );
  }
}
