import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/shared/constant.dart';
import 'package:moghtareb/shared/cubit/moghtareb_cubit.dart';

class CustomStackCard extends StatelessWidget {
  const CustomStackCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<MoghtarebCubit, MoghtarebState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoghtarebCubit.get(context);
        return GestureDetector(
          onTap: () {},
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        child: Image.asset(
                          "assets/images/at_house tours.jpeg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          iconSize: 40,
                          onPressed: () {
                            cubit.changeHeartColor();
                            // BlocProvider.of<MoghtarebCubit>(context)
                            //     .changeHeartColor();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: cubit.heartColor,
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Location :  ",
                          style: TextStyle(
                              fontSize: 20,
                              color: kblackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: width * 0.29,
                        ),
                        const Text(
                          "Rooms : ",
                          style: TextStyle(
                              fontSize: 20,
                              color: kblackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Beds : ",
                          style: TextStyle(
                              fontSize: 20,
                              color: kblackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: width * 0.36,
                        ),
                        const Row(
                          children: [
                            Text(
                              "Price : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: kblackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "3,000",
                              style: TextStyle(
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
              ),
            ),
          ),
        );
      },
    );
  }
}
