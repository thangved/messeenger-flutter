import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messeenger_flutter/modules/auth/screens/login_screen.dart';
import 'package:messeenger_flutter/modules/auth/screens/register_screen.dart';
import 'package:messeenger_flutter/modules/home/screens/default_home.dart';
import 'package:messeenger_flutter/modules/profile/screens/profile_screen.dart';
import 'package:messeenger_flutter/providers/auth-provider.dart';
import 'package:messeenger_flutter/utils/token-util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      routes: {
        '/': (context) => context.watch<AuthProvider>().logged
            ? DefaultHome()
            : LoginScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        // '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
