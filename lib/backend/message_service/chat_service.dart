import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:helperhive/backend/constants/chat_id_generate.dart';
import 'package:helperhive/model/chat.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> checkChatExist(String senderId, String receiverId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('chats')
        .where('chatId',
            isEqualTo: ChatIdGenerate.generateChatId(senderId, receiverId))
        .get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<void> createNewChat(String senderId, String receiverId) async {
    String chatId = ChatIdGenerate.generateChatId(senderId, receiverId);
    try {
      Chat chat = Chat(
        chatId: chatId,
        members: [senderId, receiverId],
      );
      // Message message=Message(senderId: senderId, receiverId: receiverId, sentTime: DateTime.now(), content: content, messageType: messageType)
      await _firestore.collection('chats').doc(chatId).set(chat.toMap());
      await _firestore.collection('users').doc(senderId).update({
        'connections': FieldValue.arrayUnion([receiverId]),
      });
      await _firestore.collection('workers').doc(receiverId).update({
        'connections': FieldValue.arrayUnion([senderId]),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
