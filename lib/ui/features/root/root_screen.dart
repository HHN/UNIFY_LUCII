import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lucii/data/local/constants.dart';
import 'package:lucii/ui/features/auth/login/login_screen.dart';
import 'package:lucii/ui/features/bottom_navigation/posts_notification/posts_notification_screen.dart';
import 'package:lucii/ui/features/bottom_navigation/profile/profile_screen.dart';
import 'package:lucii/ui/features/settings/settings_screen.dart';
import 'package:lucii/ui/helper/app_helper.dart';
import 'package:lucii/ui/helper/app_widgets.dart';
import 'package:lucii/ui/helper/global_variables.dart';
import 'package:lucii/utils/colors.dart';
import 'package:lucii/utils/common_utils.dart';
import 'package:lucii/utils/dimens.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_util.dart';
import 'root_controller.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  final RootController _rootController = Get.put(RootController());

  @override
  void initState() {
    super.initState();
    _rootController.changeBottomNavIndex = changeBottomNavTab;
  }

  @override
  void dispose() {
    hideKeyboard();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const ProfileScreen(),
      const PostsNotificationScreen(),
      const SettingsScreen()
    ];
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            GlobalVariables.gIsDarkMode ? Brightness.light : Brightness.dark));
    GlobalVariables.currentContext = context;
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      drawer: _getDrawerView(),
      drawerScrimColor: Colors.transparent,
      // bottomNavigationBar: _bottomNavigationBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      // body: SafeArea(child: _getBody()),
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
    );
  }

  void changeBottomNavTab(int index) async {
    setState(() => _rootController.bottomNavIndex = index);
  }

  _bottomNavigationBar() {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedNotchBottomBar(
      /// Provide NotchBottomBarController
      notchBottomBarController: _controller,
      color: cExtraLight,
      showLabel: false,
      textOverflow: TextOverflow.visible,
      maxLine: 1,
      textAlign: TextAlign.center,
      shadowElevation: 15,
      kBottomRadius: 28.0,
      notchColor: context.theme.cardColor,

      /// restart app if you change removeMargins
      removeMargins: false,
      bottomBarWidth: screenWidth,
      bottomBarHeight: 56.0,
      showShadow: false,
      durationInMilliSeconds: 300,
      itemLabelStyle: const TextStyle(fontSize: 10),
      elevation: 5,
      showBlurBottomBar: true,
      blurOpacity: 0.8,
      blurFilterX: 5.0,
      blurFilterY: 10.0,
      // pageController: _pageController,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Stack(
            children: [
              SvgPicture.asset(
                AssetConstants.icLockedProfile2,
                color: Colors.blueGrey,
              ),
            ],
          ),
          activeItem: Stack(
            children: [
              SvgPicture.asset(
                AssetConstants.icLockedProfile2,
                color: cDark,
              ),
            ],
          ),
          itemLabel: 'Profile',
        ),
        BottomBarItem(
          inActiveItem: SvgPicture.asset(
            AssetConstants.postNotification,
            color: Colors.blueGrey,
          ),
          activeItem: SvgPicture.asset(
            AssetConstants.postNotification,
            color: cDark,
          ),
          itemLabel: 'Posts',
        ),
        BottomBarItem(
          inActiveItem: SvgPicture.asset(
            AssetConstants.icSetting,
            color: Colors.blueGrey,
          ),
          activeItem: SvgPicture.asset(
            AssetConstants.icSetting,
            color: cDark,
          ),
          itemLabel: 'Create Event',
        ),
      ],
      onTap: (index) {
        log('current selected index $index');
        _pageController.jumpToPage(index);
      },
      kIconSize: 25.0,
    );
  }

  _getDrawerView() {
    return Drawer(
      elevation: 0,
      width: context.width - 100,
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: Container(
          height: Get.height,
          decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Dimens.cornerRadiusLarge),
                  bottomRight: Radius.circular(Dimens.cornerRadiusLarge))),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.paddingLarge, vertical: 8),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      AssetConstants.icCross,
                      color: context.theme.primaryColorDark,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
              vSpacer10(),
              const AppLogo(),
              vSpacer30(),
              const Divider(),
              _drawerNavMenuItem("Logout".tr, AssetConstants.ic_logout,
                  () => Get.offAll(() => const LoginScreen())),
              const Spacer(),
              TextAutoPoppins(getCommonSettingsLocal()?.copyrightText ?? ""),
              vSpacer10()
            ],
          ),
        ),
      ),
    );
  }

  _drawerNavMenuItem(String navTitle, String iconPath, VoidCallback navAction) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: Dimens.paddingLarge),
      leading: SvgPicture.asset(
        iconPath,
        color: context.theme.primaryColorDark,
        height: 20,
        width: 20,
      ),
      // Icon(icon, size: Dimens.iconSizeMid),
      title: TextAutoMetropolis(navTitle,
          fontSize: Dimens.fontSizeRegular, textAlign: TextAlign.left),
      onTap: navAction,
    );
  }
}
