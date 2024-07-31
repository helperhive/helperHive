import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/message_provider.dart';

import 'package:helperhive/constants/hover_button.dart';
import 'package:helperhive/model/service_person.dart';

import 'package:helperhive/screens/chats/screens/messages_view.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  final Function(bool)? navigate;
  const ChatView({super.key, this.navigate});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          // backgroundColor: blueColor,
          centerTitle: false,
          title: const Text(
            'Chats',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  size: 32,
                  color: Colors.black,
                )),
            const SizedBox(
              width: 10,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: SearchBarHome(
              onSearch: provider.onSearch,
              searchText: 'Search',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: StreamBuilder<List<ServicePerson>>(
            stream: provider.getConnections(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No connections found'));
              } else {
                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    ServicePerson user = users[index];
                    return UserItem(
                      user: user,
                      // navigate: (bool val) {
                      //   widget.navigate!(val);
                      // },
                      onChatSelected: () {
                        widget.navigate?.call(true);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MessagesView(
                              uid: user.uid,
                              onBack: (bool val) {
                                widget.navigate!.call(false);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      );
    });
  }
}

class UserItem extends StatelessWidget {
  final Function() onChatSelected;
  // final Function(bool)? navigate;
  const UserItem({
    super.key,
    required this.user,
    required this.onChatSelected,
    // this.navigate,
  });
  final ServicePerson user;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {
        onChatSelected();
        // navigate?.call(true);
        // print(widget.user.name);
      },
      child: ListTile(
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 25,
              foregroundImage:
                  user.profileUrl != '' ? NetworkImage(user.profileUrl) : null,
              child: user.profileUrl == '' ? Text(user.name[0]) : null,
            ),
          ],
        ),
        title: Text(
          user.name,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          // 'Last seen: ${timeago.format()}',
          user.service.toService(),
          maxLines: 2,
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
