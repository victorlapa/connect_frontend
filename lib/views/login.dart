// import 'package:aad_oauth/aad_oauth.dart';
// import 'package:aad_oauth/model/config.dart';
// import 'package:aad_oauth/model/failure.dart';
// import 'package:aad_oauth/model/token.dart';
// import 'package:flutter/material.dart';

// final navigatorKey = GlobalKey<NavigatorState>();

// final Config config = new Config(
//   tenant: "f8cdef31-a31e-4b4a-93e4-5f571e91255a",
//   clientId: "ad8d717f-82af-4899-8655-7691d010dc79",
//   scope: "openid profile offline_access",
//   // redirectUri is Optional as a default is calculated based on app type/web location
//   redirectUri: "msalad8d717f-82af-4899-8655-7691d010dc79://auth",
//   navigatorKey: navigatorKey,
//   webUseRedirect:
//       true, // default is false - on web only, forces a redirect flow instead of popup auth
//   //Optional parameter: Centered CircularProgressIndicator while rendering web page in WebView
//   loader: const Center(child: CircularProgressIndicator()),
// );

// final AadOAuth oauth = new AadOAuth(config);

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   _loginWithMicrosoft() async {
//     var result = await oauth.login();

//     result.fold(
//       (Failure failure) {
//         // Auth failed, show error
//       },
//       (Token token) async {
//         if (token.accessToken == null) {
//           // Handle missing access token, show error or whatever
//           return;
//         }

//         // Handle successful login
//         print(
//             'Logged in successfully, your access token: ${token.accessToken!}');

//         // Perform necessary actions with the access token, such as API calls or storing it securely.

//         await oauth.logout();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () => _loginWithMicrosoft(),
//         child: const Text('Log in with Microsoft'),
//       ),
//     );
//   }
// }
