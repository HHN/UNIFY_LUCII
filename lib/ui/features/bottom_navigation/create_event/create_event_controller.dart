import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../data/local/api_constants.dart';
import '../../root/root_screen.dart';

class CreateEventController extends GetxController {
  RxBool isLoading = false.obs;

  createEvent(String title, String details, String keywords, bool is_group, String creator) async {
    final body = {
      'name': title,
      'details': details,
      'keywords': keywords,
      'is_group': is_group,
      'creator': creator,
    };
    final uri = Uri.parse(APIURLConstants.createEvent);
    final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body)
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      isLoading.value = false;
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['status'];
      Get.snackbar('Success', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      isLoading.value = false;
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['status'];
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
