import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/ui/helper/app_widgets.dart';
import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (splashController) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // AppLogo(),
                  AppLogoWithText(),

                  // SvgPicture.asset(AssetConstants.icLogoWithText, width: Get.width/1.5),
                  // vSpacer15(),
                  // TextAutoMetropolis("UnifyUniMatch".tr, fontSize: Dimens.fontSizeLarge,color: context.theme.cardColor,),
                  // TextAutoMetropolis("UnifyUniMatchTagLine".tr, fontSize: Dimens.fontSizeRegular,color: context.theme.primaryColorDark,)
                ],
              ),
            );
          }),
    );
  }
}
