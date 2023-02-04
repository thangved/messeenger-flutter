import 'package:flutter/material.dart';
import 'package:messeenger_flutter/widgets/shared/profile_session.dart';

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
              icon: Icon(Icons.group_add_outlined),
              label: Text("Lời mời"),
              selectedIcon: Icon(Icons.group_add_rounded)),
        ],
        labelType: NavigationRailLabelType.selected,
        selectedIndex: _selectedIndex,
        leading: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Image.asset(
            'assets/logo.png',
            width: 40,
          ),
        ),
        trailing: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://yt3.ggpht.com/-4q2Qv2ST2eeXf4ZiNDQ-h7FZURUMaB8-h_mD6z0hJypffploao8K9Kj_wZhPgbtcWCdr1j8=s88-c-k-c0x00ffffff-no-rj-mo',
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
          });
        },
      ),
    );
  }
}
