import 'package:flutter/material.dart';

import 'message_item.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            MyMessage(),
            OtherUserMessage(),
          ],
        ),
      ),
    );
  }
}
