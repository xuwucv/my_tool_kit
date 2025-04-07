import 'package:flutter/material.dart';

class InkButton extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;
  final Widget? child;
  final String? title;
  final Color? backGroundColor;
  final BoxBorder? border;
  final double elevation;
  final bool showCenter;
  final Function()? onTap;

  const InkButton(
      {super.key,
      this.width,
      this.padding,
      this.borderRadius,
      this.textStyle,
      this.title,
      this.onTap,
      this.decoration,
      this.showCenter = true,
      this.child,
      this.height,
      this.backGroundColor,
      this.elevation = 0.0,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: decoration != null ? decoration?.color : backGroundColor,
      borderRadius:
          decoration != null ? decoration?.borderRadius : borderRadius,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        borderRadius: decoration != null
            ? decoration?.borderRadius as BorderRadius
            : borderRadius,
        onTap: onTap != null
            ? () {
                Future.delayed(Durations.short4, () {
                  onTap?.call();
                });
              }
            : null,
        child: Ink(
          width: width,
          height: height,
          padding: padding,
          decoration: decoration ??
              BoxDecoration(
                color: backGroundColor ?? Colors.white,
                borderRadius: borderRadius,
                border: border,
              ),
          child: showCenter
              ? Center(
                  child: child ??
                      Text(
                        title.toString(),
                        style: textStyle,
                      ),
                )
              : child ??
                  Text(
                    title.toString(),
                    style: textStyle,
                  ),
        ),
      ),
    );
  }
}
