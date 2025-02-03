import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/ui/features/auth/login/login_screen.dart';
import 'package:lucii/ui/helper/global_variables.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/dimens.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_util.dart';
import 'package:lucii/utils/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBarMain(title: "Settings".tr,context: context),
      body: SafeArea(
        child: Column(
          children: [
            vSpacer20(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      vSpacer10(),
                      Card(
                        elevation: 15.0,
                        color: context.theme.scaffoldBackgroundColor,
                        // color: context.theme.scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoFormRow(
                            padding: EdgeInsets.zero,
                            prefix: Row(
                              children: <Widget>[
                                Icon(GlobalVariables.gIsDarkMode ? Icons.dark_mode : Icons.light_mode, size: Dimens.iconSizeMid),
                                hSpacer10(),
                                TextAutoMetropolis(GlobalVariables.gIsDarkMode ? 'Dark Mode'.tr : "Light Mode".tr, fontSize: Dimens.fontSizeMid)
                              ],
                            ),
                            child: CupertinoSwitch(
                              value: GlobalVariables.gIsDarkMode,
                              activeColor: context.theme.focusColor,
                              onChanged: (value) => ThemeService().switchTheme(),
                            ),
                          ),
                        ),
                      ),

                      vSpacer10(),
                      InkWell(
                        onTap: () => Get.offAll(() => const LoginScreen()),
                        child: Card(
                          elevation: 15.0,
                          color: context.theme.scaffoldBackgroundColor,
                          // color: context.theme.scaffoldBackgroundColor,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.logout, size: Dimens.iconSizeMid),
                                  hSpacer10(),
                                  TextAutoMetropolis("Logout".tr, fontSize: Dimens.fontSizeMid)
                                ],
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            vSpacer20(),
          ],
        ),
      ),
    );
  }
}
