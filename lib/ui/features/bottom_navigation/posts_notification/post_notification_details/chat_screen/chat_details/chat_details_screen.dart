import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/data/models/chat.dart';
import 'package:lucii/ui/features/bottom_navigation/posts_notification/post_notification_details/chat_screen/chat_list_controller.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/button_util.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_field_util.dart';
import 'package:lucii/utils/text_util.dart';

class ChatDetailsScreen extends StatefulWidget {
  final Chat chat;

  const ChatDetailsScreen({super.key, required this.chat});

  @override
  ChatDetailsScreenState createState() => ChatDetailsScreenState();
}

class ChatDetailsScreenState extends State<ChatDetailsScreen> {
  /// For dynamic data
/*
  final ChatListController chatListController = Get.find();
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      chatListController.chatHistory.add(Message(content: _controller.text, isSentByUser: true));
      _controller.clear();
      // You can also send the message to the backend here
    }
  }*/

  /// For demo data
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = <Message>[].obs; // Using a Message model for clarity

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _messages.add(Message(content: _controller.text, isSentByUser: true));
      _controller.clear();
      // You can also send the message to the backend here
    }
  }

  @override
  void initState() {
    super.initState();

    ///  For demo data
    // For demo purposes, adding static messages comment for dynamic data
   _messages.addAll([
      Message(content: 'Hello!', isSentByUser: true),
      Message(content: 'Hello! How are you?', isSentByUser: false),
      Message(content: 'I am fine, thank you!', isSentByUser: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColorLight,
      appBar: AppBarMainWithBackAndActions(context: context, title: widget.chat.userId),
      /// For dynamic data
/*      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatListController.chatHistory.length,
                itemBuilder: (context, index) {
                  var message = chatListController.chatHistory[index];
                  return Align(
                    alignment: message.isSentByUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.isSentByUser
                            ? context.theme.focusColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message.content,
                        style: TextStyle(
                          color: message.isSentByUser
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldView(
                    controller: _controller,
                    hint: "Type a message".tr,
                    inputType: TextInputType.text,
                  ),
                ),
                hSpacer10(),
                ButtonOnlyCircleIcon(
                  iconData: Icons.send, iconSize: 25,
                  onTap: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),*/

      ///for Demo data
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    var message = _messages[index];
                    return Align(
                      alignment: message.isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message.isSentByUser
                              ? context.theme.focusColor
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            color: message.isSentByUser
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldView(
                      controller: _controller,
                      hint: "Type a message".tr,
                      inputType: TextInputType.text,
                    ),
                  ),
                  hSpacer10(),
                  ButtonOnlyCircleIcon(
                    iconData: Icons.send, iconSize: 25,
                    onTap: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final bool isSentByUser;

  Message({required this.content, required this.isSentByUser});
}
