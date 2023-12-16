import 'package:flutter/material.dart';
import 'package:moghtareb/screens/Home_Screen.dart';
import 'package:moghtareb/screens/admin/AddUnit_Screen.dart';
import 'package:moghtareb/screens/admin/ControlUnit_Screen.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/widget/CustomButton.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
  static const String id = "AdminHome";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
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
              style: TextStyle(fontSize: 16, color: kblueColor),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButtonWidget(
                text: "Add Unit",
                onPressed: () {
                  Navigator.of(context).pushNamed(AddUnit.id);
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: CustomButtonWidget(
                text: "Control Unit",
                onPressed: () {
                  Navigator.of(context).pushNamed(ControlUnit.id);
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: CustomButtonWidget(
                text: "View Units",
                onPressed: () {
                  Navigator.of(context).pushNamed(HomeScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
