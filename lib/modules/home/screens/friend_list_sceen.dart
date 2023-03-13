import 'package:flutter/material.dart';
import 'package:messeenger_flutter/constaints/events.dart';
import 'package:messeenger_flutter/modules/home/screens/add_friend_screen.dart';
import 'package:messeenger_flutter/modules/home/widgets/friend_list.dart';
import 'package:messeenger_flutter/services/friend_service.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  void initState() {
    socket.on(ACCEPT_ADD_FRIEND, (data) => {setState(() {})});
    socket.on(REMOVE_FRIEND, (date) => {setState(() {})});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withAlpha(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'Bạn bè',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const AddFriendScreen();
                    }));
                  },
                  icon: const Icon(Icons.person_add_alt),
                  tooltip: 'Thêm bạn bè',
                )
              ],
            ),
          ),
          FutureBuilder(
            future: FriendService.getAllFriends(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(snapshot.error.toString()),
                    );
                  },
                );
              }

              return snapshot.hasData
                  ? FriendList(
                userList: snapshot.data,
                refresh: () {
                  setState(() {});
                },
              )
                  : const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
