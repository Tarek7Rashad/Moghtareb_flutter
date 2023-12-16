import 'package:flutter/material.dart';
import 'package:moghtareb/screens/Login_Screen.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/widget/CustomButton.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  static const String id = "StartScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Ensures that the body extends behind the app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight,
        ), // Specify desired height for the app bar
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Image.asset(
                'assets/images/Moghtareb-removebg-preview.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'MOGHTAREB',
                style: TextStyle(fontSize: 16, color: kgreyColor),
              ),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/images/hand-holding-house.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -50,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(64), topRight: Radius.circular(64)),
              color: kgreyColor,
            ),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: SizedBox(
                height: 64,
                child: CustomButtonWidget(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.id);
                  },
                  text: 'Get Started',
                  width: 200,
                  color: kblackColor,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
