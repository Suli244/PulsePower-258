import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pulsepower_258/style/app_text_styles.dart';
import 'package:pulsepower_258/widgets/indicator_widget.dart';

class CustomButtonPulsePower extends StatelessWidget {
  const CustomButtonPulsePower({
    Key? key,
    this.width = double.infinity,
    this.height = 60,
    this.padding = 14.0,
    required this.color,
    this.textColor = Colors.white,
    this.isNotFullColor,
    this.isFullFilled = true,
    this.radius = 15.0,
    this.isLoading = false,
    this.textStyle,
    this.text,
    required this.onPress,
    this.child,
    this.widthBorder,
    this.colorBorder,
  }) : super(key: key);

  final double? width;
  final double? widthBorder;
  final double height;
  final double padding;
  final Color color;
  final Color? colorBorder;
  final Color textColor;
  final Color? isNotFullColor;
  final bool isFullFilled;
  final double radius;
  final bool isLoading;
  final TextStyle? textStyle;
  final String? text;
  final Function() onPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isLoading ? null : onPress,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: isFullFilled ? color : isNotFullColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            width: widthBorder ?? 1,
            color: colorBorder ?? color,
          ),
        ),
        child: isLoading
            ? const AppIndicatorPulsePower(color: Colors.white)
            : child ??
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      AppTextStylesPulsePower.s17W600(
                        color: isFullFilled ? textColor : Colors.amber,
                      ),
                ),
      ),
    );
  }
}
