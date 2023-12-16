import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/screens/Start_Screen.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';
import 'package:moghtareb/widget/CustomButton.dart';
import 'package:moghtareb/widget/CustomTextFormField.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String id = "ProfileScreen";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoghtarebCubit, MoghtarebState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoghtarebCubit.get(context);
        return Scaffold(
          backgroundColor: kgrey2Color,
          appBar: AppBar(
            actions: [
              IconButton(
                  iconSize: 30,
                  onPressed: () {
                    showMenu(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      position: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width, 70, 0, 0),
                      items: [
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.highlight_remove_rounded),
                              SizedBox(
                                width: 8,
                              ),
                              Text('delete account'),
                            ],
                          ),
                        ),
                      ],
                      elevation: 8,
                    ).then((value) {
                      if (value == 'delete') {
                        AwesomeDialog(
                          btnCancelColor: kblueGreyColor,
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'Warning !',
                          desc: 'You Want To Delete Account ?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            cubit.deleteAccount();
                            Navigator.of(context)
                                .pushReplacementNamed(StartScreen.id);
                          },
                        ).show();
                      }
                    });
                  },
                  icon: const CircleAvatar(
                    backgroundColor: kblackColor,
                    child: Icon(Icons.person),
                  )),
            ],
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisSize: MainAxisSize.min,
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              'assets/images/at_house tours.jpeg',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormFieldWidget(
                                hintText: "UserName",
                                labelText: "UserName",
                                controller:
                                    updateProfileUserNameEditingController),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFormFieldWidget(
                                hintText: "Email",
                                labelText: "Email",
                                controller:
                                    updateProfileEmailEditingController),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFormFieldWidget(
                                hintText: "PhoneNumber",
                                labelText: "PhoneNumber",
                                controller:
                                    updateProfilePhoneEditingController),
                          ],
                        ),
                      ),
                      const CustomButtonWidget(text: "Update Profile")
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
