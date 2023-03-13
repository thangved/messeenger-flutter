import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/home/screens/chat_user_screen.dart';
import 'package:messeenger_flutter/modules/home/screens/friend_list_sceen.dart';
import 'package:messeenger_flutter/modules/home/screens/request_list_screen.dart';
import 'package:messeenger_flutter/modules/home/widgets/desktop_navigation.dart';
import 'package:messeenger_flutter/modules/home/widgets/main_chat.dart';
import 'package:messeenger_flutter/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _DefaultHomeState();
}

class _DefaultHomeState extends State<DefaultHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const widgets = [
      ChatUserScreen(),
      FriendListScreen(),
      RequestListScreen(),
    ];
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            DesktopNavigation(
              setSelectedIndex: (newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
            ),
            widgets[_currentIndex],
            context.watch<ChatProvider>().chatId != null
                ? const MainChat()
                : Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.messenger_outline_rounded,
                            size: 50,
                          ),
                          Text('Vui lòng chọn một đoạn chat'),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
