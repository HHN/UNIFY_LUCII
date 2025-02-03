import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/data/local/constants.dart';
import 'package:lucii/ui/features/auth/login/login_screen.dart';
import 'package:lucii/ui/helper/app_widgets.dart';
import 'package:lucii/ui/helper/global_variables.dart';
import 'package:lucii/utils/button_util.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/dimens.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_field_util.dart';
import 'package:lucii/utils/text_util.dart';
import '../../../../utils/common_utils.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(SignUpController());
  final nameEditController = TextEditingController();
  final usernameEditController = TextEditingController();
  final emailEditController = TextEditingController();
  final passEditController = TextEditingController();
  final confirmPassEditController = TextEditingController();
  RxBool isShowPassword = false.obs;

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
                  // const AppLogo(),
                  // SvgPicture.asset(AssetConstants.icLogo, width: Get.width/1.5),
                  
                  vSpacer30(),
                  Align(alignment: Alignment.centerLeft,
                    child: AuthTitleView(
                        title: "Sign Up".tr,
                        subTitle: "Please sign up to continue".tr),
                  ),
                  vSpacer30(),
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextAutoMetropolis("Full Name".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          TextFieldView(
                              controller: nameEditController,
                              hint: "Enter full name".tr,
                              errorMaxLines: 3,
                              helperMaxLines: 3,
                              inputType: TextInputType.name,
                              helperText: "Make sure matches the government ID".tr,
                              validator: (text) =>
                                  TextFieldValidator.emptyValidator(text,
                                      message: "Full name is required".tr)),
                          vSpacer15(),
                          TextAutoMetropolis("User Name".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          TextFieldView(
                              controller: usernameEditController,
                              hint: "Enter a unique username".tr,
                              inputType: TextInputType.name,
                              validator: TextFieldValidator.usernameValidator),
                          vSpacer15(),
                          TextAutoMetropolis("Email".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          TextFieldView(
                              controller: emailEditController,
                              hint: "Enter email".tr,
                              inputType: TextInputType.emailAddress,
                              validator: TextFieldValidator.emailValidator),
                          vSpacer15(),
                          TextAutoMetropolis("Password".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          Obx(() => TextFieldView(
                              controller: passEditController,
                              hint: "Enter password".tr,
                              isObscure: !isShowPassword.value,
                              inputType: TextInputType.visiblePassword,
                              errorMaxLines: 3,
                              helperMaxLines: 3,
                              helperText: "Password_invalid_message".trParams({
                                "count": LimitConst.passwordLength.toString()
                              }),
                              suffix: ShowHideIconView(
                                  isShow: isShowPassword.value,
                                  onTap: () => isShowPassword.value =
                                      !isShowPassword.value),
                              // validator: TextFieldValidator.passwordValidator
                            )
                          ),
                          vSpacer15(),
                          TextAutoMetropolis("Confirm Password".tr,
                              fontSize: Dimens.fontSizeRegular),
                          vSpacer5(),
                          Obx(() => TextFieldView(
                              controller: confirmPassEditController,
                              hint: "Enter confirm password".tr,
                              isObscure: !isShowPassword.value,
                              inputType: TextInputType.visiblePassword,
                              suffix: ShowHideIconView(
                                  isShow: isShowPassword.value,
                                  onTap: () => isShowPassword.value =
                                      !isShowPassword.value),
                              validator: (text) =>
                                  TextFieldValidator.confirmPasswordValidator(
                                      text,
                                      password: passEditController.text))),
                          // vSpacer20(),
                          // TextAutoSpan(
                          //     text: 'By selecting Agree and continue'.tr,
                          //     subText: "Privacy Policy".tr,
                          //     onTap: () => () {
                          //           Get.to(() => const LoginScreen());
                          //         }),
                          vSpacer50(),
                          SizedBox(
                            width: Get.width,
                            child: Obx(() => ButtonFillMain(
                                title: "Agree and Continue".tr,
                                isLoading: _controller.isLoading.value,
                                onPress: () {
                                  // Get.to(LoginScreen());
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _controller.isLoading = true.obs;
                                    });
                                    hideKeyboard();
                                    _controller.signUp(context, nameEditController.text.trim(), usernameEditController.text.trim(),
                                        emailEditController.text.trim(), passEditController.text);
                                  }
                                })),
                          ),
                          vSpacer10(),
                          Align(
                              alignment: Alignment.centerRight,
                              child: TextAutoSpan(
                                  text: 'Already have account'.tr,
                                  subText: "Sign In".tr,
                                  onTap: () =>
                                      Get.off(() => const LoginScreen()))),
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
