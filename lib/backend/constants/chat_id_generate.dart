class ChatIdGenerate {
  static String generateChatId(String senderId, String receiverId) {
    List uids = [senderId, receiverId];
    uids.sort();
    String chatId = uids[0] + uids[1];
    return chatId;
  }
}
