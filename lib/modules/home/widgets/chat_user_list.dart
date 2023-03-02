import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/chat_group_model.dart';
import 'package:messeenger_flutter/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatUserList extends StatelessWidget {
  const ChatUserList({
    Key? key,
    required this.chatList,
  }) : super(key: key);

  final List<ChatGroupModel> chatList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final group = chatList[index];
        return ChatUserItem(
          img: group.avatar,
          name: group.name,
          lastMessage: group.lastMessage.content,
          active: context.watch<ChatProvider>().chatIndex == index,
          onTap: () {
            context.read<ChatProvider>().chatIndex = index;
          },
        );
      },
      itemCount: chatList.length,
    );
  }
}

class ChatUserItem extends StatelessWidget {
  const ChatUserItem({
    Key? key,
    required this.img,
    required this.name,
    required this.lastMessage,
    this.active = false,
    required this.onTap,
  }) : super(key: key);

  final String img;
  final String name;
  final String lastMessage;
  final bool active;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = active ? Colors.blue : Colors.black;
    final backgroundColor =
        active ? Colors.blue.withAlpha(20) : Colors.transparent;

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: img.isNotEmpty
                  ? Image.network(
                      img,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    )
                  : CircleAvatar(
                      child: Text(name[0].toUpperCase()),
                    ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      lastMessage,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
