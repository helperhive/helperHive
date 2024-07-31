import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/constants/chat_id_generate.dart';
import 'package:helperhive/backend/message_service/chat_service.dart';
import 'package:helperhive/model/message.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/model/user_model.dart';

class MessageProvider extends ChangeNotifier {
  //need to change this functions according to new schema
  final senderId = FirebaseAuth.instance.currentUser!.uid;
  final List<Message> _messages = [];
  ScrollController scrollController = ScrollController();
  List<Message> get messages => _messages;
  List<UserModel> _connections = [];
  final List<UserModel> _allUsers = [];
  List<UserModel> get users => _connections;
  UserModel? user;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void busy(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Stream<List<Message>> fetchMessages({required String receiverId}) {
    String chatId = ChatIdGenerate.generateChatId(senderId, receiverId);
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    });
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List<Message> messages = [];
  Stream<List<ServicePerson>> getConnections() {
    return _firestore
        .collection('workers')
        .where('connections', arrayContains: senderId)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ServicePerson.fromSnapshot(doc))
          .toList();
    });
  }

  UserModel? getUserById(String userId) {
    _firestore
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromSnapshot(user);
      notifyListeners();
    });
    return user;
  }

  // List<Message> getMessages(String receiverId) {
  //   _firestore
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('chat')
  //       .doc(receiverId)
  //       .collection('messages')
  //       .orderBy('sentTime', descending: false)
  //       .snapshots(includeMetadataChanges: true)
  //       .listen((messages) {
  //     this.messages =
  //         messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
  //     notifyListeners();

  //     scrollDown();
  //   });
  //   return messages;
  // }

  Future<List<UserModel>> searchUser(String name) async {
    _firestore
        .collection('Users')
        .where("name", isGreaterThanOrEqualTo: name)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      _connections =
          users.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
      notifyListeners();
    });
    return users;
    // return snapshot.docs.map((doc) => UserData.fromSnapshot(doc)).toList();
  }

  void onSearch(String? search) {
    // _allUsers = users;

    if (search!.isEmpty) {
      _connections = _allUsers;
    }
    _connections = _allUsers
        .where((user) => user.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> checkChat({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      busy(true);
      bool isExist = await ChatService.checkChatExist(senderId, receiverId);
      if (!isExist) {
        await ChatService.createNewChat(senderId, receiverId);
      }
      busy(false);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
