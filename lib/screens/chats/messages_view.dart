import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/message_provider.dart';
import 'package:helperhive/model/message.dart';
import 'package:helperhive/model/user_model.dart';
import 'package:provider/provider.dart';

import 'widgets/chat_field.dart';
import 'widgets/message_bubble.dart';

class MessagesView extends StatefulWidget {
  final Function(bool)? onBack;
  final UserModel selectedUser;
  // final String userId;
  const MessagesView({
    super.key,
    required this.selectedUser,
    this.onBack,
  });

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchMessages(widget.selectedUser.uid);
  }

  @override
  void didUpdateWidget(MessagesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedUser != widget.selectedUser) {
      WidgetsBinding.instance.addObserver(this);
      fetchMessages(widget.selectedUser.uid);
    }
  }

  void fetchMessages(String userId) {
    Provider.of<MessageProvider>(context, listen: false)
      ..getUserById(userId)
      ..fetchMessages(
          senderId: FirebaseAuth.instance.currentUser!.uid, receiverId: userId);
    // print("message card: ${widget.selectedUser.name}");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: messageCardAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(
                receiverId: widget.selectedUser.uid,
              ),
            ),
            // const Spacer(),
            // ChatTextField(),
          ],
        ),
      ),
      bottomNavigationBar: ChatTextField(
        receiverId: widget.selectedUser.uid,
      ),
    );
  }

  AppBar messageCardAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      title: Consumer<MessageProvider>(builder: (context, value, child) {
        return value.user != null
            ? Row(
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       if (widget.onBack != null) {
                  //         widget.onBack!(false);
                  //       }
                  //     },
                  //     icon: const Icon(
                  //       Icons.arrow_back_ios,
                  //       color: Colors.blue,
                  //     )),
                  // const SizedBox(
                  //   width: 15,
                  // ),
                  CircleAvatar(
                    radius: 20,
                    foregroundImage: value.user!.profileUrl != ''
                        ? NetworkImage(value.user!.profileUrl)
                        : null,
                    child: value.user!.profileUrl == ''
                        ? Text(value.user!.name[0])
                        : null,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        value.user!.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        value.user!.service.toString(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                ],
              )
            : const SizedBox();
      }),
    );
  }
}

class ChatMessages extends StatefulWidget {
  final String receiverId;
  const ChatMessages({super.key, required this.receiverId});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, value, child) {
      return value.messages.isEmpty
          ? const EmptyWidget(icon: Icons.waving_hand, text: 'Say Hello!')
          : ListView.builder(
              controller: value.scrollController,
              itemCount: value.messages.length,
              itemBuilder: (context, index) {
                final isTextMessaage =
                    value.messages[index].messageType == MessageType.text;
                final isMe =
                    widget.receiverId != value.messages[index].senderId;
                // final isMe = value.messages[index].senderId ==
                //     FirebaseAuth.instance.currentUser!.uid;
                return isTextMessaage
                    ? MessageBubble(
                        message: value.messages[index],
                        isMe: isMe,
                        isImage: false,
                      )
                    : MessageBubble(
                        message: value.messages[index],
                        isMe: isMe,
                        isImage: true,
                      );
              });
    });
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
}
