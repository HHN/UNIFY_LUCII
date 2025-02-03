import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lucii/data/local/constants.dart';
import 'package:lucii/ui/features/bottom_navigation/create_event/create_event_screen.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/dimens.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_util.dart';
import '../../../../data/local/api_constants.dart';
import '../../../../data/models/eventModel.dart';
import '../../../helper/global_variables.dart';
import 'posts_notification_controller.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;

class PostsNotificationScreen extends StatefulWidget {
  const PostsNotificationScreen({super.key});

  @override
  PostsNotificationScreenState createState() => PostsNotificationScreenState();
}

class PostsNotificationScreenState extends State<PostsNotificationScreen> {
  final _controller = Get.put(PostsNotificationController());
  late final GenerativeModel _model;
  static const _apiKey ="AIzaSyAoE5hYQCDbzPngaoLwfLzjIpiiNyMO-xw";
  /// Start of floating button variables
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);
  var selectedfABLocation = FloatingActionButtonLocation.endFloat;
  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  String? eventDetails;
  String? eventName;
  String? eventCategory;
  String? eventType;
  String? eventLocations;
  String? skillLevel;
  String? keywords;
  String allStr = "";
  List<String> allList = [];
  List<Event> incomingList = [];
  List<List<String>> matchedList = [];


List<Event> removeDuplicates(List<Event> list)  {
    Set<String> seen = <String>{};
    List<Event> uniqueList = [];

    for (Event model in list) {
      // Skip if the eventDetails are empty
      if (model.body.eventDetails.isEmpty) continue;

      // Check if the event detail has been seen before
      if (!seen.contains(model.body.eventDetails)) {
        seen.add(model.body.eventDetails);

        // Prepare the content to send to Gemini API
        final content = [
          Content.multi([
            TextPart("""
                    The system evaluates incoming posts against user profiles to determine if they match the user's interests, preferences, or past interactions. You wont explain anything just output the json.
Generated Match: 
- Interests: ${GlobalVariables.profileBox!.get("interests")}
- Location Preferences: ${GlobalVariables.profileBox!.get("locations")}
- Event Preferences: ${GlobalVariables.profileBox!.get("eventPreferences")}
- Social Preferences: ${GlobalVariables.profileBox!.get("socialPreferences")}
- Match: True (should be shown to the user) 
Output shall be in json in expected format , no extra explanations needed
                    """),
            TextPart("Event Description: ${model.body.eventDetails}")
          ])
        ];
        _model.generateContent(content).then((response) {
          print("Response: ${response.text}");

          // If the response is positive, add to uniqueList
          Map<String, dynamic> responseJson = jsonDecode(response.text!);
          var match = responseJson['match'] ?? false;

          if (match) {
            setState(() {
              matchedList.add([
                ...getCommonElements(model.body.keywords.join(","), GlobalVariables.profileBox!.get("interests")),
                ...getCommonElements(model.body.keywords.join(","), GlobalVariables.profileBox!.get("professionalBackground")),
                ...getCommonElements(model.body.keywords.join(","), GlobalVariables.profileBox!.get("eventPreferences")),
                ...getCommonElements(model.body.keywords.join(","), GlobalVariables.profileBox!.get("socialPreferences")),
                ...getCommonElements(model.body.keywords.join(","), GlobalVariables.profileBox!.get("locations")),
              ]);
              uniqueList.add(model);
            });
          }
        });
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Event> events = parseEvents(response.body);
      List<Event> filteredEvents = await removeDuplicates(events);
      setState(() {
        incomingList = filteredEvents;
      });
    } else {
      // Handle errors here
      print('Failed to fetch events: ${response.statusCode}');
    }
  }
  List<String> getCommonElements(String str1, String str2) {
    List<String> list1 = str1.split(",").toList();
    List<String> list2 = str2.split(",").toList();
    final lowerCaseList2 = list2.map((e) => e.toLowerCase()).toList();
    return list1.where((element) => lowerCaseList2.contains(element.toLowerCase())).toList();
  }
  @override
  void initState() {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);

    getEvent();
    setState(() {
      if(GlobalVariables.profileBox!.containsKey("eventDetails")){
        eventDetails =  GlobalVariables.profileBox!.get('eventDetails', defaultValue: "");
      }
      if(GlobalVariables.profileBox!.containsKey("eventName")){
        eventName =  GlobalVariables.profileBox!.get('eventName', defaultValue: "");
      }
      if(GlobalVariables.profileBox!.containsKey("matchedList")){
        allStr =  GlobalVariables.profileBox!.get('matchedList', defaultValue: "");
      }
      allList = allStr.split(",").toList();
    });
    super.initState();
  }
  Future<void> getData() async {
    Future.delayed(const Duration(seconds: 3), () {
      getEvent()();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColorLight,
      appBar: AppBarMain(title: "Posts".tr,context: context),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                getTabView(
                  titles: ["Outgoing Posts".tr, "Incoming Posts".tr],
                  controller: _controller.tabController,
                  onTap: (selected) {
                    _controller.tabSelectedIndex.value = selected;
                  },
                ),
                vSpacer15(),
                Expanded(
                  child: TabBarView(
                      controller: _controller.tabController,
                      children: [_outgoingPostTab(), _incomingPostTab()]),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 110.0,
            right: 16.0,
            child: _customFloatingSpeedDial(),)
        ],
      ),

    );
  }

  Widget _outgoingPostTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventItemView1(
              context: context,
              bgColor: context.theme.scaffoldBackgroundColor,
            ),
            vSpacer5(),
            EventItemView2(
              context: context,
              bgColor: context.theme.scaffoldBackgroundColor,
            ),
            vSpacer5(),
            EventItemView3(
              context: context,
              bgColor: context.theme.scaffoldBackgroundColor,
            ),
            vSpacer5(),
            EventItemView1(
              context: context,
              bgColor: context.theme.scaffoldBackgroundColor,
            ),
            vSpacer5(),
            EventItemView2(
              context: context,
              bgColor: context.theme.scaffoldBackgroundColor,
            ),
            vSpacer10(),

            ///For dynamic list view of event
            /*
                          Obx(() => _controller.notificationItemList.isEmpty
                                ? EmptyViewWithLoading(isLoading: _controller.isLoading.value)
                                : Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: _controller.notificationItemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // if (_controller.hasMoreData &&
                                  //     index == (_controller.notificationList.length - 1)) {
                                  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                                  //     _controller.getNotificationItems(false);
                                  //   });
                                  // }
                                  return EventItemView( context: context,bgColor: context.theme.canvasColor);
                                },
                              ),
                            ),
                          )
                          */
          ],
        ),
      ),
    );
  }

  Widget _incomingPostTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: RefreshIndicator(
          onRefresh: getData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // eventName == null ? Container() : Align(
              //     alignment: Alignment.centerLeft,
              //     child: TextAutoMetropolis("New",
              //         color: context.theme.primaryColor,
              //         fontSize: Dimens.fontSizeSmall,
              //         textAlign: TextAlign.start)),
              // eventName == null ? Container() : const Divider(),
              // EventItemView(context: context, bgColor: context.theme.canvasColor, title: eventName, details: eventDetails, data: allList,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextAutoMetropolis("New",
                      color: context.theme.primaryColor,
                      fontSize: Dimens.fontSizeSmall,
                      textAlign: TextAlign.start)),
              const Divider(),
              SizedBox(
                height: Get.height-310,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: incomingList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return EventItemView11(
                        context: context,
                        bgColor: context.theme.scaffoldBackgroundColor,
                        title: incomingList[index].body.eventName,
                        details: incomingList[index].body.eventDetails,
                        data: matchedList[index],
                        postKeywords: incomingList[index].body.keywords,
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _customFloatingSpeedDial() {
    return SpeedDial(
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      // / This is ignored if animatedIcon is non null
      // child: Text("open"),
      // activeChild: Text("close"),
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      mini: mini,
      openCloseDial: isDialOpen,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      // dialRoot: customDialRoot
      //     ? (ctx, open, toggleChildren) {
      //         return ElevatedButton(
      //           onPressed: toggleChildren,
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.blue[900],
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      //           ),
      //           child: const Text(
      //             "Custom Dial Root",
      //             style: TextStyle(fontSize: 17),
      //           ),
      //         );
      //       }
      //     : null,
      buttonSize: buttonSize,
      // it's the SpeedDial size which defaults to 56 itself
      // iconTheme: IconThemeData(size: 22),
      label: extend ? const Text("Open") : null,
      // The label of the main button.
      /// The active label of the main button, Defaults to label if not specified.
      activeLabel: extend ? const Text("Close") : null,

      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
      /// The below button size defaults to 56 itself, its the SpeedDial childrens size
      childrenButtonSize: childrenButtonSize,
      visible: visible,
      direction: speedDialDirection,
      switchLabelPosition: switchLabelPosition,

      /// If true user is forced to close dial manually
      closeManually: closeManually,

      /// If false, backgroundOverlay will not be rendered.
      renderOverlay: renderOverlay,
      // overlayColor: Colors.black,
      // overlayOpacity: 0.5,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      useRotationAnimation: useRAnimation,
      tooltip: 'Open Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      foregroundColor: context.theme.primaryColorLight,
      backgroundColor: context.theme.focusColor,
      // activeForegroundColor: Colors.red,
      // activeBackgroundColor: Colors.blue,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      shape: customDialRoot
          ? const RoundedRectangleBorder()
          : const StadiumBorder(),
      // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      children: [
        SpeedDialChild(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AssetConstants.icPost,
              color: context.theme.primaryColorLight,
            ),
          ),
          backgroundColor: context.theme.focusColor,
          foregroundColor: context.theme.primaryColorLight,
          label: "Create New Event".tr,
          onTap: () => Get.to(() => const CreateEventScreen()),
          onLongPress: () => debugPrint('StartNewCollaboration LONG PRESS'),
        ),
      ],
    );
  }

}
