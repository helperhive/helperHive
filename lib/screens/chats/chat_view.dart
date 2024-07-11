import 'package:flutter/material.dart';
import 'package:helperhive/constants/hover_button.dart';
import 'package:helperhive/model/user_model.dart';
import 'package:helperhive/widgets/search_bar_home.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: SearchBarHome(
            // onSearch: onSearch,
            searchText: 'Search',
          ),
        ),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  final Function(UserModel) onChatSelected;
  const UserItem({
    super.key,
    required this.user,
    required this.onChatSelected,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {
        onChatSelected(user);

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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 4, right: 3),
            //   child: CircleAvatar(
            //     radius: 5,
            //     backgroundColor: user.isonline ? Colors.green : Colors.red,
            //   ),
            // )
          ],
        ),
        title: Text(
          user.name,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          // 'Last seen: ${timeago.format()}',
          user.service.toString(),
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
