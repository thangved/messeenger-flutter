import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/chat_group_model.dart';
import 'package:messeenger_flutter/models/message_model.dart';
import 'package:messeenger_flutter/modules/home/widgets/main_chat.dart';
import 'package:messeenger_flutter/providers/chat_provider.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';
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
          id: group.id,
          img: group.avatar,
          name: group.name,
          lastMessage: group.lastMessage,
        );
      },
      itemCount: chatList.length,
    );
  }
}

class ChatUserItem extends StatefulWidget {
  const ChatUserItem({
    Key? key,
    required this.id,
    this.img,
    required this.name,
    required this.lastMessage,
  }) : super(key: key);

  final String id;
  final String? img;
  final String name;
  final MessageModel? lastMessage;

  @override
  State<ChatUserItem> createState() => _ChatUserItemState();
}

class _ChatUserItemState extends State<ChatUserItem> {
  @override
  void initState() {
    socket.emit(
      'join',
      {
        'groupId': widget.id,
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool active = widget.id == context.watch<ChatProvider>().chatId;
    Size screenSize = MediaQuery.of(context).size;

    bool isMobile = screenSize.width <= 800;

    final textColor = active ? Colors.blue : Colors.black;
    final backgroundColor =
        active ? Colors.blue.withAlpha(20) : Colors.transparent;

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: widget.img != null
                  ? Image.network(
                      widget.img ?? '',
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    )
                  : CircleAvatar(
                      child: Text(widget.name[0].toUpperCase()),
                    ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    if (widget.lastMessage != null)
                      Text(
                        '${widget.lastMessage?.createdBy.firstName}${(widget.lastMessage?.deletedAt != null) ? '' ' đã xóa 1 tin nhắn' : widget.lastMessage?.type == 'file' ? ' đã gửi 1 ảnh' : ': ${widget.lastMessage?.content ?? ''}'}',
                        style: TextStyle(
                          color: textColor,
                        ),
                      )
                    else
                      const Text("Đoạn chat chưa có tin nhắn"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        context.read<ChatProvider>().chatId = widget.id;
        if (isMobile) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MainChat(),
          ));
        }
      },
    );
  }
}
