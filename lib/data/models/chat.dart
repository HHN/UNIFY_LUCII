class Chat {
  final String eventId;
  final String userId;
  final String reply;

  Chat({required this.eventId, required this.userId, required this.reply});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      eventId: json['event_id'],
      userId: json['user_id'],
      reply: json['reply'],
    );
  }
}

class ChatHistory {
  final List<Chat> chatHistory;

  ChatHistory({required this.chatHistory});

  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    var list = json['chat_history'] as List;
    List<Chat> chatList = list.map((i) => Chat.fromJson(i)).toList();

    return ChatHistory(chatHistory: chatList);
  }
}