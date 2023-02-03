import 'package:flutter/material.dart';

class ChatUserList extends StatefulWidget {
  const ChatUserList({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatUserList> createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.black.withAlpha(30))),
        child: ListView(
          children: [
            ChatUserItem(
              img: 'https://github.com/thangved.png',
              name: 'Kim Minh Thắng',
              lastMessage: 'Hello bà',
              active: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ChatUserItem(
              img:
                  'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
              name: 'Kim Minh Thắng',
              lastMessage: 'Hello bà',
              active: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
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
              child: Image.network(
                img,
                width: 40,
                height: 40,
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
