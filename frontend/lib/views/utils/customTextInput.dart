
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({
    required String hintText,
    Key? key,
  })  : _hintText = hintText,
        super(key: key);

  final String _hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: TextStyle(
            color: AppColor.placeholder,
          ),
          contentPadding: const EdgeInsets.only(left: 40),
        ),
      ),
    );
  }
}
