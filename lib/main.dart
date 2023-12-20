import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/firebase_options.dart';
import 'package:moghtareb/screens/Favorite_Screen.dart';
import 'package:moghtareb/screens/UnitDetails.dart';
import 'package:moghtareb/screens/admin/AddUnit_Screen.dart';
import 'package:moghtareb/screens/admin/AdminHome_Screen.dart';
import 'package:moghtareb/screens/Home_Screen.dart';
import 'package:moghtareb/screens/LoginAsAdmin_Screen.dart';
import 'package:moghtareb/screens/Login_Screen.dart';
import 'package:moghtareb/screens/Profile_Screen.dart';
import 'package:moghtareb/screens/SignUp_Screen.dart';
import 'package:moghtareb/screens/Start_Screen.dart';
import 'package:moghtareb/screens/admin/ControlUnit_Screen.dart';
import 'package:moghtareb/screens/admin/EditUnit_Screen.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Moghtareb());
}

// ignore: use_key_in_widget_constructors, must_be_immutable
class Moghtareb extends StatelessWidget {
  // const Moghtareb({super.key});
  bool isLoggedIn = true;
  bool isAdminLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  'loading...',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        } else {
          isLoggedIn = snapshot.data!.getBool(kRememberMe) ?? false;
          isAdminLoggedIn = snapshot.data!.getBool(kAdminRememberMe) ?? false;

          // print(isLoggedIn);
          log(snapshot.data!.getBool(kRememberMe).toString());
          return BlocProvider(
            create: (context) => MoghtarebCubit(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isLoggedIn ? userRoute() : adminRoute(),
              routes: {
                LoginScreen.id: (context) => const LoginScreen(),
                SignUpScreen.id: (context) => const SignUpScreen(),
                HomeScreen.id: (context) => const HomeScreen(),
                StartScreen.id: (context) => const StartScreen(),
                ProfilePage.id: (context) => const ProfilePage(),
                LoginAsAdminScreen.id: (context) => const LoginAsAdminScreen(),
                AdminHome.id: (context) => const AdminHome(),
                AddUnit.id: (context) => const AddUnit(),
                ControlUnit.id: (context) => const ControlUnit(),
                EditUnit.id: (context) => const EditUnit(),
                UnitInfo.id: (context) => const UnitInfo(),
                FavoriteScreen.id: (context) => const FavoriteScreen(),
              },
              themeMode: ThemeMode.system,
            ),
          );
        }
      },
    );
  }

  userRoute() {
    if (isLoggedIn == true) {
      return HomeScreen.id;
    } else if (isLoggedIn == false) {
      return StartScreen.id;
    }
  }

  adminRoute() {
    if (isAdminLoggedIn == true) {
      return AdminHome.id;
    } else if (isAdminLoggedIn == false) {
      return LoginScreen.id;
    }
  }
}
