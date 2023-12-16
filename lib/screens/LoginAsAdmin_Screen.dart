// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:moghtareb/screens/admin/AdminHome_Screen.dart';
import 'package:moghtareb/screens/Login_Screen.dart';
import 'package:moghtareb/screens/SignUp_Screen.dart';
import 'package:moghtareb/shared/components/showSnackBar.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';
import 'package:moghtareb/widget/CustomButton.dart';
import 'package:moghtareb/widget/CustomTextFormField.dart';

class LoginAsAdminScreen extends StatefulWidget {
  static const String id = 'LoginAsAdminScreen';
  const LoginAsAdminScreen({super.key});
  @override
  State<LoginAsAdminScreen> createState() => _LoginScreenState();
}

bool passwordObscureText3 = true;
bool idObscureText3 = true;

bool loading = false;

class _LoginScreenState extends State<LoginAsAdminScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<MoghtarebCubit, MoghtarebState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoghtarebCubit.get(context);
        return SafeArea(
          child: ModalProgressHUD(
            progressIndicator: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kgreyColor,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: kblueGreyColor,
                  strokeWidth: 4,
                ),
              ),
            ),
            inAsyncCall: loading,
            child: Scaffold(
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
              body: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                child: Form(
                  autovalidateMode: adminAutovalidateMode,
                  key: adminFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 30, bottom: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .7,
                      color: kgreyColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: kblackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            CustomTextFormFieldWidget(
                              validate: (value) {
                                if (value!.isEmpty ||
                                    cubit.adminEmail != 'admin@gmail.com') {
                                  return "Invalid Email";
                                } else {}
                                return null;
                              },
                              onChanged: (value) {
                                cubit.adminEmail = value;
                              },
                              hintText: "Email",
                              labelText: "Email",
                              controller: adminEmailEditingController,
                            ),
                            SizedBox(
                              height: height * .001,
                            ),
                            CustomTextFormFieldWidget(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Invalid Password";
                                } else {
                                  // log(value);
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cubit.adminPassword = value;
                              },
                              obscureText: passwordObscureText3,
                              suffix: IconButton(
                                  onPressed: () {
                                    if (passwordObscureText3 &&
                                        adminPasswordEditingController
                                            .text.isNotEmpty) {
                                      passwordObscureText3 = false;
                                      setState(() {});
                                    } else {
                                      passwordObscureText3 = true;
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                              hintText: "Password",
                              labelText: "Password",
                              controller: adminPasswordEditingController,
                            ),
                            SizedBox(
                              height: height * .001,
                            ),
                            CustomTextFormFieldWidget(
                              validate: (value) {
                                if (value!.isEmpty ||
                                    cubit.Id !=
                                        'lJ9lQBj3mwORRHgKmaYTrjMnOYi1') {
                                  return "Invalid Id";
                                } else {
                                  // log(value);
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cubit.adminId = value;
                              },
                              obscureText: idObscureText3,
                              suffix: IconButton(
                                  onPressed: () {
                                    if (idObscureText3 &&
                                        adminIdEditingController
                                            .text.isNotEmpty) {
                                      idObscureText3 = false;
                                      setState(() {});
                                    } else {
                                      idObscureText3 = true;
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                              hintText: "Id",
                              labelText: "Id",
                              controller: adminIdEditingController,
                            ),
                            CustomButtonWidget(
                                text: "Sign in",
                                onPressed: () async {
                                  try {
                                    if (adminFormKey.currentState!.validate()) {
                                      loading = true;
                                      setState(() {});
                                      await cubit.adminSignIn();
                                      Navigator.pushReplacementNamed(
                                          context, AdminHome.id);
                                      adminEmailEditingController.clear();
                                      adminPasswordEditingController.clear();
                                      adminIdEditingController.clear();
                                    } else {
                                      adminAutovalidateMode =
                                          AutovalidateMode.always;
                                      setState(() {});
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                                      showSnackBar(context,
                                          'email or password is invalid');
                                    } else if (e.code == 'wrong-password') {
                                      showSnackBar(context,
                                          'wrong password provided for that user');
                                    } else if (!RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@gmail\.com$')
                                        .hasMatch(cubit.adminEmail)) {
                                      showSnackBar(context,
                                          'enter valid email or password');
                                    } else {
                                      showSnackBar(context, 'wrong password');
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                    showSnackBar(context, 'Error');
                                  }
                                  loading = false;
                                  setState(() {});
                                }),
                            SizedBox(
                              height: height * .001,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(LoginScreen.id);
                                },
                                child: const Text(
                                  "i'm user",
                                  style: TextStyle(
                                      fontSize: 18, color: kblueGreyColor),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                          fontSize: 18, color: kblueGreyColor),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(SignUpScreen.id);
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 18, color: kblueGreyColor),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
