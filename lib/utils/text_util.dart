import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button_util.dart';
import 'common_utils.dart';
import 'dimens.dart';

class TextAutoMetropolis extends StatelessWidget {
  const TextAutoMetropolis(this.text, {super.key, this.maxLines, this.textAlign, this.color, this.fontSize});

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,
        maxLines: maxLines,
        minFontSize: 10,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: context.theme.textTheme.titleMedium!.copyWith(color: color, fontSize: fontSize));
  }
}

class TextAutoPoppins extends StatelessWidget {
  const TextAutoPoppins(this.text, {super.key, this.maxLines, this.textAlign, this.color, this.fontSize, this.decoration, this.height});

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final double? height;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,
        maxLines: maxLines,
        minFontSize: 10,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: context.theme.textTheme.bodyMedium!.copyWith(color: color, fontSize: fontSize, decoration: decoration, height: height));
  }
}

class TextAutoSpan extends StatelessWidget {
  const TextAutoSpan({super.key, required this.text, required this.subText, this.textColor, this.subTextColor, this.onTap, this.maxLines});

  final String text;
  final String subText;
  final Color? textColor;
  final Color? subTextColor;
  final VoidCallback? onTap;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    textColor == textColor ?? context.theme.focusColor;
    return AutoSizeText.rich(
        TextSpan(
          text: text,
          style: context.textTheme.bodyMedium!.copyWith(color: textColor),
          children: <TextSpan>[
            TextSpan(
                text: " $subText",
                style: context.textTheme.titleMedium!.copyWith(fontSize: Dimens.fontSizeRegular,color: subTextColor),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
        maxLines: maxLines);
  }
}

class TextWithCopyIcon extends StatelessWidget {
  const TextWithCopyIcon(this.text, {Key? key, this.maxLines = 2, this.iconSize, this.textAlign, this.padding}) : super(key: key);
  final String text;
  final int maxLines;
  final double? iconSize;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? const EdgeInsets.all(Dimens.paddingMid),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: TextAutoPoppins(text, maxLines: maxLines, textAlign: textAlign)),
            ButtonOnlyIcon(
                iconData: Icons.copy_outlined, iconColor: context.theme.primaryColor, iconSize: iconSize, onTap: () => copyToClipboard(text))
          ],
        ));
  }
}
