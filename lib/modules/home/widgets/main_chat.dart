import 'package:flutter/material.dart';
import 'package:messeenger_flutter/constaints/events.dart';
import 'package:messeenger_flutter/providers/chat_provider.dart';
import 'package:messeenger_flutter/services/chat_group_service.dart';
import 'package:messeenger_flutter/services/message_service.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';
import 'package:provider/provider.dart';

import '../../../models/chat_group_model.dart';
import '../../../models/message_model.dart';
import 'bottom_chat_form.dart';
import 'message_list.dart';

class MainChat extends StatelessWidget {
  const MainChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    bool isMobile = screenSize.width <= 800;

    return FutureBuilder(
      future: ChatGroupService.getById(context.watch<ChatProvider>().chatId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {}

        return snapshot.hasData
            ? Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withAlpha(30)),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Scaffold(
                      appBar: AppBar(
                        title: MainChatTitle(
                          chatGroup: snapshot.data ?? ChatGroupModel(),
                        ),
                        leading: isMobile
                            ? IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new),
                                onPressed: () {
                                  context.read<ChatProvider>().chatId = null;
                                  Navigator.of(context).pop();
                                },
                              )
                            : null,
                      ),
                      body: MainChatBody(
                        chatGroup: snapshot.data ?? ChatGroupModel(),
                      ),
                      backgroundColor: Colors.blue.withAlpha(10),
                    ),
                  ),
                ),
              )
            : const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}

class MainChatTitle extends StatelessWidget {
  const MainChatTitle({
    Key? key,
    required this.chatGroup,
  }) : super(key: key);

  final ChatGroupModel chatGroup;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: chatGroup.avatar != null
              ? NetworkImage(chatGroup.avatar ?? '')
              : null,
          child: chatGroup.avatar == null
              ? Text(chatGroup.name[0].toUpperCase())
              : null,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatGroup.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Đang hoạt động',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainChatBody extends StatefulWidget {
  const MainChatBody({
    Key? key,
    required this.chatGroup,
  }) : super(key: key);

  final ChatGroupModel chatGroup;

  @override
  State<MainChatBody> createState() => _MainChatBodyState();
}

class _MainChatBodyState extends State<MainChatBody> {
  List<MessageModel> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _initMessage();

    socket.on(NEW_MESSAGE, (data) async {
      final messageId = data['messageId'];
      final groupId = data['groupId'];

      if (groupId != widget.chatGroup.id) {
        return;
      }

      final newMessage = await MessageService.getMessage(messageId);

      setState(() {
        _messages.add(newMessage);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      });
    });
    super.initState();
  }

  void _initMessage() async {
    final res = await ChatGroupService.getAllMessages(widget.chatGroup.id);

    setState(() {
      _messages = res;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              MessageList(
                messages: _messages,
                scrollController: _scrollController,
              ),
              const BottomChatForm(),
            ],
          ),
        ),
      ],
    );
  }
}
