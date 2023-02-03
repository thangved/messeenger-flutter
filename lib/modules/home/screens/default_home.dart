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
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          icon: Icon(Icons.login),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 400,
              height: double.maxFinite,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 100,
                        child: Text('Hello'),
                        decoration: BoxDecoration(color: Colors.black),
                      )
                    ],
                  )
                ],
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
