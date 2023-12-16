import 'package:flutter/material.dart';
import 'package:moghtareb/shared/constant.dart';


class EditingUnit extends StatelessWidget {
  const EditingUnit({
    super.key,
  });
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
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: Image.asset(
                      "assets/images/at_house tours.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Location : ",
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
  }
}
