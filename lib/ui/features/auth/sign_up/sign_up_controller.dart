import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../data/local/api_constants.dart';
import '../../../helper/global_variables.dart';
import '../../root/root_screen.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;

  signUp(BuildContext context, String name, String userName, String email, String password) async {
    isLoading.value = true;
    final body = {
      'name': name,
      'username': userName,
      'email': email,
      'password': password,
      'auth': {
        'type': "m.login.dummy",
      },
    };
    final uri = Uri.parse(APIURLConstants.register);
    final response = await http.post(
        uri,
        body: jsonEncode(body)
    );
    if(response.statusCode == 200){
      GlobalVariables.profileBox?.put("email", email);
      join(userName, password);
    } else {
      isLoading.value = false;
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['error'];
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.TOP);
    }
  }
  join(String username, String password) async {
    final body = {
      'username': username,
      'password': password
    };
    final uri = Uri.parse(APIURLConstants.join);
    final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body)
    );
    if(response.statusCode == 200){
      isLoading.value = false;
      Get.offAll(() => const RootScreen());
    } else {
      isLoading.value = false;
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['error'];
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
