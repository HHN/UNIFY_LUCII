import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lucii/data/local/constants.dart';
import 'package:lucii/ui/features/settings/settings_screen.dart';
import 'package:lucii/utils/text_util.dart';
import 'button_util.dart';
import 'dimens.dart';

class AppBarMainOld extends StatelessWidget {
  const AppBarMainOld({super.key, required this.contextMain, required this.title});

  final BuildContext contextMain;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: TextAutoMetropolis(title, fontSize: Dimens.fontSizeMid),
    );
  }
}

AppBar AppBarMain({String? title,BuildContext? context}){
  return AppBar(
    backgroundColor: context!.theme.primaryColorLight,
    elevation: 0,
    centerTitle: true,
    title: TextAutoMetropolis(title ?? '', fontSize: Dimens.fontSizeMid),
  );
}



AppBar AppBarMainWithBack({String? title,BuildContext? context}){
  return AppBar(
    backgroundColor: context!.theme.scaffoldBackgroundColor,
    elevation: 0,
    centerTitle: true,
    leading: ButtonOnlyIcon(
        iconData: Icons.arrow_back,
        iconSize: Dimens.iconSizeMid,
        onTap: () => Get.back()),
    title: TextAutoMetropolis(title!, fontSize: Dimens.fontSizeMid),
    // actions: [
    //   InkWell(
    //     onTap: () => Get.to(const SettingsScreen()),
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: SvgPicture.asset(
    //         AssetConstants.icSearch,
    //         color: context!.theme.primaryColorDark,
    //         height: 26,
    //         width: 50,
    //       ),
    //     ),
    //   ),
    // ],
  );
}

AppBar AppBarMainWithBackAndActions({String? title,BuildContext? context}){
  return AppBar(
    backgroundColor: context!.theme.scaffoldBackgroundColor,
    elevation: 0,
    centerTitle: true,
    leading: ButtonOnlyIcon(
        iconData: Icons.arrow_back,
        iconSize: Dimens.iconSizeMid,
        onTap: () => Get.back()),
    title: TextAutoMetropolis(title!, fontSize: Dimens.fontSizeMid),
    actions: [
      IconButton(
        icon: Icon(Icons.call,color: context.theme.primaryColorDark),
        onPressed: () {
          // Implement call functionality
        },
      ),
      IconButton(
        icon: Icon(Icons.video_call,color: context.theme.primaryColorDark),
        onPressed: () {
          // Implement video call functionality
        },
      ),
    ],
  );
}


class AppBarWithSearch extends StatelessWidget {
  const AppBarWithSearch({super.key, required this.contextMain, required this.title});

  final BuildContext contextMain;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: ButtonOnlyIcon(
          iconData: Icons.menu,
          iconSize: Dimens.iconSizeMid,
          onTap: () => Scaffold.of(contextMain).openDrawer()),
      title: TextAutoMetropolis(title, fontSize: Dimens.fontSizeMid),
      actions: [
        InkWell(
          onTap: () => Get.to(const SettingsScreen()),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              AssetConstants.icSearch,
              color: context.theme.primaryColorDark,
              height: 26,
              width: 50,
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarWithBack extends StatelessWidget {
  const AppBarWithBack({super.key, required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: ButtonOnlyIcon(
          iconData: Icons.arrow_back,
          iconSize: Dimens.iconSizeMid,
          onTap: () => Get.back()),
      title: TextAutoMetropolis(title ?? '', fontSize: Dimens.fontSizeMid),
    );
  }
}
