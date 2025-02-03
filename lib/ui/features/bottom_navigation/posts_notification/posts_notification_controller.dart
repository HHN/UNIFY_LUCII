import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lucii/data/models/eventModel.dart';

import '../../../../data/local/api_constants.dart';

class PostsNotificationController extends GetxController with GetSingleTickerProviderStateMixin {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }
  TabController? tabController;
  final tabSelectedIndex = 0.obs;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  RxBool isLoading = false.obs;

  List<dynamic> notificationItemList = [
    {'name': 'John', 'group': 'April 27, 2021'},
    {'name': 'Will', 'group': 'April 27, 2021'},
    {'name': 'Beth', 'group': 'April 27, 2021'},
    {'name': 'Miranda', 'group': 'April 26, 2021'},
    {'name': 'Mike', 'group': 'April 26, 2021'},
    {'name': 'Danny', 'group': 'April 26, 2021'},
    {'name': 'Simul', 'group': 'April 2, 2021'},
    {'name': 'Danny2', 'group': 'April 2, 2021'},
    {'name': 'Danny3', 'group': 'April 2, 2021'},
    {'name': 'Danny4', 'group': 'April 2, 2021'},
  ].obs;

  bool isDataLoaded = false;

  List<Event> removeDuplicates(List<Event> list) {
    Set<String> seen = <String>{};
    List<Event> uniqueList = [];
    for (Event model in list) {
      if(model.body.eventDetails != ""){
        if (!seen.contains(model.body.eventDetails)) {
          seen.add(model.body.eventDetails);
          uniqueList.add(model);
        }
      }
    }
    return uniqueList;
  }
  getEvent() async {
    final uri = Uri.parse(APIURLConstants.getAllEvents);
    final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      isLoading.value = false;
      List<Event> events = parseEvents(response.body);
      removeDuplicates(events);

    } else {
      isLoading.value = false;
    }
  }
}
