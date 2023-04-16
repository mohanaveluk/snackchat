import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackchat/NewScreen/LandingScreen.dart';
import 'package:snackchat/Screens/ChatScreen.dart';
import 'package:snackchat/Screens/chat_home_screen.dart';
import 'package:snackchat/Screens/customers.dart';
import 'package:snackchat/Screens/chat_overview_screen.dart';
import 'package:snackchat/Screens/loginScreen.dart';
import 'package:snackchat/providers/chat_detail.dart';
import 'package:snackchat/providers/chatusers.dart';
import 'package:snackchat/widgets/login_mobile.dart';
import 'Screens/IndividualPage.dart';
import 'providers/auth.dart';
import 'providers/userAuthentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserAuthentication()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<UserAuthentication, ChatUsers>(
          update: (ctx, auth, previousUsers) => ChatUsers(auth.token ?? '',
              previousUsers == null ? [] : previousUsers.rooms),
          create: (ctx) => ChatUsers('', []),
        ),
        //ChangeNotifierProvider.value(value: ChatDetail()),
        ChangeNotifierProxyProvider<UserAuthentication, ChatDetail>(
            update: (ctx, auth, _) => ChatDetail(auth.token!),
            create: (ctx) => ChatDetail('')),
      ],
      child: Consumer<UserAuthentication>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFFE65100),
            accentColor: Color(0xFFFFB74D),
            appBarTheme: AppBarTheme(color: Color(0xFFE65100)),
          ),
          //home: auth.isAuth ? ChatOverviewScreen() : LandingScreen(),
          home: FutureBuilder(
              future: auth.isAuth,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null && snapshot.data == 'true') {
                      return const ChatOverviewScreen();
                    } else {
                      return const LandingScreen();
                    }
                  } else {
                    return const LandingScreen();
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          routes: {
            ChatScreen.routeName: (ctx) => ChatScreen(),
            Customers.routeName: (ctx) => Customers(),
            ChatOverviewScreen.routeName: (ctx) => ChatOverviewScreen(),
            ChatHome.routeName: (ctx) => ChatHome.fromBase64(auth.token!),
            IndividualPage.routeName: (ctx) => IndividualPage(),
          },
        ),
      ),
    );
  }
}
