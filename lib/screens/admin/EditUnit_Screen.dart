import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moghtareb/Service/fireStoreService/StoreUnit.dart';
import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/screens/admin/ControlUnit_Screen.dart';

import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/widget/CustomButton.dart';
import 'package:moghtareb/widget/CustomTextFormField.dart';

class EditUnit extends StatefulWidget {
  const EditUnit({super.key});
  static const String id = 'EditUnit';

  @override
  State<EditUnit> createState() => _EditUnitState();
}

class _EditUnitState extends State<EditUnit> {
  late String unitImages, unitLocation, description, price, rooms, beds;

  @override
  Widget build(BuildContext context) {
    late UnitModel unitModel =
        ModalRoute.of(context)!.settings.arguments as UnitModel;

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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            key: updateUnitFormKey,
            autovalidateMode: updateUnitAutovalidateMode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: kgreyColor),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                children: [
                  CustomTextFormFieldWidget(
                    controller: updateUnitImagesEditingController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Invalid Images";
                      }
                      return null;
                    },
                    hintText: "Images",
                    labelText: "Images",
                    initialValue: updateUnitImagesEditingController.text =
                        unitModel.unitImages,
                    onChanged: (value) {
                      unitImages = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: updateUnitLocationEditingController,
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
                    initialValue: updateUnitLocationEditingController.text =
                        unitModel.unitLocation,
                    onChanged: (value) {
                      unitLocation = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: updateUnitPriceEditingController,
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
                    initialValue: updateUnitPriceEditingController.text =
                        unitModel.unitPrice,
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: updateUnitDescriptionEditingController,
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
                    initialValue: updateUnitDescriptionEditingController.text =
                        unitModel.unitDescription,
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: updateUnitRoomsEditingController,
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
                    initialValue: updateUnitRoomsEditingController.text =
                        unitModel.unitRooms,
                    onChanged: (value) {
                      rooms = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextFormFieldWidget(
                    controller: updateUnitBedsEditingController,
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
                    initialValue: updateUnitBedsEditingController.text =
                        unitModel.unitBeds,
                    onChanged: (value) {
                      beds = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomButtonWidget(
                    text: 'Update',
                    onPressed: () {
                      // print(docId);
                      try {
                        if (updateUnitFormKey.currentState!.validate()) {
                          updateUnitFormKey.currentState!.save();
                          Store().editUnit(
                              ({
                                kUnitImages: unitImages,
                                kUnitPrice: price,
                                kUnitDescription: description,
                                kUnitLocation: unitLocation,
                                kUnitRooms: rooms,
                                kUnitBeds: beds,
                              }),
                              docId as String);
                          setState(() {});
                        } else {
                          updateUnitAutovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      } on Exception catch (e) {
                        log("this error from addUnit Button $e");
                      }

                      updateUnitImagesEditingController.clear();
                      updateUnitBedsEditingController.clear();
                      updateUnitDescriptionEditingController.clear();
                      updateUnitLocationEditingController.clear();
                      updateUnitPriceEditingController.clear();
                      updateUnitRoomsEditingController.clear();
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
