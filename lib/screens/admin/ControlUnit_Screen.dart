import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moghtareb/Service/fireStoreService/StoreUnit.dart';
import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/screens/admin/EditUnit_Screen.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/widget/Custom_showMenu.dart';

class ControlUnit extends StatefulWidget {
  const ControlUnit({super.key});
  static const String id = 'ControlUnit';

  @override
  State<ControlUnit> createState() => _ControlUnitState();
}

// ignore: prefer_typing_uninitialized_variables
String? docId;

class _ControlUnitState extends State<ControlUnit> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
      body: StreamBuilder<QuerySnapshot>(
        stream: Store().updateUnit(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<UnitModel> units = [];
            for (var doc in snapshot.data!.docs) {
              var unitData = doc.data() as Map<String, dynamic>;
              docId = doc.id;
              units.add(
                UnitModel(
                  unitImages: unitData[kUnitImages] ??
                      'assets/images/Moghtareb-removebg-preview.png',
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
                return GestureDetector(
                  onTapUp: (details) async {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;

                    await showMenu(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [
                        MyPopupMenuItem(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(EditUnit.id,
                                arguments: units[index]);
                            Navigator.of(context).pushNamed(
                              EditUnit.id,
                              arguments: units[index],
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        MyPopupMenuItem(
                          onPressed: () {
                            Store().deleteDocument(docId);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: Container(
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
                                      borderRadius: BorderRadius.circular(16)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            units[index].unitPrice,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: kblackColor,
                                                fontWeight: FontWeight.bold),
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
  }
}


