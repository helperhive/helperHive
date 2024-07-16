class Chat {
  final String chatId;
  final List members;

  Chat({required this.chatId, required this.members});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'members': members,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(chatId: map['chatId'] as String, members: map['members']);
  }

  // String toJson() => json.encode(toMap());

  // factory Chat.fromJson(String source) =>
  //     Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}
