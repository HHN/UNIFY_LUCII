import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lucii/utils/common_widgets.dart';
import '../../../../utils/button_util.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/dimens.dart';
import '../../../../utils/spacers.dart';
import '../../../../utils/text_field_util.dart';
import '../../../../utils/text_util.dart';
import '../../../helper/app_widgets.dart';
import '../../../helper/global_variables.dart';
import '../sign_up/sign_up_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final emailEditController = TextEditingController();
  final passEditController = TextEditingController();
  RxBool isShowPassword = false.obs;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GlobalVariables.currentContext = context;
    return Scaffold(
        backgroundColor: context.theme.primaryColorLight,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vSpacer30(),
                  const AppLogoWithText(),
                  // SvgPicture.asset(AssetConstants.icLogo, width: Get.width/1.5),
                  vSpacer30(),
                  Align(alignment: Alignment.centerLeft,
                    child: AuthTitleView(
                        title: "Login".tr,
                        subTitle: "Please login to continue".tr),
                  ),
                  vSpacer30(),
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextAutoMetropolis("Name".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          TextFieldView(
                              controller: emailEditController,
                              hint: "Enter name".tr,
                              inputType: TextInputType.emailAddress,
                              validator: (text) =>
                                  TextFieldValidator.emptyValidator(text,
                                      message: "Name is required".tr)),
                          vSpacer15(),
                          TextAutoMetropolis("Password".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          Obx(() => TextFieldView(
                              controller: passEditController,
                              hint: "Enter password".tr,
                              isObscure: !isShowPassword.value,
                              inputType: TextInputType.visiblePassword,
                              suffix: ShowHideIconView(
                                  isShow: isShowPassword.value,
                                  onTap: () => isShowPassword.value =
                                      !isShowPassword.value),
                              validator: (text) =>
                                  TextFieldValidator.emptyValidator(text,
                                      message: "password is required".tr))),
                          vSpacer50(),
                          SizedBox(
                            width: Get.width,
                            child: Obx(() => ButtonFillMain(
                                title: "Login".tr,
                                isLoading: _controller.isLoading.value,
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _controller.isLoading = true.obs;
                                    });
                                    hideKeyboard();
                                    _controller.loginUser(context, emailEditController.text.trim(), passEditController.text);
                                  }
                                })),
                          ),
                          vSpacer5(),
                          Container(
                              alignment: Alignment.centerRight,
                              child: TextAutoSpan(
                                  text: 'Do not have account'.tr,
                                  subText: "Sign Up".tr,
                                  onTap: () =>
                                      Get.off(() => const SignUpScreen())
                                      )),
                          vSpacer10()
                        ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
