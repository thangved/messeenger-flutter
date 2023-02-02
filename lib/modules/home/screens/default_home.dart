import 'dart:math';

import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/auth/screens/login_page.dart';

class DefaultHome extends StatelessWidget {
  const DefaultHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          InkWell(
            child: Text('Go to login page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 400,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.black12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
