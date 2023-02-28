import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/home/widgets/chat_user_list.dart';
import 'package:messeenger_flutter/modules/home/widgets/desktop_navigation.dart';
import 'package:messeenger_flutter/modules/home/widgets/friend_list.dart';
import 'package:messeenger_flutter/modules/home/widgets/main_chat.dart';
import 'package:messeenger_flutter/providers/auth-provider.dart';
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
    const widgets = [ChatUserList(), FriendList(), Text('Yêu cầu kết bạn')];
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
            const MainChat(),
          ],
        ),
      ),
    );
  }
}
