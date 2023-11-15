import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:connect_frontend/views/home.dart';
import 'package:connect_frontend/views/login.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:connect_frontend/views/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final Config config = Config(
  tenant: "f8cdef31-a31e-4b4a-93e4-5f571e91255a",
  clientId: "629ead3f-87b5-4836-9ce9-9ae31a73d272",
  scope: "openid profile offline_access",
  // redirectUri is Optional as a default is calculated based on app type/web location
  redirectUri: "https://login.live.com/oauth20_desktop.srf",
  navigatorKey: navigatorKey,
  webUseRedirect:
      true, // default is false - on web only, forces a redirect flow instead of popup auth
  //Optional parameter: Centered CircularProgressIndicator while rendering web page in WebView
  loader: const Center(child: CircularProgressIndicator()),
);

final AadOAuth oauth = AadOAuth(config);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
      title: 'Home',
      initialRoute: "/",
      navigatorKey: navigatorKey,
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        '/': (context) => const Welcome(),
        '/profile': (context) => const ProfileScreen(),
      },
    ));
  }
}
