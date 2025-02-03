import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common_utils.dart';
import 'dimens.dart';

class ButtonFillMain extends StatelessWidget {
  const ButtonFillMain(
      {super.key,
      this.title,
      this.onPress,
      this.textColor,
      this.bgColor,
      this.borderRadius,
      this.isLoading,
      this.icon,
      this.fontSize,
      this.height = 50,
      this.iconSize});

  final String? title;
  final VoidCallback? onPress;
  final Color? textColor;
  final Color? bgColor;
  final double? borderRadius;
  final double? fontSize;
  final bool? isLoading;
  final IconData? icon;
  final double? iconSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isLoadingL = isLoading ?? false;
    final textColorL = textColor ?? context.theme.primaryColorLight;
    return ElevatedButton.icon(
        icon: isLoadingL
            ? Container(
                width: height,
                height: height,
                padding: const EdgeInsets.all(10),
                child: CircularProgressIndicator(
                    color: textColorL, strokeWidth: 3))
            : icon != null
                ? Icon(icon,
                    color: textColorL, size: iconSize ?? Dimens.iconSizeMid)
                : SizedBox(height: height),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                bgColor ?? context.theme.focusColor),
            backgroundColor: MaterialStateProperty.all<Color>(
                bgColor ?? context.theme.focusColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 20)),
                    side: BorderSide(
                        color: bgColor ?? context.theme.focusColor)))),
        onPressed: isLoadingL ? null : onPress,
        label: AutoSizeText(title ?? "",
            style: context.theme.textTheme.labelMedium!.copyWith(
                color: textColorL, fontSize: fontSize ?? Dimens.fontSizeMid)));
  }
}
class ButtonFillMain2 extends StatelessWidget {
  const ButtonFillMain2(
      {super.key,
      this.title,
      this.onPress,
      this.textColor,
      this.bgColor,
      this.borderRadius,
      this.isLoading,
      this.icon,
      this.fontSize,
      this.height = 45,
      this.iconSize});

  final String? title;
  final VoidCallback? onPress;
  final Color? textColor;
  final Color? bgColor;
  final double? borderRadius;
  final double? fontSize;
  final bool? isLoading;
  final IconData? icon;
  final double? iconSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isLoadingL = isLoading ?? false;
    final textColorL = textColor ?? context.theme.focusColor;
    return ElevatedButton.icon(
        icon: isLoadingL
            ? Container(
                width: height,
                height: height,
                padding: const EdgeInsets.all(10),
                child: CircularProgressIndicator(
                    color: textColorL, strokeWidth: 3))
            : icon != null
                ? Icon(icon,
                    color: textColorL, size: iconSize ?? Dimens.iconSizeMid)
                : SizedBox(height: height),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                bgColor ?? context.theme.primaryColorLight),
            backgroundColor: MaterialStateProperty.all<Color>(
                bgColor ?? context.theme.primaryColorLight),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 50)),
                    side: BorderSide(
                        color: bgColor ?? context.theme.focusColor)))),
        onPressed: isLoadingL ? null : onPress,
        label: AutoSizeText(title ?? "",
            style: context.theme.textTheme.labelMedium!.copyWith(
                color: textColorL, fontSize: fontSize ?? Dimens.fontSizeMid)));
  }
}

class ButtonOnlyIcon extends StatelessWidget {
  const ButtonOnlyIcon(
      {super.key,
      this.visualDensity,
      this.padding,
      this.onTap,
      this.iconData,
      this.iconColor,
      this.iconSize});

  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize ?? Dimens.iconSizeMid,
      padding: padding ?? EdgeInsets.zero,
      visualDensity: visualDensity ?? minimumVisualDensity,
      onPressed: onTap,
      icon: iconData != null
          ? Icon(iconData, color: iconColor ?? context.theme.primaryColorDark)
          : const SizedBox(),
    );
  }
}

