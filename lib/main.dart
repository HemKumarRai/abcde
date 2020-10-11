import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/Screen/OverViewScreen.dart';
import 'package:room_finder/Screen/RoomDetailScreen.dart';
import 'package:room_finder/Screen/edit_screen.dart';
import 'package:room_finder/Screen/signInScreen.dart';
import 'package:room_finder/Screen/signUpScreen.dart';
import 'package:room_finder/database/databaseMethods.dart';
import 'package:room_finder/helper/helper_function.dart';
import 'package:room_finder/provider/authProvider.dart';
import 'package:room_finder/provider/room_provider.dart';

void main() => runApp(SplashClass());

class SplashClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RoomProvider()),
        ChangeNotifierProvider.value(
          value: DataBaseMethods(),
        ),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: DataBaseMethods())
      ],
      child: MaterialApp(
        title: "Find Room Through Us",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: SplashBetween(),
        routes: {
          RoomsOverviewScreen.routName: (context) => RoomsOverviewScreen(),
          SignInScreen.routName: (context) => SignInScreen(),
          SignUpScreen.routName: (context) => SignUpScreen(),
          RoomDetailScreen.routName: (context) => RoomDetailScreen(),
          EditScreen.routName: (context) => EditScreen(),
        },
      ),
    );
  }
}

class SplashBetween extends StatefulWidget {
  @override
  _SplashBetweenState createState() => _SplashBetweenState();
}

class _SplashBetweenState extends State<SplashBetween> {
  bool isLoggedIn = false;
  HelperFunction helperFunction = new HelperFunction();

  getLoggedInInfo() {
    helperFunction.getUserLoggedInKey().then((val) {
      setState(() {
        isLoggedIn = val;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      getLoggedInInfo();
    });
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen.navigate(
          name: 'assets/images/splash.flr',
          backgroundColor: Colors.black12,
          startAnimation: 'Untitled',
          loopAnimation: 'Untitled',
          until: () => Future.delayed(Duration(seconds: 4)),
          next: (_) => RoomsOverviewScreen()),
    );
  }
}
