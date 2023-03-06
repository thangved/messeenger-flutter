import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/user_model.dart';
import 'package:messeenger_flutter/modules/profile/screens/profile_screen.dart';
import 'package:messeenger_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileSession extends StatelessWidget {
  const ProfileSession({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = context.read<AuthProvider>().currentUser;

    return Container(
      padding: const EdgeInsets.all(10),
      height: 300,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black.withAlpha(10),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        currentUser.avatar,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${currentUser.lastName} ${currentUser.firstName}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(currentUser.username)
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        },
                        icon: const Icon(Icons.settings_outlined)),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<AuthProvider>().logout();
                      },
                      icon: const Icon(Icons.logout_rounded),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
