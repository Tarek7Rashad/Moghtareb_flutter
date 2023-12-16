import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moghtareb/Service/fireStoreService/StoreUnit.dart';
import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/widget/CustomButton.dart';
import 'package:moghtareb/widget/CustomTextFormField.dart';

class AddUnit extends StatefulWidget {
  static const String id = "AddUnit";

  const AddUnit({super.key});

  @override
  State<AddUnit> createState() => _AddUnitState();
}
//  UnitModel unitModel;

class _AddUnitState extends State<AddUnit> {
  String? unitImages, unitLocation, description, price, rooms, beds, unitId;

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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            key: addUnitFormKey,
            autovalidateMode: addUnitAutovalidateMode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: kgreyColor),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                children: [
                  CustomTextFormFieldWidget(
                    controller: addUnitImagesEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Images";
                      } else {
                        // log(value);
                      }
                      return null;
                    },
                    hintText: "Images",
                    labelText: "Images",
                    onChanged: (value) {
                      unitImages = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: addUnitLocationEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Location";
                      } else {
                        // log(value);
                      }
                      return null;
                    },
                    hintText: "Location",
                    labelText: "Location",
                    onChanged: (value) {
                      unitLocation = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: addUnitPriceEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Price";
                      } else {
                        // log(value);
                      }
                      return null;
                    },
                    hintText: "Price",
                    labelText: "Price",
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: addUnitDescriptionEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Description";
                      } else {
                        // log(value);
                      }
                      return null;
                    },
                    hintText: "Description",
                    labelText: "Description",
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: addUnitRoomsEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Number Of Rooms";
                      } else {
                        // log(value);
                      }
                      return null;
                    },
                    hintText: "Rooms",
                    labelText: "Rooms",
                    onChanged: (value) {
                      rooms = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: addUnitBedsEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Number Of Beds";
                      } else {
                        // log(value);
                      }
                      return null;
                    },
                    hintText: "Beds",
                    labelText: "Beds",
                    onChanged: (value) {
                      beds = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomButtonWidget(
                    text: 'Add',
                    onPressed: () {
                      try {
                        if (addUnitFormKey.currentState!.validate()) {
                          addUnitFormKey.currentState!.save();
                          setState(() {});
                          Store().addUnit(
                            UnitModel(
                              unitLocation: unitLocation!,
                              unitPrice: price!,
                              unitDescription: description!,
                              unitRooms: rooms!,
                              unitBeds: beds!,
                              unitImages: unitImages!,
                            ),
                          );
                        } else {
                          addUnitAutovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      } on Exception catch (e) {
                        log("this error from addUnit Button $e");
                      }

                      addUnitImagesEditingController.clear();
                      addUnitBedsEditingController.clear();
                      addUnitDescriptionEditingController.clear();
                      addUnitLocationEditingController.clear();
                      addUnitPriceEditingController.clear();
                      addUnitRoomsEditingController.clear();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
