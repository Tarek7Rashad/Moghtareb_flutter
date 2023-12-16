import 'package:flutter/material.dart';
import 'package:moghtareb/shared/constant.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: kgreyColor.withOpacity(.5),
      prefixIcon: const Icon(
        Icons.search,
        size: 20,
        color: kblueGreyColor,
      ),
      hintText: "search",
      hintStyle: const TextStyle(fontSize: 16),
      prefixIconConstraints: const BoxConstraints(
          maxHeight: 40, maxWidth: 40, minWidth: 40, minHeight: 40),
      contentPadding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(maxHeight: 38),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(width: .5, color: kblueGreyColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(width: 1.2, color: kblueGreyColor)),
    ),
              ),
            );
  }
}
