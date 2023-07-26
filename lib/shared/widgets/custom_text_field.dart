import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/shared/colors/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.textEditingController,
      this.onChanged,
      this.hintText,
      this.labelText,
      this.keyboardType,
      this.maxLines,
      this.height,
      this.prefixIcon})
      : super(key: key);

  final TextEditingController textEditingController;
  final Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final double? height;
  final Icon? prefixIcon;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
          color: ConstColors.purple,
        ));

    return Column(
      children: [
        SizedBox(
          height: widget.height ?? Get.height * 0.06,
          child: TextField(
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.keyboardType,
            controller: widget.textEditingController,
            onChanged: widget.onChanged,
            style: TextStyle(color: ConstColors.purple, fontSize: 18),
            decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                fillColor: ConstColors.white,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: ConstColors.purple),
                labelText: widget.labelText,
                labelStyle: TextStyle(color: ConstColors.purple),
                focusedBorder: border,
                enabledBorder: border,
                border: border),
          ),
        ),
      ],
    );
  }
}