class ButtonOnlyCircleIcon extends StatelessWidget {
  const ButtonOnlyCircleIcon(
      {super.key,
      this.visualDensity,
      this.padding,
      this.onTap,
      this.iconData,
      this.iconColor,
      this.iconSize});

  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.theme.canvasColor,
      minRadius: 15,
      maxRadius: 18,
      child: IconButton(
        iconSize: iconSize ?? Dimens.iconSizeMid,
        padding: padding ?? EdgeInsets.zero,
        visualDensity: visualDensity ?? minimumVisualDensity,
        onPressed: onTap,
        icon: iconData != null
            ? Icon(
                iconData,
                color: iconColor ?? context.theme.focusColor,

                size: Dimens.iconSizeMin,
              )
            : const SizedBox(),
      ),
    );
  }
}

class OnlyIcon extends StatelessWidget {
  const OnlyIcon(
      {super.key,
      this.visualDensity,
      this.padding,
      this.onTap,
      this.iconData,
      this.iconColor,
      this.iconSize});

  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize ?? Dimens.iconSizeMid,
      padding: padding ?? EdgeInsets.zero,
      visualDensity: visualDensity ?? minimumVisualDensity,
      onPressed: onTap,
      icon: iconData != null
          ? Icon(
              iconData,
              color: iconColor ?? context.theme.focusColor,
              size: Dimens.iconSizeMin,
            )
          : const SizedBox(),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText(this.text,
      {Key? key,
      this.onPress,
      this.textColor,
      this.bgColor,
      this.radius = 30,
      this.isEnable = true,
      this.borderColor,
      this.fontSize,
      this.visualDensity})
      : super(key: key);

  final String text;
  final VoidCallback? onPress;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final double radius;
  final double? fontSize;
  final bool isEnable;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final bgColorL = bgColor ?? Theme.of(context).focusColor;
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            overlayColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor.withOpacity(0.1)),
            foregroundColor: MaterialStateProperty.all<Color>(bgColorL),
            backgroundColor: MaterialStateProperty.all<Color>(bgColorL),
            visualDensity: visualDensity,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    side:
                        BorderSide(color: borderColor ?? bgColorL, width: 2)))),
        onPressed: isEnable ? onPress : null,
        child: AutoSizeText(text,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontSize: fontSize ?? 14, color: textColor),
            minFontSize: 8));
  }
}

class ButtonTextWithIcon extends StatelessWidget {
  const ButtonTextWithIcon(this.text,
      {super.key,
      this.onPress,
      this.textColor,
      this.bgColor,
      this.radius = 30,
      this.isEnable = true,
      this.borderColor,
      this.fontSize,
      this.iconColor,
      this.iconData,
      this.iconSize,
      this.padding,
      this.visualDensity});

  final String text;
  final VoidCallback? onPress;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final double radius;
  final double? fontSize;
  final bool isEnable;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final bgColorL = bgColor ?? Theme.of(context).focusColor;
    return SizedBox(
      width: Get.width/4,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              overlayColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor.withOpacity(0.1)),
              foregroundColor: MaterialStateProperty.all<Color>(bgColorL),
              backgroundColor: MaterialStateProperty.all<Color>(bgColorL),
              visualDensity: visualDensity,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      side:
                          BorderSide(color: borderColor ?? bgColorL, width: 2)))),
          onPressed: isEnable ? onPress : null,
          child: Row(
            children: [
              AutoSizeText(text,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: fontSize ?? 14, color: textColor),
                  minFontSize: 8),
              IconButton(
                iconSize: iconSize ?? Dimens.iconSizeMid,
                padding: padding ?? EdgeInsets.zero,
                visualDensity: visualDensity ?? minimumVisualDensity,
                onPressed: onPress,
                icon: iconData != null
                    ? Icon(
                        iconData,
                        color: iconColor ?? context.theme.focusColor,
                        size: Dimens.iconSizeMin,
                      )
                    : const SizedBox(),
              )
            ],
          )),
    );
  }
}
