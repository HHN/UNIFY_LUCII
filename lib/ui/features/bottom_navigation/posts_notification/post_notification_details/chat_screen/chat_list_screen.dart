import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lucii/data/local/constants.dart';
import 'package:lucii/ui/features/bottom_navigation/posts_notification/post_notification_details/chat_screen/chat_details/chat_details_screen.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_field_util.dart';
import 'package:lucii/utils/text_util.dart';
import 'chat_list_controller.dart';

class ChatListScreen extends StatefulWidget {
  final String eventId;
  final String userId;
  final String reply;

  const ChatListScreen({super.key, required this.eventId, required this.userId, required this.reply});

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {

  final ChatListController chatController = Get.put(ChatListController());
  final TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    /// for real dynamic data
    // chatController.fetchChats();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBarMainWithBack(context:context ,title: "Chat".tr),
      ///for real dynamic data
/*      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldView(
              suffix:Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AssetConstants.icSearch, height: 20, width: 20,color: context.theme.focusColor,),
              ),
              controller: searchController,
              hint: "Search".tr,
              inputType: TextInputType.text,
              onTextChange: (value) {
                chatController.searchQuery.value = value;
              },
            ),
            vSpacer15(),
            Expanded(
              child: Obx(() {
                return chatController.filteredChats.isEmpty
                      ? EmptyViewWithLoading(isLoading: chatController.isLoading.value,message: 'No chat data available',)
                : ListView.builder(
                    itemCount: chatController.filteredChats.length,
                    itemBuilder: (context, index) {
                      var chat = chatController.filteredChats[index];
                      return Card(
                        elevation: 3,
                        // margin: const EdgeInsets.all(0.0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage('https://picsum.photos/seed/picsum/200/300'),
                          ),
                          title: Text(chat.userId),
                          subtitle: Text(chat.reply),
                          trailing: const Text('2'), // Placeholder for new chat count
                          onTap: () {
                            chatController.fetchChatHistory(chat.userId);
                            Get.to(ChatDetailsScreen(chat: chat));
                          },
                        ),
                      );
                    },
                  );
              }),
            ),
          ],
        ),
      ),*/
      ///for demo data
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldView(
              suffix:Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AssetConstants.icSearch, height: 20, width: 20,color: context.theme.focusColor,),
              ),
                controller: searchController,
                hint: "Search".tr,
                inputType: TextInputType.text,
              onTextChange: (value) {
                chatController.searchQuery.value = value;
              },
            ),
            vSpacer15(),
            Expanded(
              child: Obx(() {
                return chatController.filteredChats.isEmpty
                    ? EmptyViewWithLoading(isLoading: chatController.isLoading.value,message: 'No chat data available',)
                    :  ListView.builder(
                  itemCount: chatController.filteredChats.length,
                  itemBuilder: (context, index) {
                    var chat = chatController.filteredChats[index];
                    return Card(
                      elevation: 3,
                      // margin: const EdgeInsets.all(0.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ListTile(
                        leading: const CircleAvatar(
                          // Assuming a placeholder image for the demo user
                          backgroundImage: NetworkImage('https://picsum.photos/seed/picsum/200/300'),
                        ),
                        title: Text(chat.userId),
                        subtitle: Text(chat.reply),
                        trailing: CircleAvatar(
                            backgroundColor: context.theme.canvasColor,
                            minRadius: 15,
                            maxRadius: 18,
                            child: const TextAutoPoppins('2')), // Placeholder for new chat count
                        onTap: () {
                          Get.to(ChatDetailsScreen(chat: chat));
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }


}