import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/profile/screens/profile_screen.dart';

class ProfileSession extends StatelessWidget {
  const ProfileSession({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        'https://yt3.ggpht.com/-4q2Qv2ST2eeXf4ZiNDQ-h7FZURUMaB8-h_mD6z0hJypffploao8K9Kj_wZhPgbtcWCdr1j8=s88-c-k-c0x00ffffff-no-rj-mo',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Kim Minh Thắng',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('@thangved')
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        },
                        icon: const Icon(Icons.settings_outlined)),
                    IconButton(
                      onPressed: () {},
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
