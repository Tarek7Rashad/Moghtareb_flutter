import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';
import 'package:moghtareb/widget/CustomCard.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  static const String id = 'FavoriteScreen';
  @override
  Widget build(BuildContext context) {
    List<UnitModel> units2 = BlocProvider.of<MoghtarebCubit>(context).units2;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Back To Home',
              style: TextStyle(fontSize: 18, color: Colors.black)),
        ),
        body: units2.isNotEmpty
            ? ListView.builder(
                itemCount: units2.length,
                itemBuilder: (context, index) {
                  if (units2.isNotEmpty) {
                    return CustomStackCard(
                      beds: units2[index].unitBeds,
                      location: units2[index].unitLocation,
                      price: units2[index].unitPrice,
                      rooms: units2[index].unitRooms,
                      image: units2[index].unitImages,
                    );
                  }
                  return null;
                },
              )
            : const Center(
                child: Text(
                  'There Is No Unit',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ));
  }
}
