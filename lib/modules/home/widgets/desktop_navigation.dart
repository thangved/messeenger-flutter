import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/user-model.dart';
import 'package:messeenger_flutter/providers/auth-provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = context.read<AuthProvider>().currentUser;

    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black.withAlpha(30)))),
      child: NavigationRail(
        destinations: const [
          NavigationRailDestination(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: Text("Chat"),
              selectedIcon: Icon(Icons.chat_bubble_rounded)),
          NavigationRailDestination(
              icon: Icon(Icons.group_outlined),
              label: Text("Bạn bè"),
              selectedIcon: Icon(Icons.group)),
          NavigationRailDestination(
              icon: Icon(Icons.group_add_outlined),
              label: Text("Lời mời"),
              selectedIcon: Icon(Icons.group_add_rounded)),
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
