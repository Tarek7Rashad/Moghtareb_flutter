import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/shared/components/showSnackBar.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';
import 'package:moghtareb/widget/CustomButton.dart';

class UnitInfo extends StatefulWidget {
  const UnitInfo({super.key});

  @override
  State<UnitInfo> createState() => _UnitInfoState();

  static const String id = 'UnitId';
}

class _UnitInfoState extends State<UnitInfo> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    late UnitModel unitModel =
        ModalRoute.of(context)!.settings.arguments as UnitModel;

    return BlocConsumer<MoghtarebCubit, MoghtarebState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Image.asset(unitModel.unitImages),
                    SizedBox(height: height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Location : ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          unitModel.unitLocation,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Description : ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          unitModel.unitDescription,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Price : ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          unitModel.unitPrice,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Rooms : ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          unitModel.unitRooms,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Beds : ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          unitModel.unitBeds,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    SizedBox(
                        height: 120,
                        child: CustomButtonWidget(
                            onPressed: () {
                              BlocProvider.of<MoghtarebCubit>(context)
                                  .addToFavorite(unitModel);

                              showSnackBar(context, 'Added');
                            },
                            text: "Add To Favorate".toUpperCase()))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
