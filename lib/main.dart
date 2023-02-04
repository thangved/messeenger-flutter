import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messeenger_flutter/widgets/shared/chat_user_list.dart';
import 'package:messeenger_flutter/widgets/shared/desktop_navigation.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap your app
      ),
    );

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
      home: Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              DesktopNavigation(),
              ChatUserList(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withAlpha(30)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.black.withAlpha(30), width: 1),
                            ),
                          ),
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
                                margin: EdgeInsets.only(left: 20),
                                child: Text('Kim Minh Thắng'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
