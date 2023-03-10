import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:messeenger_flutter/providers/auth_provider.dart';
import 'package:messeenger_flutter/services/friend_service.dart';
import 'package:messeenger_flutter/services/user_service.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final _debouncer =
      Debouncer<String>(const Duration(milliseconds: 500), initialValue: '');
  List<UserModel> _userList = [];
  bool _searched = true;

  @override
  void initState() {
    _debouncer.values.listen((event) async {
      final res = await UserService.search(_debouncer.value);

      setState(() {
        _userList = res;
        _searched = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gửi yêu cầu kết bạn"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 360,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        label: Text('Nhập email hoặc tên người dùng'),
                        hintText: "spiderman",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _searched = false;
                        });
                        _debouncer.value = text;
                      },
                    ),
                  ),
                  _searched
                      ? Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return RequestAddFriendItem(
                                user: _userList[index],
                                key: Key(_userList[index].username),
                              );
                            },
                            itemCount: _userList.length,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RequestAddFriendItem extends StatefulWidget {
  const RequestAddFriendItem({
    super.key,
    required UserModel user,
  }) : _user = user;

  final UserModel _user;

  @override
  State<RequestAddFriendItem> createState() => _RequestAddFriendItemState();
}

class _RequestAddFriendItemState extends State<RequestAddFriendItem> {
  bool _requested = false;
  bool _friend = true;

  @override
  Widget build(BuildContext context) {
    final bool isYou =
        widget._user.id == context.read<AuthProvider>().currentUser.id;
    final bool requested = widget._user.requested || _requested;
    final bool friend = widget._user.friend && _friend;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.black.withAlpha(10),
        ),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              widget._user.avatar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget._user.lastName} ${widget._user.firstName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '@${widget._user.username}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (isYou || requested) {
                return;
              }

              try {
                if (friend) {
                  if (await confirm(
                    context,
                    title: const Text('Cảnh báo'),
                    content: Text(
                        'Bạn chắc chắn muốn hủy kết bạn với ${widget._user.firstName}?'),
                    textOK: const Text('Hủy kết bạn'),
                    textCancel: const Text('Không'),
                  )) {
                    await FriendService.removeFriend(widget._user.id);
                    setState(() {
                      _friend = false;
                    });
                  }
                  return;
                }

                await FriendService.requestAddFriend(widget._user.id);
                setState(() {
                  _requested = true;
                });
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(e.toString()),
                    );
                  },
                );
              }
            },
            icon: isYou
                ? const Icon(Icons.person)
                : friend
                    ? const Icon(Icons.person_remove)
                    : requested
                        ? const Icon(Icons.check)
                        : const Icon(Icons.person_add),
            tooltip: isYou
                ? 'Đây là bạn'
                : friend
                    ? 'Hủy kết bạn'
                    : requested
                        ? 'Đã gửi'
                        : 'Kết bạn',
          ),
        ],
      ),
    );
  }
}
