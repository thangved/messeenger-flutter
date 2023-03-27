import 'package:flutter/material.dart';
import 'package:messeenger_flutter/constaints/events.dart';
import 'package:messeenger_flutter/models/user_model.dart';
import 'package:messeenger_flutter/providers/auth_provider.dart';
import 'package:messeenger_flutter/services/friend_service.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';
import 'package:messeenger_flutter/widgets/shared/profile_session.dart';
import 'package:provider/provider.dart';

class DesktopNavigation extends StatefulWidget {
  const DesktopNavigation({super.key, required this.setSelectedIndex});

  final void Function(int) setSelectedIndex;

  @override
  State<DesktopNavigation> createState() => _DesktopNavigationState();
}

class _DesktopNavigationState extends State<DesktopNavigation> {
  int _selectedIndex = 0;
  int _requestCount = 0;

  @override
  void initState() {
    _selectedIndex = 0;
    _setRequestCount();

    socket.on(REQUEST_ADD_FRIEND, (data) => {_setRequestCount()});
    socket.on(ACCEPT_ADD_FRIEND, (data) => {_setRequestCount()});

    super.initState();
  }

  void _setRequestCount() async {
    final res = await FriendService.getAllRequests();
    setState(() {
      _requestCount = res.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = context.read<AuthProvider>().currentUser;

    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black.withAlpha(30)))),
      child: NavigationRail(
        destinations: [
          const NavigationRailDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: Text("Chat"),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.group_outlined),
            label: Text("Bạn bè"),
            selectedIcon: Icon(Icons.group),
          ),
          NavigationRailDestination(
            icon: Badge(
              label: Text(_requestCount.toString()),
              child: const Icon(Icons.group_add_outlined),
            ),
            label: const Text("Lời mời"),
            selectedIcon: const Icon(Icons.group_add_rounded),
          ),
        ],
        labelType: NavigationRailLabelType.selected,
        selectedIndex: _selectedIndex,
        leading: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Image.asset(
            'assets/icon.png',
            width: 60,
          ),
        ),
        trailing: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              currentUser.avatar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (context) => const ProfileSession(),
            );
          },
        ),
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            widget.setSelectedIndex(index);
          });
        },
      ),
    );
  }
}
