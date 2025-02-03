import 'dart:convert';
import 'package:get/get.dart';
import 'package:lucii/data/models/chat.dart';
import 'package:http/http.dart' as http;
import 'package:lucii/ui/features/bottom_navigation/posts_notification/post_notification_details/chat_screen/chat_details/chat_details_screen.dart';

class ChatListController extends GetxController {

  RxBool isLoading = false.obs;

  Future<void> getData() async {
    Future.delayed(const Duration(seconds: 1), () {});
  }

  /// for real dynamic data
/*  var chats = <Chat>[].obs;
  var chatHistory = <Message>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  void fetchChats() async {
    var response = await http.get(Uri.parse('https://api.example.com/chats'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      chats.value = data.map((chat) => Chat.fromJson(chat)).toList();
    }
  }

  void fetchChatHistory(String userId) async {
    var response = await http.get(Uri.parse('https://api.example.com/chat_history/$userId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      chatHistory.value = data.map((message) => Message(
        content: message['message'],
        isSentByUser: message['user_id'] == userId, // Assuming the userId is the same as the current user
      )).toList();
    }
  }

  List<Chat> get filteredChats {
    if (searchQuery.isEmpty) {
      return chats;
    } else {
      return chats.where((chat) => chat.userId.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }*/

  /// for demo data
  var chats = <Chat>[
    Chat(eventId: '1', userId: 'Jhon Doe', reply: 'Hello!'),
    Chat(eventId: '2', userId: 'Maria', reply: 'How are you?'),
  ].obs;

  var chatHistory = <String>[
    'Hello!',
    'Hello! How are you?',
    'I am fine, thank you!'
  ].obs;

  var searchQuery = ''.obs;

  List<Chat> get filteredChats {
    if (searchQuery.isEmpty) {
      return chats;
    } else {
      return chats.where((chat) => chat.userId.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }
}
