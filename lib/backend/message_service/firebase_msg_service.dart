import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helperhive/backend/constants/chat_id_generate.dart';
import 'package:helperhive/backend/notification_service/notification_services.dart';
import 'package:helperhive/backend/storage/firebase_storage.dart';
import 'package:helperhive/model/message.dart';

class FirebaseFirestoreServiceMessages {
  static final firestore = FirebaseFirestore.instance;
  static final currentUid = FirebaseAuth.instance.currentUser!.uid;
  static final notificationService = NotificationServices();
  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
    required String deviceToken,
    required String name,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: currentUid,
    );
    await _addMessageToChat(
        receiverId: receiverId, message: message, senderId: currentUid);
    print('messsage notification');
    notificationService.sendDeviceNotification(
        deviceToken: deviceToken, body: content, title: '$name sent a chat');
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
    required String deviceToken,
    required String name,
  }) async {
    String chatId = ChatIdGenerate.generateChatId(currentUid, receiverId);
    final image = await StorageMethods.uploadImageToStorage(
        file: file, childName: 'image/chat/${DateTime.now()}', chatId: chatId);

    final message = Message(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: currentUid,
    );
    await _addMessageToChat(
        receiverId: receiverId, message: message, senderId: currentUid);

    notificationService.sendDeviceNotification(
        deviceToken: deviceToken, body: 'image', title: '$name sent a image');
  }

  static Future<void> _addMessageToChat({
    required String receiverId,
    required Message message,
    required String senderId,
  }) async {
    String chatId = ChatIdGenerate.generateChatId(senderId, receiverId);
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toJson());
    // await firestore
    //     .collection('Users')
    //     .doc(currentUid)
    //     .collection('chat')
    //     .doc(receiverId)
    //     .collection('messages')
    //     .add(message.toJson());

    // await firestore
    //     .collection('Users')
    //     .doc(receiverId)
    //     .collection('chat')
    //     .doc(currentUid)
    //     .collection('messages')
    //     .add(message.toJson());
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async =>
      await firestore.collection('Users').doc(currentUid).update(data);
}
