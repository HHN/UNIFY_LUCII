import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/spacers.dart';

import 'post_notification_details_controller.dart';

class PostNotificationOutgoingDetailsScreen extends StatefulWidget {
  const PostNotificationOutgoingDetailsScreen({super.key});

  @override
  PostNotificationOutgoingDetailsScreenState createState() => PostNotificationOutgoingDetailsScreenState();
}

class PostNotificationOutgoingDetailsScreenState extends State<PostNotificationOutgoingDetailsScreen> {
  final _controller = Get.put(PostNotificationDetailsController());

  @override
  void initState() {
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
                      // Stack(
                      //   children: <Widget>[
                      //     Container(
                      //       color: Colors.blue,
                      //       width: 200,
                      //       height: 200,
                      //     ),
                      //     Positioned(
                      //       bottom: -50,
                      //       left: 50,
                      //       child: Container(
                      //         color: Colors.red,
                      //         width: 100,
                      //         height: 100,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      EventItemOutgoinDetailsView( context: context,bgColor: context.theme.primaryColorLight),
                      vSpacer20()
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   margin: const EdgeInsets.all(16),
            //   child: FloatingActionButton.extended(
            //     backgroundColor: context.theme.focusColor,
            //     onPressed: () {
            //       // Add your button's onPressed logic here
            //     },
            //     label: const Text('Get in contact',style: TextStyle(color: Colors.white),),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

}
