import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messeenger_flutter/modules/home/screens/default_home.dart';
import 'package:messeenger_flutter/providers/auth-provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
          child: const MyApp(),
        ), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.watch<AuthProvider>().logged) {
      return Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().accessToken = "token";
              },
              child: Text(context.read<AuthProvider>().logged
                  ? context.read<AuthProvider>().accessToken
                  : 'Login'),
            )
          ],
        ),
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const DefaultHome(),
    );
  }
}
