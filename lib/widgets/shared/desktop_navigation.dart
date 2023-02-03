import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/profile/screens/profile_screen.dart';

class DesktopNavigation extends StatefulWidget {
  const DesktopNavigation({super.key});

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
              icon: Icon(Icons.mark_chat_unread_outlined),
              label: Text("Lời mời"),
              selectedIcon: Icon(Icons.mark_chat_unread_rounded)),
        ],
        labelType: NavigationRailLabelType.selected,
        selectedIndex: _selectedIndex,
        leading: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Image.asset(
            'assets/logo.png',
            width: 40,
          ),
        ),
        trailing: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://github.com/thangved.png',
              width: 40,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProfileScreen();
            }));
          },
        ),
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
