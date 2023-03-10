import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/chat_group_model.dart';

class UserInfo extends StatelessWidget {
  UserInfo({
    Key? key,
    this.chatGroup,
  }) : super(key: key);

  ChatGroupModel? chatGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 1,
            color: Colors.black.withAlpha(30),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: chatGroup?.avatar != null
                      ? NetworkImage(chatGroup?.avatar ?? '')
                      : null,
                  radius: 64,
                  child: chatGroup?.avatar == null
                      ? Text(chatGroup?.name.toUpperCase()[0] ?? '')
                      : null,
                ),
                Text(
                  '${chatGroup?.name}',
                  style: const TextStyle(
                    fontSize: 24,
                    height: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
