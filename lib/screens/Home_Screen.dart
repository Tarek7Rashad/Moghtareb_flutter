import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/Service/fireStoreService/StoreUnit.dart';
import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/screens/Favorite_Screen.dart';
import 'package:moghtareb/screens/Login_Screen.dart';
import 'package:moghtareb/screens/Profile_Screen.dart';
import 'package:moghtareb/screens/UnitDetails.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';
import 'package:moghtareb/widget/CustomSearchBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = "HomePage";

  @override
  Widget build(BuildContext context) {
    // Color color = Colors.black;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                          value: 'profile',
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Profile'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'signout',
                          child: Row(
                            children: [
                              Icon(Icons.logout_rounded),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Sign out'),
                            ],
                          ),
                        ),
                      ],
                      elevation: 8,
                    ).then((value) {
                      if (value == 'signout') {
                        AwesomeDialog(
                          btnCancelColor: kblueGreyColor,
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          desc: 'Are You Sure To Sign Out ?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.clear();
                            cubit.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },
                        ).show();
                      } else if (value == 'profile') {
                        Navigator.of(context).pushNamed(ProfilePage.id);
                      }
                    });
                  },
                  icon: const CircleAvatar(
                    backgroundColor: kblackColor,
                    child: Icon(Icons.person),
                  )),
              IconButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pushNamed(FavoriteScreen.id);
                  },
                  icon: Icon(Icons.favorite))
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
                const Expanded(child: CustomSearchBar()),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: Store().updateUnit(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                List<UnitModel> units = [];
                for (var doc in snapshot.data!.docs) {
                  var unitData = doc.data() as Map<String, dynamic>;
                  units.add(
                    UnitModel(
                      unitImages: unitData[kUnitImages] ??
                          'assets/images/hand-holding-house.png',
                      unitLocation: unitData[kUnitLocation],
                      unitPrice: unitData[kUnitPrice],
                      unitDescription: unitData[kUnitDescription],
                      unitRooms: unitData[kUnitRooms],
                      unitBeds: unitData[kUnitBeds],
                    ),
                  );
                }

                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 32),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(UnitInfo.id, arguments: units[index]);
                        },
                        child:
                            //  Stack(
                            //   children: [
                            Container(
                          width: double.infinity,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                color: kgreyColor.withOpacity(.1),
                                spreadRadius: 5,
                                offset: const Offset(10, 10))
                          ]),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: units[index].unitImages.isNotEmpty
                                          ? Image.asset(
                                              units[index].unitImages,
                                              height: 300,
                                              width: 400,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              'assets/images/Moghtareb-removebg-preview.png',
                                              height: 300,
                                              width: 400,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: height * .03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Location : ${units[index].unitLocation}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: kblackColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                          Text(
                                            "Rooms : ${units[index].unitRooms}   ",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: kblackColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width * .05,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Beds : ${units[index].unitBeds}  ",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: kblackColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Price : ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: kblackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                units[index].unitPrice,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: kblackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   right: 10,
                        //   bottom: 10,
                        //   child: IconButton(
                        //       color: color,
                        //       iconSize: 30,
                        //       onPressed: () {
                        //         BlocProvider.of<MoghtarebCubit>(context,
                        //                 listen: false)
                        //             .changeHeartColor(context, index);

                        //         if (cubit.heartRedColor ) {
                        //           color = Colors.red;
                        //         } else {
                        //           color = Colors.black;
                        //         }
                        //       },
                        //       icon: const Icon(Icons.favorite)),
                        // )
                        // ],
                        // ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Container(
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
                );
              }
            },
          ),
        );
      },
    );
  }
}
