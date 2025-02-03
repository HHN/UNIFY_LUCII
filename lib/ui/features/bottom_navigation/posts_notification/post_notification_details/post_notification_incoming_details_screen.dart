import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/ui/features/bottom_navigation/posts_notification/post_notification_details/chat_screen/chat_list_screen.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/spacers.dart';

import '../../../../helper/global_variables.dart';
import 'post_notification_details_controller.dart';

class PostNotificationIncomingDetailsScreen extends StatefulWidget {
  String? title;
  String? details;
  List<String>? keywords;
  List<String>? postKeywords;
  PostNotificationIncomingDetailsScreen({super.key, this.title, this.details, this.keywords, this.postKeywords});

  @override
  PostNotificationIncomingDetailsScreenState createState() => PostNotificationIncomingDetailsScreenState();
}

class PostNotificationIncomingDetailsScreenState extends State<PostNotificationIncomingDetailsScreen> {
  final _controller = Get.put(PostNotificationDetailsController());
  List<String> profileList = [];
  @override
  void initState() {

    setState(() {
      if(GlobalVariables.profileBox!.containsKey("profileKeywords")){
        profileList = GlobalVariables.profileBox!.get("profileKeywords").split(",").toList();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarWithBack(title: "Post Details".tr),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      EventItemDetailsView( context: context,bgColor: context.theme.primaryColorLight,title: widget.title!,
                        details: widget.details!,keywords: widget.keywords!,
                        postKeywords: widget.postKeywords!, profileKeywords: profileList,),
                      vSpacer20()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(16),
              child: FloatingActionButton.extended(
                backgroundColor: context.theme.focusColor,
                onPressed: () {
                  // pass the required parameter's data
                  Get.to( const ChatListScreen(eventId:'',userId:'',reply:''));
                },
                label: const Text('Get in contact',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
