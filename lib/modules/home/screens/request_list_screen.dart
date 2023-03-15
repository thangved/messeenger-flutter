import 'package:flutter/material.dart';
import 'package:messeenger_flutter/constaints/events.dart';
import 'package:messeenger_flutter/modules/home/widgets/request_list.dart';
import 'package:messeenger_flutter/services/friend_service.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  @override
  void initState() {
    socket.on(REQUEST_ADD_FRIEND, (data) => {setState(() {})});
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
            child: const Text(
              'Yêu cầu kết bạn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          FutureBuilder(
            future: FriendService.getAllRequests(),
            builder: (context, snapshot) {
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
                  ? RequestList(
                      userList: snapshot.data ?? [],
                      refresh: () {
                        setState(() {});
                      },
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
