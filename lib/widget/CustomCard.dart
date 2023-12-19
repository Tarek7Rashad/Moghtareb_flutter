import 'package:flutter/material.dart';
import 'package:moghtareb/shared/constant.dart';

class CustomStackCard extends StatelessWidget {
  const CustomStackCard({
    super.key,
    required this.location,
    required this.price,
    required this.rooms,
    required this.beds, required this.image,
  });
  final String location, price, rooms, beds,image;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        child: Stack(children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: Image.asset(
                      "$image",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Location :  $location",
                        style: TextStyle(
                            fontSize: 20,
                            color: kblackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: width * 0.29,
                      ),
                      Text(
                        "Rooms : $rooms",
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
                      Text(
                        "Beds : $beds",
                        style: TextStyle(
                            fontSize: 20,
                            color: kblackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: width * 0.36,
                      ),
                      Row(
                        children: [
                          Text(
                            "Price : ",
                            style: TextStyle(
                                fontSize: 20,
                                color: kblackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "$price",
                            style: TextStyle(
                                fontSize: 20,
                                color: kblackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   right: 30,
          //   bottom: 10,
          //   child: IconButton(
          //       color: color,
          //       iconSize: 30,
          //       onPressed: () {
          //         BlocProvider.of<MoghtarebCubit>(context)
          //             .changeHeartColor();

          //         if (cubit.heartRedColor) {
          //           color = Colors.red;
          //         } else {
          //           color = Colors.black;
          //         }
          //       },
          //       icon: const Icon(Icons.favorite)),
          // )
        ]),
      ),
    );
  }
}
